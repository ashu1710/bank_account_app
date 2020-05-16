// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require popper
//= require turbolinks
//= require bootstrap
//= require toastr
//= require jquery.validate
//= require jquery.validate.additional-methods 
//= require_tree .



$( document ).on('turbolinks:load', function() {
	submitSignUpForm();
    onlyNumberAllow();
    addMoney();
    moneyDeposit();
    moneyTransfer();
});

function submitSignUpForm(){
	$('.btn-signup, .btn-login, .btn-forget-password, .btn-forget-password').click(function(){
		$('#new_user').validate({
		    rules: {
		    	'user[email]':{
		    		required: true,
		    		email: true
		    	},
                'user[password]': {
                    required: true,
                    minlength: 6
                },
                'user[password_confirmation]': {
                    equalTo: "#user_password"
                }
            },
            messages: {
                'user[password_confirmation]': "Enter Confirm Password Same as Password"
            }
		});
	});
}

function onlyNumberAllow(){
    $('.amount-field').keypress(function(event){
       if((event.which != 8 && isNaN(String.fromCharCode(event.which))) || $('.amount-field').val().length > 8 ){
           event.preventDefault(); 
       }
    });
}

function addMoney(){
    $('.btn-add-money').click(function(){
        $(this).addClass('disabled');
        $('.card_div').removeClass('d-none');
    });

    $('.btn-add-card-payment').click(function(){
        $('.card_form').validate({
            rules: {
                'card[amount]':{
                    required: true,
                    min: 1,
                    max: 500000
                },
                'card[card_num]':{
                    required: true,
                    minlength: 12,
                    maxlength: 12,
                },
                'card[month]': {
                    required: true,
                    minlength: 1,
                    maxlength: 2,
                    max: 12
                },
                'card[year]': {
                    required: true,
                    minlength: 4,
                    maxlength: 4,
                    min: new Date().getFullYear()
                },
                'card[cvv]': {
                    required: true,
                    minlength: 3,
                    maxlength: 3
                },
            }
        });
    });
     $("#card_card_num, #card_month, #card_year, #card_cvv, #account_acc_number, #account_acc_balance, #transaction_acc_number, #transaction_amount").keypress(function(event){
       if((event.which != 8 && isNaN(String.fromCharCode(event.which)))){
           event.preventDefault(); 
       }
    });
}

function moneyTransfer(){
    $('.btn-transfer-money').click(function(){
        $('#new_account').validate({
            rules: {
                'account[acc_number]':{
                    required: true
                },
                'account[acc_balance]':{
                    min: 1,
                    required: true,
                    max: parseInt($('#balance').val())
                },
            }
        });
    });
}

function moneyDeposit(){
    $('.btn-deposit').click(function(){
        $('#new_transaction').validate({
            rules: {
                'transaction[acc_number]':{
                    required: true
                },
                'transaction[ifsc_code]':{
                    minlength: 5,
                    required: true,
                },
                'transaction[amount]':{
                    min: 1,
                    required: true,
                    max: parseInt($('#balance').val())
                },
            }
        });
    });
}