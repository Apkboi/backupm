import 'package:mentra/core/_core.dart';

class FieldValidators {
  static String? createPasscodeValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field Cannot Be empty';
    } else if (value.length < 8) {
      return "Password should be at least 8 characters";
    } else {
      return null;
    }
  }

  static String? updatePasscodeValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field Cannot Be empty';
    } else if (value.length < 8) {
      return "Password should be at least 8 characters";
    } else {
      return null;
    }
  }

  static String? pinCodeValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field Cannot Be empty';
    } else if (value.length != 4 && value.length != 6) {
      return "Pin incomplete";
    } else {
      return null;
    }
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field Cannot Be empty';
    } else if (!value.isEmail && !value.isNumericOnly) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  static String? optionalEmailValidator(String? value) {
    if (!value!.isEmail) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  static String? notEmptyValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field Cannot Be empty';
    } else {
      return null;
    }
  }

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field Cannot Be empty';
    } else if (!value.replaceAll(' ', '').isAlphabetOnly &&
        !value.contains('-')) {
      return "Only Alphabets allowed";
    } else {
      return null;
    }
  }

  static String? phoneNumberValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field Cannot Be empty';
    } else if (!value.isNumericOnly) {
      return "Only Numbers allowed";
    } else if (value.trim().length < 11) {
      return "Phone Numbers must be 11 digits";
    } else {
      return null;
    }
  }

  static String? numberValidator(String? value) {
    if (value!.isEmpty) {
      return 'Field Cannot Be empty';
    } else if (!value.isNum) {
      return "Only Numbers allowed";
    } else {
      return null;
    }
  }
}
