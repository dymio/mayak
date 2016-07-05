class FeedbackController < FrontendController
  def new
    @seo_carrier ||= OpenStruct.new(title: I18n.t('defaults.page_titles.feedback'))
    @feedback = Feedback.new
  end

  def create
    @seo_carrier ||= OpenStruct.new(title: I18n.t('defaults.page_titles.feedback'))
    @feedback = Feedback.new(feedback_params)

    # robots detections with fake surname field
    robot_detected = params[:feedback] && params[:feedback][:surname].present?

    respond_to do |format|
      if @feedback.valid?
        # flag to show success message instead feedback form in the view
        @success_feedback = true

        # Can be raised error during email delivery, as example:
        # Net::SMTPFatalError (550 Message was not accepted -- invalid mailbox.
        # Local mailbox nefedova.polina@list.ru is unavailable: user is terminated)
        # use begin..rescue..end if you need continue execution any way
        FeedbackMailer.feedback_message(@feedback).deliver unless robot_detected

        format.html { render action: 'new' }
        format.json { render json: @feedback, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :message)
  end
end
