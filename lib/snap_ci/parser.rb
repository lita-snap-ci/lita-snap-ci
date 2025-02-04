require 'multi_json'
require_relative 'translations'

module SnapCi
  class Parser
    include Translations

    ERROR_PARAMETERS = {
      'result' => t('parser.error', { locale: :en }),
      'stages' => nil
    }

    def initialize(response)
      set_pipeline(MultiJson.load(response.body))
    end

    def to_parameters
      {
        status: @pipeline['result'],
        steps: @pipeline['stages']
      }
    end

    private

    def set_pipeline(body)
      @pipeline = if !body.has_value? 'Resource not found!'
                    body['_embedded']['pipelines'].last
                  else
                    ERROR_PARAMETERS
                  end
    end
  end
end
