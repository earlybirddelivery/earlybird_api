require 'fcm'
$fcm = FCM.new(Rails.application.credentials.dig(:firebase, :server_key))
