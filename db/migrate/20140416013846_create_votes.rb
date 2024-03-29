class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id
      t.string :voteable_type
      t.integer :voteable_id
      # alternative syntax below
      # t.references :voteable, polymorpic: true
      t.timestamps
    end
  end
end
