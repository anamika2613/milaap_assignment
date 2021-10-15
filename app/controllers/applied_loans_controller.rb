class AppliedLoansController < ApplicationController
  
  def new
    @applied_loan = AppliedLoan.new 
  end
  
  def create
    @applied_loan = AppliedLoan.new applied_loan_params
    if @applied_loan.save
      flash[:notice] = "Record saved successfully!"
      redirect_to root_path 
    else
      flash[:danger] = @applied_loan.errors.full_messages
      render :new
    end
  end
  

  protected 

  def applied_loan_params
    params.require(:applied_loan).permit(:email, :pan_card, :aadhar_number,:bank_account_number, 
      :ifsc_code, :monthly_recurring_inflow, :monthly_recurring_outflow)
  end

end
