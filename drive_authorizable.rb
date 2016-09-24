require_relative 'authorizable'
require 'google/apis/drive_v3'

module DriveAuthorizable
  include Authorizable

  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY

  def authorize
    authorize_scope(SCOPE)
  end

end