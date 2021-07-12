require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_public  = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: "AKIAUK4LYSXCDM5XI6WV",
    aws_secret_access_key: "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",
    region: 'ap-northeast-1',
    path_style: true
  }
  config.fog_directory  = 'bucket-eureeeeka'
  config.asset_host = 'https://duh86hz37ecb2.cloudfront.net'
end
