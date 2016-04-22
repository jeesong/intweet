class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def note_created_callback
    request.body.rewind
    if request.body.present?
      notification = JSON.parse(request.body.read)
      webhook_note = WebhookNote.new(
        link: notification["data"]["item"]["links"]["conversation_web"],
        body: notification["date"]["item"]["conversation_parts"]["conversation_parts"][0]["body"],
        name: notification["date"]["item"]["user"]["name"],
        email: notification["date"]["item"]["user"]["email"],
        requested_at: notification["date"]["item"]["conversation_parts"]["conversation_parts"][0]["created_at"]
      )
      webhook_note.save!
    end
    render :nothing => true
  end

  def index
    @webhook_note_requests = WebhookNote.all
  end
end
