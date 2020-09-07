class DeviseMailer < Devise::Mailer
  include AbstractController::Callbacks
  before_action :add_inline_attachment!
  helper EmailHelper
  layout 'email'
  default from: 'kanwartestemail@gmail.com'

  private

  def add_inline_attachment!
    attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
  end

end
