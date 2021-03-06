$(function() {

  var ajaxPost = function(url, callback, params) {
    var toSend = params ? params : {};
    $.ajax({
      method: 'POST',
      url: url,
      data: toSend,
      success: function(data){
        if(callback) callback(data);
      }
    });
  };

  // Vue.config.debug = true;
  if($('#attendance').length > 0) {
    // window.onbeforeunload = function() { return 'No querías hacer eso'; };

    var doorCounter = Vue.extend({
      data: function() {
        return {
          doorCounter: window.doorCounter,
          eventId: window.eventId
        }
      },
      computed: {
        unregistered_url: function() {
          return '/events/' + this.eventId + '/arrival_count';
        },
        registered_url: function() {
          return '/events/' + this.eventId + '/registered_count';
        }
      },
      methods: {
        nonRegisteredArrival: function() {
          this.doorCounter += 1;
          ajaxPost(this.unregistered_url, function(){}, {door_counter: this.doorCounter});
          this.$dispatch('attendee-arrived');
        },
        nonRegisteredError: function() {
          if(this.doorCounter > 0) {
            this.doorCounter -= 1;
            ajaxPost(this.unregistered_url, function(){}, {door_counter: this.doorCounter});
            this.$dispatch('attendee-gone');
          }
        },
        attendeeGone: function() {
          this.$dispatch('attendee-gone');
        },
        registeredArrival: function() {
          this.registeredArrivals += 1;
          ajaxPost(this.registered_url);
          this.$dispatch('attendee-arrived');
        }
      }
    });

    var registrantSearch = Vue.extend({
      data: function() {
        return {
          search: '',
          registrants: window.registrants,
          eventId: window.eventId,
          selected: null,
          signedIn: [],
          paidAtTheDoor: [],
          passesWithCover: window.passesWithCover
        }
      },
      methods: {
        select: function(registrant) {
          this.selected = registrant;
          this.$dispatch('user-selected');
        },
        signIn: function(registrant) {
          registrant.signed_in = true;
          var pendingNotifications = this.signedIn;
          pendingNotifications.push(registrant);
          var index;
          for (index = 0; index < pendingNotifications.length; ++index) {
            var regToNotify = pendingNotifications[index];
            ajaxPost('/registrants/' + regToNotify.id + '/sign_in', function() {
              pendingNotifications.$remove(regToNotify);
            });
          }
          this.done();
        },
        passCovers: function(pass) {
          return this.passesWithCover.indexOf(pass) > -1;
        },
        done: function() {
          this.$dispatch('user-done');
          this.search = '';
          this.selected = null;
        },
        backFromSelection: function() {
          this.selected = null;
        },
        backFromSearch: function() {
          this.search = '';
          this.$dispatch('back');
        },
        pay: function(registrant) {
          registrant.paid = true;
          var pendingNotifications = this.paidAtTheDoor;
          pendingNotifications.push(registrant);
          var index;
          for (index = 0; index < pendingNotifications.length; ++index) {
            var regToNotify = pendingNotifications[index];
            ajaxPost('/registrants/' + regToNotify.id + '/pay', function() {
              pendingNotifications.$remove(regToNotify);
            }, {event_id: this.eventId});
          }
        }
      }
    });


    var attendance = new Vue({
      el: '#attendance',
      data: {
        registeredCounter: window.registeredAttendees,
        showingSearch: false,
        userSelected: false,
        currentAttendees: window.currentAttendeeCount
      },
      components: {
        'door-counter': doorCounter,
        'registrant-search': registrantSearch,
      },
      methods: {
        showSearch: function() {
          this.showingSearch = true;
        },
        reset: function() {
          this.userSelected = false;
          this.showingSearch = false;
        },
        changeAttendees: function(number) {
          this.currentAttendees += number;
          var url = '/events/' + window.eventId + '/attendee_count';
          ajaxPost(url, function(){}, {current_attendee_count: this.currentAttendees});
        },
        addRegisteredCount: function() {
          ajaxPost('/events/' + window.eventId + '/registered_count');
        }
      },
      events: {
        'user-selected': function() {
          this.userSelected = true;
        },
        'user-done': function() {
          this.reset();
          this.registeredCounter += 1;
          this.changeAttendees(1);
          this.addRegisteredCount();
        },
        'back': function() {
          this.reset();
        },
        'attendee-arrived': function() {
          this.changeAttendees(1);
        },
        'attendee-gone': function() {
          this.changeAttendees(-1);
        }
      }
    })

  }

})
