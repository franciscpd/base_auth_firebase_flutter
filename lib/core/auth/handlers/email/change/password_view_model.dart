import 'package:ezsale/core/validators/validator.dart';
import 'package:ezsale/core/common/app_exception.dart';
import 'package:ezsale/core/validators/validate_if.dart';
import 'package:ezsale/core/validators/password_validator.dart' as passwordValidator;
import 'package:ezsale/core/validators/words_match_validator.dart' as passwordsMatchValidator;

class ViewModel {
  ViewModel() {
    _validator = new Validator();

    _validator.validations.add(() => validatePassword(currentPassword));
    _validator.validations.add(() => validatePassword(newPassword));
    _validator.validations.add(() => validatePassword(newPasswordConfirm));
    _validator.validations.add(() => validatePasswordsMatch(newPassword, newPasswordConfirm));
  }

  bool emptyTextValidation = false;

  String currentPassword = '';
  String newPassword = '';
  String newPasswordConfirm = '';

  Validator _validator;

  String validatePassword(String value) => validateIfNotEmpty(
      emptyTextValidation, value, passwordValidator.validate);

  String validatePasswordsMatch(String value1, String value2) =>
      passwordsMatchValidator.validate(value1, value2,
          customOnError: "Passwords do not match");

  void validateAll() {
    var errors = _validator.validate();
    if (errors != null && errors.length > 0) {
      throw new AppException(errors);
    }
  }
}
