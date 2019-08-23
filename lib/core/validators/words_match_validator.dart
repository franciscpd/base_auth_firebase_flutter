String validate(String value, String valueConfirmation, {String customOnError}) {
  if(value != valueConfirmation) {
    return customOnError ?? 'Values do not match';
  }

  return null;
}
