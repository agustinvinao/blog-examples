module ApplicationHelper
  def afv_javascript
    javascript_tag('angular.module("angularFormValidator", ["angularFormValidator.controllers"]);angular.module("angularFormValidator.controllers", []).controller("angularFormValidatorCntl", ["$scope", function($scope) {}]);')
  end
  def afv_form_submit(model)
    {'ng-disabled' => "#{afv_form_name(model)}.$invalid"}
  end
  def afv_form_name (model)
    "#{model.to_s.downcase}_form"
  end
  def afv_field_validators(model, field_name)
    options = {'ng-model' => "#{model.to_s.downcase}.#{field_name.to_s}"}
    field_validations = model.validations.select{|i| i[:field_name]==field_name}
    field_validations.each do |validation|
      case validation[:class]
        when 'PresenceValidator' then
          options['required'] = 'required'
        when 'FormatValidator' then
          options['ng-pattern'] = "/#{validation[:options][:with].source}/i"
      end
    end
    options
  end
  def afv_validate_form?(model)
    AngularValidation.configuration.models.include?(model.to_s)
  end
  def afv_ng_attributes(model)
    if afv_validate_form? model
      {'ng-app' => AngularValidation.configuration.ng_application_name, 'ng-controller' => AngularValidation.configuration.ng_controller_name}
    else
      {}
    end
  end
end
