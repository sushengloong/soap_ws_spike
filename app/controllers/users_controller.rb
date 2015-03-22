class UsersController < ApplicationController
  soap_service namespace: 'urn:Users'

  soap_action "list",
    args: nil,
    return: :string
  def list
    render soap: User.all.to_xml
  end

  soap_action "create",
    args: { username: :string, fullname: :string, email: :string, role: :string },
    return: :boolean
  def create
    render soap: ( User.create(params.slice(:username, :fullname, :email, :role)) ? 1 : 0 )
  end
end
