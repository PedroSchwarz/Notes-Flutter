class FormValidators {
  static String validateSimpleInput(String value) {
    if (_isEmpty(value))
      return 'This field cannot be empty';
    else
      return null;
  }

  static String validateMultiInput(String value) {
    if (_isEmpty(value))
      return 'This field cannot be empty';
    else if (_isLongerThan15Characters(value))
      return 'This must be longer than 15 characters';
    else
      return null;
  }

  static bool _isEmpty(String value) {
    return value.trim().isEmpty;
  }

  static bool _isLongerThan15Characters(String value) {
    return value.trim().length < 15;
  }
}
