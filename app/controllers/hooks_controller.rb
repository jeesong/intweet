class HooksController < ApplicationController
  def note_created_callback
    # render text: "Thanks for sending POST request"
    request.body.rewind
    puts request.body.read
    # data = JSON.parse request.body.read

    # if request.body.present?
    #   webhook_note = WebhookNote.new(payload: request.body.read)
    #   webhook_note.save!
    # end
    # render :nothing => true

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
    # show the model
    @webhook_note_requests = WebhookNote.all
  end
end
