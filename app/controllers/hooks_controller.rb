class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def note_created_callback
    # render text: "Thanks for sending POST request"
    # data = JSON.parse request.body.read

    request.body.rewind
    if request.body.present?
      webhook_note = WebhookNote.new(payload: request.body.read)
      webhook_note.save!
    end
    render :nothing => true

    # @webhook_note = WebhookNote.new(payload: request.body.read)
    # if @webhook_note.save
    #   render json: @webhook_note, status: :created
    # else
    #   render json: @webhook_note.errors, status: :unprocessable_entity
    # end
    # render :index
    # or save the request into a model & render nothing
  end

  def index
    @webhook_note_requests = WebhookNote.all
  end
end
