require 'razorpay'
$razor_pay = Razorpay.setup(Rails.application.credentials.dig(:razor_pay, :key_id),
                            Rails.application.credentials.dig(:razor_pay, :key_secret)
                           )
