class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def note_created_callback
    request.body.rewind
    notification = JSON.parse(request.body.read)
    # check body to see category of message -> set category
    body = notification["data"]["item"]["conversation_parts"]["conversation_parts"][0]["body"]
    name = notification["data"]["item"]["user"]["name"] == nil ? "Lead" : notification["data"]["item"]["user"]["name"]
    email = notification["data"]["item"]["user"]["email"] == "" ? "No email" : notification["data"]["item"]["user"]["email"]
    if body.include?("#bug")
      webhook_note = WebhookNote.new
      webhook_note.category = "BUG"
      webhook_note.link = notification["data"]["item"]["links"]["conversation_web"]
      webhook_note.body = body
      webhook_note.name = name
      webhook_note.email = email
      webhook_note.requested_at = notification["data"]["item"]["conversation_parts"]["conversation_parts"][0]["created_at"]
      webhook_note.save!
    elsif body.include?("#feature request")
      webhook_note = WebhookNote.new
      webhook_note.category = "FR"
      webhook_note.link = notification["data"]["item"]["links"]["conversation_web"]
      webhook_note.body = body
      webhook_note.name = name
      webhook_note.email = email
      webhook_note.requested_at = notification["data"]["item"]["conversation_parts"]["conversation_parts"][0]["created_at"]
      webhook_note.save!
    end
    # check body to see product -> set product(s)
    if body.include?("acquire")
      webhook_note.acquire = true
      webhook_note.save!
    end
    if body.include?("engage")
      webhook_note.engage = true
      webhook_note.save!
    end
    if body.include?("learn")
      webhook_note.learn = true
      webhook_note.save!
    end
    if body.include?("platform")
      webhook_note.platform = true
      webhook_note.save!
    end
    if body.include?("support")
      webhook_note.support = true
      webhook_note.save!
    end
    render :nothing => true
  end

  def index
    @webhook_note_requests = WebhookNote.all
  end
end
