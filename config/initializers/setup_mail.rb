ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => false,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "humbroll.com",
  :user_name => "",
  :password => "",
  :authentication => :login
}
