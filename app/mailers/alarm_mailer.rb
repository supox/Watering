class AlarmMailer < ActionMailer::Base
  default from: "noreply@sprinklers.com"
  
  def alarm_email(alarm)
    @alarm=alarm
    sprinkler=alarm.sensor.sprinkler
    to=sprinkler.users.map(&:email)
    mail(:to => to, :subject => I18n.t(:new_alarm))
  end
end
