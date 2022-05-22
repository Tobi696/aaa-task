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
      body: RefreshIndicator(
        onRefresh: () async => loadClub(),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : club == null
                ? Center(child: Text(error!))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 210,
                          color: Colors.grey.shade800,
                          child: Stack(
                            children: [
                              Center(
                                child: Image(
                                  image: club!.image,
                                  height: 120,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Text(
                                  club!.country,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyText1,
                                  children: [
                                    TextSpan(
                                      text: "${"Der Club".i18n} ",
                                    ),
                                    TextSpan(
                                      text: club!.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          " ${"aus".i18n} ${club!.country} ${"hat einen Wert von".i18n} ${"%d Millionen".plural(club!.value)} ${"Euro".i18n}.",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${club!.name} ${"konnte bislang".i18n} ${"%d Siege".plural(club!.europeanTitles)} ${"auf europäischer Ebene erreichen".i18n}.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
