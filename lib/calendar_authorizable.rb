require 'google_authorizer'
require 'google/apis/calendar_v3'

module CalendarAuthorizable
  include GoogleAuthorizer

  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

  def authorize
    authorize_scope(SCOPE, 'google-ruby-calendar')
  end

end