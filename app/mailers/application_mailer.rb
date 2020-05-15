# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@eureeeeka.com'
  layout 'mailer'
end
