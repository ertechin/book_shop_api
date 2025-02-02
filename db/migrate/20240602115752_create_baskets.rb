class CreateBaskets < ActiveRecord::Migration[7.1]
  def change
    create_table :baskets do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :data, null: false, default: {}
      t.timestamps
    end
  end
end
