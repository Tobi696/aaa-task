import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("de_de") +
      {
        "de_de": "Nicht gefunden",
      } +
      {
        "de_de": "Diese Seite existiert nicht.",
      };
  String get i18n => localize(this, _t);
}
