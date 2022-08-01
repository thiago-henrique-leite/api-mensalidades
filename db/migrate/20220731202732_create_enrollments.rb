class CreateEnrollments < ActiveRecord::Migration[6.1]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: true
      t.integer :installments
      t.integer :due_day
      t.decimal :amount

      t.timestamps
    end
  end
end
