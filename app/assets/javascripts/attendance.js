$(function() {

  Vue.config.debug = true;
  if($('#attendance').length > 0) {

    var doorCounter = Vue.extend({
      data: function() {
        return {
          doorCounter: 0
        }
      },
      methods: {
        nonRegisteredArrival: function() {
          this.doorCounter += 1;
          return this.doorCounter;
        },

        nonRegisteredError: function() {
          if(this.doorCounter > 0) {
            this.doorCounter -= 1;
          }
          return this.doorCounter;
        }
      }
    });

    var registrantSearch = Vue.extend({
      data: function() {
        return {
          search: '',
          registrants: window.registrants,
          selected: null
        }
      },
      methods: {
        select: function(registrant) {
          this.selected = registrant;
          this.$dispatch('user-selected');
        }
      }
    });


    var attendance = new Vue({
      el: '#attendance',
      data: {
        registeredCounter: 0,
        showingSearch: false,
        userSelected: false
      },
      components: {
        'door-counter': doorCounter,
        'registrant-search': registrantSearch
      },
      methods: {
        fullCount: function() {
          return this.doorCounter + this.registeredCounter;
        },
        registeredArrival: function() {
          this.registeredCounter += 1;
          return this.registeredCounter;
        },
        showSearch: function() {
          this.showingSearch = true;
        }
      },
      events: {
        'user-selected': function() {
          this.userSelected = true;
        }
      }
    })

  }

})
