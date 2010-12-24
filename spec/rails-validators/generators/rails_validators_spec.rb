require 'spec_helper' 
require 'generator-spec'

require 'generators/rails_validators/rails_validators_generator'

RSpec::Generator.configure do |config|
  config.debug = true
  config.remove_temp_dir = true
  config.default_rails_root(__FILE__) 
  config.lib = File.dirname(__FILE__) + '/../lib'
  config.logger = :stdout  # :file
end

def available_validators
  [:email, :email_format, :url_format, :company_name, :person_name, :account_number, :name, :currency]
end

def generated_validator_files
  available_validators.map {|name| "#{name}_validator.rb" }
end

def generated_files *names
  names.map {|name| "#{name}_validator.rb" }
end

describe 'Rails Validators generator' do
  use_helpers :special, :files
    
  setup_generator :rails_validator do
    tests RailsValidatorsGenerator
  end

  describe "Run it!" do
    before :each do
      @generator = with_generator do |g|    
        g.run_generator "currency email account_number".args
      end
    end

    it "should have create validator files in app/validators" do
      vfiles = generated_files(:currency, :email, :account_number)
      (validator_files.file_names - vfiles).should be_empty
    end    
  end
end

describe 'Rails Validators generator' do
  use_helpers :special, :files
    
  setup_generator :rails_validator do
    tests RailsValidatorsGenerator
  end

  describe "Run it!" do
    before :each do
      @generator = with_generator do |g|    
        g.run_generator
      end
    end

    it "should have create validator files in app/validators" do
      (validator_files.file_names - generated_validator_files).should be_empty
    end    
  end
end
