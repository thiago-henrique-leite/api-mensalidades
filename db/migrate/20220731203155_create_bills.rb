class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.references :enrollment, null: false, foreign_key: true
      t.decimal :amount
      t.date :due_date
      t.string :status, default: 'open'

      t.timestamps
    end
  end
end
