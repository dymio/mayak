class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@example.com"
  layout 'mailer'
  # a lot of useful email templates you will find at https://github.com/mailchimp/email-blueprints

  before_action :get_site_name

  private

  def get_site_name
    @site_name = SettingProvider.instance.value_of :site_name
  end
end
