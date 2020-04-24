require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user, activated: false) }

  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(user) }

    let(:text_body) do
      part = mail.body.parts.detect {|part| part.content_type == 'text/plain; charset=UTF-8'}
      part.body.raw_source
    end

    let(:html_body) do
      part = mail.body.parts.detect {|part| part.content_type == 'text/html; charset=UTF-8'}
      part.body.raw_source
    end

    it "renders the expected headers" do
      expect(mail.subject).to eq("Eureka メールアドレス確認のお願い")
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it "renders the expected body" do
      expect(text_body).to match("#{user.name}様")
      expect(text_body).to match("新しいEurekaアカウントが作成されました")

      expect(html_body).to match("#{user.name}様")
      expect(html_body).to match("新しいEurekaアカウントが作成されました")
    end
  end

  describe "password_reset" do

    it "renders the headers" do
    
    end

    it "renders the body" do
     
    end
  end

end
