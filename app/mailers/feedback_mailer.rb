class FeedbackMailer < ApplicationMailer
  def feedback_message(feedback)
    recipients = recipients_from_string SettingProvider.instance.
                                                        value_of(:manager_email)
    if recipients.blank?
      raise StandardError, "There is no correct manager_email."
    end

    @feedback = feedback

    mail(to: recipients, subject: "Feedback from #{@site_name}") do |format|
      format.html
      format.text
    end
  end
end
