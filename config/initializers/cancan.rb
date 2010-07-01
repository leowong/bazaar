#OPTIMIZE There must be a better way to internationalize cancan error messages.
module CanCan
  class AccessDenied < Error
    def initialize(message = nil, action = nil, subject = nil)
      @message = message
      @action = action
      @subject = subject
      @default_message = I18n.t('cancan.unauthorized')
    end
  end
end
