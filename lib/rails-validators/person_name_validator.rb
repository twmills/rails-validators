class PersonNameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "has invalid characters" unless value =~ /^[a-zA-Z\-\ ]*?$/
  end
end
