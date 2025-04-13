class TitleValidator {
  String? validate({required String? title}) {
    if (title == null || title.trim().isEmpty) {
      return 'The title field can not be empty';
    }
    if (title.trim().length < 2) {
      return 'The title needs at least 2 characters';
    }
    return null;
  }
}
