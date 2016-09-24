require_relative 'authorizable'

module CalendarAuthorizable
  include Authorizable

  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

  def authorize
    authorize_scope(SCOPE)
  end

end