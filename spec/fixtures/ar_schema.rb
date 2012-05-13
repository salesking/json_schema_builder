# encoding: utf-8
ActiveRecord::Schema.define(:version => 0) do

  create_table :users do |t|
    t.integer :number
    t.string :name, :limit => 128
    t.decimal :amount, :precision => 16, :scale => 4
    t.boolean :is_admin
    t.text :notes
    t.date :birthday
    t.timestamps
  end
end