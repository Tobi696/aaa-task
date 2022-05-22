import 'package:i18n_extension/i18n_extension.dart';

extension Localizations on String {
  static final _t = Translations("de_de") +
      {
        "de_de": "Club wurde nicht gefunden",
      } +
      {
        "de_de": "Fehler beim Laden der Clubs",
      } +
      {
        "de_de": "Laden...",
      } +
      {
        "de_de": "Kein Club gefunden",
      } +
      {
        "de_de": "Der Club",
      } +
      {
        "de_de": "aus",
      } +
      {"de_de": "hat einen Wert von"} +
      {
        "de_de": "%d Millionen".one("1 Million").many("%d Millionen"),
      } +
      {
        "de_de": "Euro",
      } +
      {
        "de_de": "konnte bislang",
      } +
      {
        "de_de":
            "%d Siege".zero("keinen Sieg").one("einen Sieg").many("%d Siege"),
      } +
      {
        "de_de": "auf europäischer Ebene erreichen",
      };

  String get i18n => localize(this, _t);

  String plural(value) => localizePlural(value, this, _t);
}
