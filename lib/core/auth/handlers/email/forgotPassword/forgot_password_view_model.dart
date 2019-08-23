import 'package:ezsale/core/common/app_exception.dart';
import 'package:ezsale/core/validators/validator.dart';
import 'package:ezsale/core/validators/validate_if.dart';
import 'package:ezsale/core/validators/email_validator.dart' as emailValidator;

class ViewModel {
  ViewModel({this.email}) {
    _validator = new Validator();
    _validator.validations.add(() => validateEmail(email));
  }

  bool emptyTextValidation = false;

  String email = '';

  Validator _validator;

  String validateEmail(String value) =>
    validateIfNotEmpty(emptyTextValidation, value, emailValidator.validate);

  void validateAll() {
    emptyTextValidation = true;
    var errors = _validator.validate();
    if (errors != null && errors.length > 0) {
      throw new AppException(errors);
    }
  }
}
