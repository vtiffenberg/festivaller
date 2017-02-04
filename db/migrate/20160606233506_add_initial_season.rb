class AddInitialSeason < ActiveRecord::Migration
  def up
    s = Season.create name: '2016', start_date: Date.parse('2016-05-13'), end_date: Date.parse('2016-05-15'), current: true

    Event.update_all(season_id: s.id)
    Pass.update_all(season_id: s.id)
    Discount.update_all(season_id: s.id)
    Registrant.update_all(season_id: s.id)
  end
  def down
    Season.first.destroy
  end
end
