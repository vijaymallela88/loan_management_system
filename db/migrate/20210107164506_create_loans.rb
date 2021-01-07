class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.string :customer_name
      t.string :loan_amount
      t.string :processing_fee
      t.date :disbursement_date
      t.string :rate_of_interest
      t.integer :term
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
