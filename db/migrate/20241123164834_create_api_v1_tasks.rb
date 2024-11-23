class CreateApiV1Tasks < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_tasks do |t|
      t.string :name
      t.boolean :finished

      t.timestamps
    end
  end
end
