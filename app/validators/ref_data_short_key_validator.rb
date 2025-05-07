class RefDataShortKeyValidator < ActiveModel::EachValidator
  def initialize(options)
    @data_type = options[:data_type]
    super
  end

  def validate_each(record, attribute, value)
    return if value.nil?
    return unless ReferenceDatum.where('data_type = ? and short_key = ?', @data_type, value).count.zero?

    record.errors.add(attribute,
                      "is not a valid reference data short key of type #{@data_type}, value provided:#{value}"
                     )
  end
end
