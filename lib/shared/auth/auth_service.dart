import 'package:to_do_app/shared/validators/title_validator.dart';

class Auth {
  final TitleValidator _titleValidator = TitleValidator();

  submitForm(String? title) {
    final titleError = _titleValidator.validate(title: title);

    return titleError;
  }
}
