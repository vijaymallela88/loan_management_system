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
  	#(p x r x (1+r)**n)/((1+r)**(n-1))
  	@loans = Loan.loan_details(@loan)
  	
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
