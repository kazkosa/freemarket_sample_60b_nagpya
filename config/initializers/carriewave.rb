require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test? #開発とテストは今まで通りに
    config.storage = :file
  elsif Rails.env.production? #本番はS3に保存する
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      
      #AWSのアクセスキーとシークレットキーを環境変数で定義する
      provider: 'AWS',
      # aws_access_key_id: eval(Rails.application.credentials.aws[:aws_access_key_id]),
      # aws_secret_access_key: eval(Rails.application.credentials.aws[:aws_secret_access_key]),
      # secret_key_base: eval(Rails.application.credentials.secret_key_base),
      aws_access_key_id: Rails.application.credentials.aws[:aws_access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:aws_secret_access_key],
      secret_key_base: Rails.application.credentials.secret_key_base,
      region: 'ap-northeast-1'#'AWSで設定した地域（日本はおそらく'ap-northeast-1') '
    }
    config.fog_directory  = 'backet191006' #S3のバケット名'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/backet191006'
  end
end