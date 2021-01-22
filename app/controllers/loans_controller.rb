class LoansController < ApplicationController
  before_action :set_loan, only: [:edit, :update, :destroy]
  before_action :resources, only: [:index, :show]

  def index
  	@loans = resources
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
  	@loan = resources
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

  def resources
    LoanQuery.call(Loan.all, params)
  end

  def loan_params
  	params.require(:loan).permit!
  end
end
