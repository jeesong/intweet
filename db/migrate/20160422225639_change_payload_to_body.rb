class ChangePayloadToBody < ActiveRecord::Migration
  def change
    rename_column :webhook_notes, :payload, :body
  end
end
