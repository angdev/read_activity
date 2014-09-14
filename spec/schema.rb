ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    t.string :name
    t.timestamps
  end

  create_table :articles, force: true do |t|
    t.string :subject
    t.text :content
    t.timestamps
  end
end