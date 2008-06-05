ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => 587,
	:domain => "gmail.com",
	:authentication => :plain,
	:user_name => "no-reply@codevader.com",
	:password => "d9e3fqe34",
	:raise_delivery_errors => true
}