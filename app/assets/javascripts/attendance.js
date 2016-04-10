$(function() {

  var ajaxPost = function(url, callback, params) {
    var toSend = params ? params : {};
    $.ajax({
      method: 'POST',
      url: url,
      data: toSend,
      success: function(data){
        callback(data);
      }
    });
  };

  // Vue.config.debug = true;
  if($('#attendance').length > 0) {

    var doorCounter = Vue.extend({
      data: function() {
        return {
          doorCounter: window.doorCounter,
          eventId: window.eventId
        }
      },
      computed: {
        url: function() {
          return '/events/' + this.eventId + '/arrival_count';
        }
      },
      methods: {
        nonRegisteredArrival: function() {
          var url = this.url;
          this.doorCounter += 1;
          ajaxPost(url, function(){}, {door_counter: this.doorCounter});
        },
        nonRegisteredError: function() {
          if(this.doorCounter > 0) {
            this.doorCounter -= 1;
            var url = this.url;
            ajaxPost(url, function(){}, {door_counter: this.doorCounter});
          }
        }
      }
    });

    var registrantSearch = Vue.extend({
      data: function() {
        return {
          search: '',
          registrants: window.registrants,
          selected: null,
          signedIn: [],
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
              pendingNotifications.remove(regToNotify);
            });
          }
          this.done();
        },
        passCovers: function(pass) {
          return this.passesWithCover.indexOf(pass) > 0;
        },
        done: function() {
          this.selected = null;
          this.$dispatch('user-done');
        },
        backFromSelection: function() {
          this.selected = null;
        },
        backFromSearch: function() {
          this.$dispatch('back');
        }
      }
    });


    var attendance = new Vue({
      el: '#attendance',
      data: {
        registeredCounter: window.registeredAttendees,
        showingSearch: false,
        userSelected: false
      },
      components: {
        'door-counter': doorCounter,
        'registrant-search': registrantSearch
      },
      methods: {
        showSearch: function() {
          this.showingSearch = true;
        },
        reset: function() {
          this.userSelected = false;
          this.showingSearch = false;
        }
      },
      events: {
        'user-selected': function() {
          this.userSelected = true;
        },
        'user-done': function() {
          this.reset();
          this.registeredCounter += 1;
        },
        'back': function() {
          this.reset();
        }
      }
    })

  }

})
