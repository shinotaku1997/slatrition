require 'ruby/openai'

OpenAI/configure do |config|
    config.access_token = Rails.application.credentials.openai[:chatgpt_api_key]
end