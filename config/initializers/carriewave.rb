unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAUK4LYSXCJQI746X3',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'bucket-eureeeeka'
    config.cache_storage = :fog
  end
end