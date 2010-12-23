class FullNameValidator < ActiveModel::Validator
  def validate(record)
    [:first_name, :last_name].each do |attribute|
      value = record.send(attribute)
      record.errors[attribute] << "can't be blank" if value.blank?
      record.errors[attribute] << "has invalid characters" unless value =~ /^[a-zA-Z\-\ ]*?$/
    end
  end
end
