class TransactionsController < ApplicationController
	before_action :authenticate_user!
	def withdraw
		@card = current_user.cards.new
	end

	def transfer
		@account = Account.new
	end

	def deposit
		@transaction = Transaction.new
	end

	def create
		transaction = Transaction.new(transaction_params)
		if transaction.save
			amount = current_user.account.acc_balance.to_i - params[:transaction][:amount].to_i
			current_user.account.update(acc_balance: amount)
			flash[:success] = "Money Deposit successfully."
			redirect_to transactions_path
		else
			flash[:error] = "Money not Deposit due to some error.try after some time"
			redirect_to deposit_path
		end
	end

	def index
		@transactions = Transaction.where("to_account_num = ? OR from_account_num = ?",current_user.account.acc_number,  current_user.account.acc_number)
	end

	private

	def transaction_params
		params[:transaction][:transaction_date] =  Date.today
		params[:transaction][:transactions_type] = "Deposit"
		params[:transaction][:to_account_num] = current_user.account.acc_number
		params.require(:transaction).permit(:acc_number, :amount, :ifsc_code, :transaction_date, :transactions_type, :to_account_num)
	end
end
