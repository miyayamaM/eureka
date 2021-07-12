unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:s3_access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:s3_secret_access_key],
      region: 'ap-northeast-1'
    }

    config.fog_public  = false
    config.fog_directory  = 'bucket-eureeeeka'
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  end
end
