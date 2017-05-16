class AddAttachmentUserAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :user_avatar
    end
  end

  def self.down
    remove_attachment :users, :user_avatar
  end
end
