require 'ruby/openai'

class OpenaiService
    def initialize
        @client = OpenAI::Client.new(access_token: Rails.application.credentials.openai[:chatgpt_api_key])
    end

    def chat(prompt)
end
