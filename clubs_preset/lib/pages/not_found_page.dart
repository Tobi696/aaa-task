import 'package:clubs_preset/pages/not_found_page.i18n.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nicht gefunden".i18n),
      ),
      body: Center(
        child: Text("Diese Seite existiert nicht.".i18n),
      ),
    );
  }
}
