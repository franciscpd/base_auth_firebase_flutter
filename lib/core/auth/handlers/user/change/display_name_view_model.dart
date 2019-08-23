import 'package:ezsale/core/validators/validator.dart';
import 'package:ezsale/core/common/app_exception.dart';
import 'package:ezsale/core/validators/display_name_validator.dart' as displayNameValidator;

class ViewModel {
  ViewModel({this.displayName}) {
    _validator = new Validator();
    _validator.validations.add(() => validateDisplayName(displayName));
  }

  String displayName;

  Validator _validator;

  String validateDisplayName(String value) =>
      displayNameValidator.validate(value);

  void validateAll() {
    var errors = _validator.validate();
    if (errors != null && errors.length > 0) {
      throw new AppException(errors);
    }
  }
}
