class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]

  def index
  	@loans = Loan.all
  end

  def new
  	@loan = Loan.new
  end

  def create
  	@loan = Loan.new(loan_params)
  	if @loan.save
  		flash[:notice] = "Customer data created successfully."
  	else
  		flash[:alert] = "Something went wrong!"
  	end
  		redirect_to loans_path
  end

  def edit
  end

  def update
  	if @loan.update(loan_params)
  		flash[:notice] = "Customer data updated successfully."
  	else
  		flash[:alert] = "Something went wrong!"
  	end
  		redirect_to loans_path
  end

  def show
  	@loans = []
  	#(p x r x (1+r)**n)/((1+r)**(n-1))
  	loan_release_date = @loan.disbursement_date
  	loan_emi_start_date = loan_release_date
  	remaining_amount = @loan.loan_amount.to_f
  	term = @loan.term.to_i
  	interest = @loan.rate_of_interest.to_f
  	total_loan_interest = (@loan.loan_amount.to_f*(interest/100)*(1+(interest/100))**term)/((1+(interest/100))**(term-1))/2
  	emi_amount = (@loan.loan_amount.to_f + total_loan_interest.to_i)/term
  	@loan.term.times do
  		loan_arr = []
  	  interest_amount = ((remaining_amount.to_f/term)/100)*interest
  	  principal_amount = emi_amount - interest_amount
  		loan_arr << loan_emi_start_date.next_month.beginning_of_month.strftime("%d/%m/%Y")
  		loan_arr << remaining_amount.round(2)
  		loan_arr << principal_amount.round(2)
  		loan_arr << interest_amount.round(2)
  		loan_arr << (principal_amount + interest_amount).round(2)
  		rem_amount = (remaining_amount - principal_amount).round(2)
  		rem_amount = 0.00 if rem_amount < 0
  		loan_arr << rem_amount
  		@loans << loan_arr
  		remaining_amount = (remaining_amount - principal_amount).round(2)
  		loan_emi_start_date = loan_emi_start_date.next_month.beginning_of_month
  	end
  end

  def destroy
    if @loan.destroy
    	flash[:notice] = "Customer data destroyed successfully."
    else
    	flash[:alert] = "Something went wrong!"
    end
  		redirect_to loans_path
  end

  private
  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loan_params
  	params.require(:loan).permit!
  end

end
