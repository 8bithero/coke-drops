class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :message_id
      t.string :message
      t.boolean :censored
      t.decimal :sentiment
      t.string :user_handle
      t.datetime :sent_at
      t.integer :counter, default: 1

      t.timestamps null: false
    end
  end
end
