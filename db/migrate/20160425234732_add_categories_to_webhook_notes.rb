class AddCategoriesToWebhookNotes < ActiveRecord::Migration
  def change
    add_column :webhook_notes, :category, :text
    add_column :webhook_notes, :acquire, :boolean
    add_column :webhook_notes, :engage, :boolean
    add_column :webhook_notes, :learn, :boolean
    add_column :webhook_notes, :platform, :boolean
    add_column :webhook_notes, :support, :boolean
  end
end
