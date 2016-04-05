class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      intercom_create_event(@micropost)
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

      def micropost_params
        params.require(:micropost).permit(:content, :picture)
      end

      def correct_user
        @micropost = current_user.microposts.find_by(id: params[:id])
        redirect_to root_url if @micropost.nil?
      end

      def intercom_create_event(post)
        intercom = Intercom::Client.new(app_id: ENV['INTERCOM_APP_ID'], api_key: ENV['INTERCOM_API_KEY'])
        intercom.events.create(
          event_name: "created-micropost",
          created_at: Time.now.to_i,
          email: post.user.email
        )
      end
end
