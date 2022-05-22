import 'package:i18n_extension/i18n_extension.dart';

extension Localizations on String {
  static final _t = Translations("de_de");

  String get i18n => localize(this, _t);
}
