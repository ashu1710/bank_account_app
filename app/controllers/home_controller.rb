class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
  	@total_deposit = Transaction.where("transactions_type = ? AND (to_account_num = ? OR from_account_num = ?)",'Deposit', current_user.account.acc_number, current_user.account.acc_number ).pluck(:amount).sum
  	@total_withdraw = Transaction.where("transactions_type = ? AND (to_account_num = ? OR from_account_num = ?)",'Withdraw', current_user.account.acc_number, current_user.account.acc_number ).pluck(:amount).sum
  end
end
