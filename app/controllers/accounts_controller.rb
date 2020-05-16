class AccountsController < ApplicationController
	before_action :authenticate_user!
	def create
		if params[:account].present? && params[:account][:acc_number].present?
			account = Account.find_by acc_number: params[:account][:acc_number]
			if account.present?
				to_user_balance = account.acc_balance.to_i  + params[:account][:acc_balance].to_i
				account.update acc_balance: (to_user_balance)
				amount =  current_user.account.acc_balance.to_i - params[:account][:acc_balance].to_i
				account_to = current_user.account.update acc_balance: amount
				Transaction.create(transactions_type: 'Transfer', amount: params[:account][:acc_balance],to_account_num: account.acc_number, from_account_num: current_user.account.acc_number, transaction_date: Date.today )
				flash[:success] = "Money Withdraw successfully."
				redirect_to transactions_path
			else
				flash[:error] = "Account not found"
				redirect_to transfer_path
			end
		else
			flash[:error] = "Money not transfer due to some error"
			redirect_to transfer_path
		end
	end
end
