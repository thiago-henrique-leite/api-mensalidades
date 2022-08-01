class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :cpf, unique: true
      t.date :birthdate
      t.string :payment_method

      t.timestamps
    end
  end
end
