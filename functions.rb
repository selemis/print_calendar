require 'fileutils'
require 'yaml/store'

module Functions

  CONFIGURATION_PATH = File.join(Dir.home, '.credentials',
                                 'calendar-ruby-configuration.yml')

  def read_calendars
    store = YAML::Store.new(CONFIGURATION_PATH)
    store.transaction { store[:calendars] }
  end

  def save_calendars
    calendars = Hash.new

    primary = {    id: 'primary',
        single_events: true,
          max_results: 2500,
             time_min: '2014-01-01T2:00:00-00:00',
             time_max: '2016-12-31T2:00:00-00:00',
            order_by: 'startTime'}
    calendars[:primary] = primary

    #add more calendars here
    store = YAML::Store.new(CONFIGURATION_PATH)
    store.transaction { store[:calendars] = calendars }
  end

  def parse_date(date_boundary)
    unless date_boundary.date.nil?
      DateTime.parse(date_boundary.date, '%Y-%m-%d')
    else
      date_boundary.date_time
    end
  end

end
