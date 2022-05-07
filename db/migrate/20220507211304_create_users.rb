# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: true
      t.string :password_digest, null: false
      t.timestamp :access_at
      t.integer :failed_attempts, default: 0
      t.boolean :locked, default: false

      t.timestamps
    end
  end
end
