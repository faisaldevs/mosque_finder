/// ========================
/// RegExp Patterns
/// ========================
///
final class AppRegExpText {
  AppRegExpText._();

  /// Basic email regex (simple validation)
  static const String simpleEmailPattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  /// Strict RFC-style email validation
  static const String strictEmailPattern =
      r"^(([^<>()[\]\\.,;:\s@']+(\.[^<>()[\]\\.,;:\s@']+)*)|('.+'))@((\[[0-9]{1,3}(\.[0-9]{1,3}){3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";

  /// Phone number regex: handles country code, parentheses, dashes, etc.
  static const String phonePattern =
      r"(\+[0-9]+[- .]*)?(\([0-9]+\)[- .]*)?([0-9][0-9\- .]+[0-9])";

  static bool isValidEmail(String input, {bool strict = true}) {
    final pattern = strict ? strictEmailPattern : simpleEmailPattern;
    return RegExp(pattern).hasMatch(input);
  }

  static bool isValidPhone(String input) {
    return RegExp(phonePattern).hasMatch(input);
  }
}
