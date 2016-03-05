class FeedbackMailer < ApplicationMailer
  def feedback_message(feedback)
    manager_email = SettingProvider.instance.value_of :manager_email
    unless ValidateEmail.valid?(manager_email)
      raise StandardError, "There is no correct manager_email."
    end
    @feedback = feedback
    mail(to: manager_email, subject: "Feedback from #{@site_name}") do |format|
      format.html
      format.text
    end
  end
end
