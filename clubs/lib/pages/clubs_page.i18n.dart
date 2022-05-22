import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("de_de") +
      {
        "de_de": "all about clubs",
      } +
      {
        "de_de": "%d Millionen".one("1 Million").many("%d Millionen"),
      };

  String get i18n => localize(this, _t);

  String plural(value) => localizePlural(value, this, _t);
}
