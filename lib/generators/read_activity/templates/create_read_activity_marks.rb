class CreateReadActivityMarks < ActiveRecord::Migration
  def change
    create_table :read_activity_marks do |t|
      t.references :reader, null: false
      t.references :readable, polymorphic: true
      t.integer :mark, default: 0

      t.timestamps
    end
  end
end