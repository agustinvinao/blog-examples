module AngularValidation
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :models, :ng_application_name, :ng_controller_name

    def initialize
      @models               = []
      @ng_application_name  = 'angularFormValidator'
      @ng_controller_name   = 'angularFormValidatorCntl'
    end
  end
end

afv_config_file = File.join(Rails.root,'config','afv.yml')
afv_config = YAML.load_file(afv_config_file)[Rails.env].symbolize_keys

AngularValidation.configure do |config|
  config.models               = afv_config[:models]
  config.ng_application_name  = afv_config[:ng_application] if afv_config[:ng_application]
  config.ng_controller_name   = afv_config[:ng_controller]  if afv_config[:ng_controller]
end


module ModelValidators
  module ClassMethods
    def validations
      validators.map{|v| {class: v.class.to_s.split('::').last, field_name: v.attributes.first, options: v.options}}
    end
  end
  def self.included(base)
    base.extend(ClassMethods)
  end
end

afv_config[:models].each do |model|
  model.constantize.send :include, ModelValidators
end

# Notas
# Contact.column_names    devuelve los nombres de las columnas
# ["id", "name", "email", "message", "created_at", "updated_at"]

# Contact.validators      devuelve los validadores que tiene definido el objeto
#[#<ActiveRecord::Validations::PresenceValidator:0x007fbf9d2aad50
#  @attributes=[:name],
#  @options={}>,
#  #<ActiveRecord::Validations::PresenceValidator:0x007fbf9d2a9810
#  @attributes=[:email],
#  @options={}>,
#  #<ActiveRecord::Validations::UniquenessValidator:0x007fbf9d2a8758
#  @attributes=[:email],
#  @klass=
#    Contact(id: integer, name: string, email: string, message: text, created_at: datetime, updated_at: datetime),
#  @options={:case_sensitive=>true}>,
#  #<ActiveModel::Validations::FormatValidator:0x007fbf9d2b37c0
#  @attributes=[:email],
#  @options={:with=>/A([^@s] )@((?:[-a-z0-9] .)[a-z]{2,})Z/i}>]

# La aplicacion Angular tendria que tomar la definicion de los campos del modelo
# tomar los validadores definidos y generar el formulario.
