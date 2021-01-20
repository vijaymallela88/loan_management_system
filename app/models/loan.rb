class Loan < ApplicationRecord

	def self.loan_details(loan)
		loans = []
		loan_release_date = loan.disbursement_date
	  	loan_emi_start_date = loan_release_date
	  	remaining_amount = loan.loan_amount.to_f
	  	term = loan.term.to_i
	  	interest = loan.rate_of_interest.to_f
	  	total_loan_interest = (loan.loan_amount.to_f*(interest/100)*(1+(interest/100))**term)/((1+(interest/100))**(term-1))/2
	  	emi_amount = (loan.loan_amount.to_f + total_loan_interest.to_i)/term
	  	loan.term.times do
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
	  		loans << loan_arr
	  		remaining_amount = (remaining_amount - principal_amount).round(2)
	  		loan_emi_start_date = loan_emi_start_date.next_month.beginning_of_month
	  	end
	  	return loans
	end

end
