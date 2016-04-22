class AddDataToWebhookNotes < ActiveRecord::Migration
  def change
    add_column :webhook_notes, :link, :string
    add_column :webhook_notes, :name, :string
    add_column :webhook_notes, :email, :string
    add_column :webhook_notes, :requested_at, :integer
  end
end
