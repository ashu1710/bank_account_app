class CardsController < ApplicationController
	before_action :authenticate_user!
	def create
		@card = current_user.cards.new(card_params)
		if @card.save
			amount = current_user.account.acc_balance.to_i
			current_user.account.update(acc_balance: (amount + @card.amount))
			Transaction.create(transaction_date: Date.today, amount: @card.amount, to_account_num: current_user.account.acc_number, transactions_type: 'Withdraw' ) 
			flash[:success] = "Money Withdraw successfully."
			redirect_to transactions_path
		else
			flash[:error] = "Money not Withdraw due to some error.try after some time"
			redirect_to withdraw_path
		end
	end

	private

	def card_params
		params.require(:card).permit(:amount, :card_num, :month, :year, :cvv)
	end
end
