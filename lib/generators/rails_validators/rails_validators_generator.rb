class RailsValidatorsGenerator < Rails::Generators::Base
  desc "Configures Rails app with Validators"

  argument :names, :type => :array, :default => ['ALL'], :desc => 'Validators to copy into rails app'

  def main_flow
    copy_validators
  end

  protected

  def validator_dir 
    File.expand_path('../../rails-validators', File.dirname(__FILE__))
  end

  def available_validators
    [:email, :email_format, :url_format, :company_name, :person_name, :account_number, :name, :currency]
  end

  def wanted_validators
    return available_validators if names.include? 'ALL'
    names.map(&:to_sym)
  end

  def validators
    available_validators & wanted_validators
  end
    
  def copy_validators
    validators.each do |name|  
      copy_file File.join(validator_dir, "#{name}_validator.rb"), "app/validators/#{name}_validator.rb"
    end
  end
end
