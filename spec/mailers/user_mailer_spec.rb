require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  
  describe "account_activation" do
    let(:user) { FactoryBot.create(:user, activated: false) }
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
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.password_reset(user) }

    let(:text_body) do
      part = mail.body.parts.detect {|part| part.content_type == 'text/plain; charset=UTF-8'}
      part.body.raw_source
    end

    let(:html_body) do
      part = mail.body.parts.detect {|part| part.content_type == 'text/html; charset=UTF-8'}
      part.body.raw_source
    end

    it "renders the headers" do
      user.reset_token = User.new_token
      expect(mail.subject).to eq("Eureka パスワード再設定")
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it "renders the body" do
      user.reset_token = User.new_token
      expect(text_body).to match("#{user.name}様")
      expect(text_body).to match("以下のリンクをクリックしパスワードを再設定してください。")

      expect(html_body).to match("#{user.name}様")
      expect(html_body).to match("以下のリンクをクリックしパスワードを再設定してください。")
    end
  end

end
