$(function() {
  if($('#attendance').length > 0) {
    new Vue({
      el: '#attendance',
      data: {
        search: '',
        registrants: window.registrants,
        doorCounter: 0,
        registeredCounter: 0,
        showingSearch: false
      },
      methods: {
        fullCount: function() {
          return this.doorCounter + this.registeredCounter;
        },
        nonRegisteredArrival: function() {
          this.doorCounter += 1;
          return this.doorCounter;
        },
        registeredArrival: function() {
          this.registeredCounter += 1;
          return this.registeredCounter;
        },
        nonRegisteredError: function() {
          if(this.doorCounter > 0) {
            this.doorCounter -= 1;
          }
          return this.doorCounter;
        },
        showSearch: function() {
          this.showingSearch = true;
        }
      }
    })
  }
})
