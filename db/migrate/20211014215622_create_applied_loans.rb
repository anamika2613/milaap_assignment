class CreateAppliedLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :applied_loans do |t|
      t.string :email
      t.string :pan_card
      t.string :aadhar_number
      t.string :bank_account_number
      t.string :ifsc_code
      t.float :monthly_recurring_inflow, default: 0
      t.float :monthly_recurring_outflow, default: 0
      t.float :credit_limit, default: 0
      t.integer :creditbility_score, default: 0
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
