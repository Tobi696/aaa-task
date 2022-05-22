import 'package:clubs/api.dart';
import 'package:clubs/models/club.dart';
import 'package:clubs/pages/club_page.i18n.dart';
import 'package:flutter/material.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({Key? key, required this.clubId}) : super(key: key);
  final String clubId;

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  Club? club;
  String? error;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadClub();
  }

  void loadClub() async {
    loading = true;
    try {
      final clubs = await Api.instance.getClubs();
      Club? foundClub;
      for (var club in clubs) {
        if (club.id == widget.clubId) {
          foundClub = club;
          break;
        }
      }
      if (foundClub != null) {
        setState(() {
          club = foundClub;
        });
      } else {
        error = "Club wurde nicht gefunden".i18n;
      }
    } on Exception {
      error = "Fehler beim Laden der Clubs".i18n;
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(error ?? club?.name ?? "Laden...".i18n),
      ),
    );
  }
}
