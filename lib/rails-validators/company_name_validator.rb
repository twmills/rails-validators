class CompanyNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "has invalid characters" unless value =~ /^[a-zA-Z0-9\_\-\ ]*?$/
  end
end

