class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    intercom_create_event(current_user, @user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

    def intercom_create_event(follower, following)
      intercom = Intercom::Client.new(app_id: ENV['INTERCOM_APP_ID'], api_key: ENV['INTERCOM_API_KEY'])
      intercom.events.create(
        event_name: "followed-user",
        created_at: Time.now.to_i,
        email: follower.email,
        metadata: {
          following: following.name
        }
      )
    end
end
