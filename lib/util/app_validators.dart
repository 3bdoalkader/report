import 'package:email_validator/email_validator.dart';

String? emailValidator(String? val) {
  return !EmailValidator.validate(val!.trim()) ? 'Invalid Email' : null;
}

String? requiredValidator(String? val) {
  return val!.isEmpty ? 'Fill this field please' : null;
}
