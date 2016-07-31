class AddInitialSeason < ActiveRecord::Migration
  def up
    s = Season.create name: '2016', start_date: Date.parse('2016-05-13'), end_date: Date.parse('2016-05-15'), current: true

    Event.update_all(season: s)
    Pass.update_all(season: s)
    Discount.update_all(season: s)
    Registrant.update_all(season: s)
  end
  def down
    Season.first.destroy
  end
end
