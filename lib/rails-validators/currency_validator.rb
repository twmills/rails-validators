class CurrencyValidator < ActiveModel::EachValidator
  def currencies
    ['usd', 'euro', 'cad']
  end

  def validate_each(record, attribute, value)
    result = case options[:mode]
    when :upper
      currencies.map(&:upcase).include? value.to_s.upcase
    else
      currencies.map(&:downcase).include? value.to_s.downcase
    end
    
    record.errors[attribute] << "is not a valid currency" unless result
  end
end

