import 'package:ezsale/core/validators/validator.dart';
import 'package:ezsale/core/validators/email_validator.dart' as emailValidator;
import 'package:ezsale/core/validators/password_validator.dart' as passwordValidator;
import 'package:ezsale/core/validators/validate_if.dart';
import 'package:ezsale/core/common/app_exception.dart';

class ViewModel {
  ViewModel({this.email, this.password}) {
    _validator = new Validator();
    _validator.validations.add(() => validateEmail(email));
    _validator.validations.add(() => validatePassword(password));
  }

  bool emptyTextValidation = false;

  String email = '';
  String password = '';

  Validator _validator;
  String validateEmail(String value) =>
    validateIfNotEmpty(emptyTextValidation, value, emailValidator.validate);
  String validatePassword(String value) =>
    validateIfNotEmpty(emptyTextValidation, value, passwordValidator.validate);

  void validateAll() {
    emptyTextValidation = true;

    var errors = _validator.validate();
    if (errors != null && errors.length > 0) {
      throw new AppException(errors);
    }
  }
}
