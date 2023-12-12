# frozen_string_literal: true

module ParseJson
  extend ActiveSupport::Concern

  included do
    def parse_json
      self.class.columns_hash.each do |k, v|
        Rails.logger.debug(v.type)
        next unless v.type == :jsonb
        break unless self[k]
        break if self[k].is_a?(Hash)

        parsed_json = JSON.parse(self[k].to_s)

        # rubocop:disable Rails/SkipsModelValidations
        update_column(k.to_sym, parsed_json) if parsed_json
        # rubocop:enable Rails/SkipsModelValidations
      end
    rescue JSON::ParserError
      errors.add('Passed invalid JSON object')
    end
  end
end
