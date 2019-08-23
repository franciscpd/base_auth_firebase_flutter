import 'package:ezsale/core/validators/validator.dart';
import 'package:ezsale/core/common/app_exception.dart';
import 'package:ezsale/core/validators/validate_if.dart';
import 'package:ezsale/core/validators/email_validator.dart' as emailValidator;
import 'package:ezsale/core/validators/password_validator.dart' as passwordValidator;
import 'package:ezsale/core/validators/display_name_validator.dart' as displayNameValidator;
import 'package:ezsale/core/validators/words_match_validator.dart' as passwordMatchValidator;

class ViewModel {
  ViewModel({this.email, this.password}) {
    _validator = new Validator();
    _validator.validations.add(() => validateDisplayName(displayName));
    _validator.validations.add(() => validateEmail(email));
    _validator.validations.add(() => validatePassword(password));
    _validator.validations.add(() => validatePassword(passwordConfirm));
    _validator.validations.add(() => validatePasswordsMatch(password, passwordConfirm));
  }

  bool emptyTextValidation = false;

  String displayName = '';
  String email = '';
  String password = '';
  String passwordConfirm = '';

  Validator _validator;

  String validateDisplayName(String value) =>
    validateIfNotEmpty(emptyTextValidation, value, displayNameValidator.validate);

  String validateEmail(String value) =>
    validateIfNotEmpty(emptyTextValidation, value, emailValidator.validate);

  String validatePassword(String value) =>
    validateIfNotEmpty(emptyTextValidation, value, passwordValidator.validate);

  String validatePasswordsMatch(String value, String valueConfirmation) =>
    passwordMatchValidator.validate(value, valueConfirmation, customOnError: 'Passwords do not match');

  void validateAll() {
    emptyTextValidation = true;

    var errors = _validator.validate();
    if(errors != null && errors.length > 0) {
      throw new AppException(errors);
    }
  }
}
