class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  # a lot of useful email templates you will find at https://github.com/mailchimp/email-blueprints

  before_action :get_site_name

  protected

  # Method splits string of emails by comma or semicolon to array
  #  if it only one email in string method will return string with the email
  def recipients_from_string(emails_str)
    rec_strs = emails_str.to_s.split(/[\;\,]+/)
    rec_strs.map! do |rs|
      ValidateEmail.valid?(rs.strip) ? rs.strip : nil
    end
    rec_strs.compact!
    rec_strs.length == 1 ? rec_strs[0] : rec_strs
  end

  private

  def get_site_name
    @site_name = SettingProvider.instance.value_of :site_name
  end
end
