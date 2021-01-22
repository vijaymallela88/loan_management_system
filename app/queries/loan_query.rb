class LoanQuery
  include LoanDetails
  attr_reader :loans, :params

  def initialize(loans, params)
    @loans = loans
    @params = params
  end

  def self.call(loans, params = {})
    new(loans, params).call
  end

  def call
    return object_query_loan_details if params[:id].present?

    index_query
  end
  
  private

  def index_query
    loans.all
  end
  
  def object_query
    loans.find_by(id: params[:id])
  end

  def object_query_loan_details
    loan_details(object_query)
  end
end
  