$(function() {
  if($('#venue-payment').length > 0) {

    var payments = new Vue({
      el: '#venue-payment',
      data: function() {
        return {
          registered_attendees: window.registered_attendes,
          unregistered_attendees: window.unregistered_attendes,
          ticket: 0,
          venue_cut: 0.3,
          musician_count: 0
        }
      },
      computed: {
        result: function() {
          return "$ " + this.ticket * this.venue_cut * (this.registered_attendees + this.unregistered_attendees - 2 - this.musician_count)
        }
      }
    })
  }
})
