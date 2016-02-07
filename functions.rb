require 'fileutils'
require 'yaml/store'

module Functions

  CONFIGURATION_PATH = File.join(Dir.home, '.credentials',
                                 'calendar-ruby-configuration.yaml')

  def read_calendars
    store = YAML::Store.new(CONFIGURATION_PATH)
    store.transaction { store[:calendars] }
  end

  def save_calendars
    calendars = Hash.new
    calendars[:primary] = 'primary'
    #add more calendars here
    store.transaction { store[:calendars] = calendars}
  end

  def parse_date(date_boundary)
    unless date_boundary.date.nil?
      DateTime.parse(date_boundary.date, '%Y-%m-%d')
    else
      date_boundary.date_time
    end
  end

end