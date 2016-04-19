class CreateWebhookNotes < ActiveRecord::Migration
  def change
    create_table :webhook_notes do |t|
      t.text :payload

      t.timestamps null: false
    end
  end
end
