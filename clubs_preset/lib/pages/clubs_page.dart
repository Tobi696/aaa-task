import 'dart:async';
import 'package:clubs_preset/api.dart';
import 'package:clubs_preset/models/club.dart';
import 'package:clubs_preset/pages/clubs_page.i18n.dart';
import 'package:flutter/material.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  SortMode sortMode = SortMode.nameAsc;
  List<Club>? clubs;
  StreamController<dynamic>? clubsStreamController;

  @override
  void initState() {
    super.initState();
    clubsStreamController = StreamController<dynamic>.broadcast();
    loadClubs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadClubs() async {
    try {
      setClubs(await Api.instance.getClubs());
    } on Exception {
      showBaseErrorDialog(context);
    }
  }

  void setClubs(List<Club>? pClubs) {
    if (pClubs != null) {
      clubs = pClubs;
    }
    if (clubs == null) return;
    clubs!.sort((a, b) {
      if (sortMode == SortMode.nameAsc) {
        return a.name.compareTo(b.name);
      } else if (sortMode == SortMode.valueDesc) {
        return b.value.compareTo(a.value);
      }
      return 0;
    });
    clubsStreamController!.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("all about clubs".i18n),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              if (sortMode == SortMode.nameAsc) {
                sortMode = SortMode.valueDesc;
              } else if (sortMode == SortMode.valueDesc) {
                sortMode = SortMode.nameAsc;
              }
              setClubs(null);
            },
          ),
        ],
      ),
      body: clubsStreamController == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => loadClubs(),
              child: StreamBuilder<dynamic>(
                stream: clubsStreamController!.stream,
                builder: (context, _) {
                  if (clubs != null && clubs!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: clubs!.length,
                      itemBuilder: (context, index) => ClubTile(
                        club: clubs![index],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
    );
  }
}

class ClubTile extends StatelessWidget {
  final Club club;

  const ClubTile({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/clubs/${club.id}"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: club.image,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    club.name,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    club.country,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "%d Millionen".plural(club.value),
                    style: Theme.of(context).textTheme.headline6!,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum SortMode { nameAsc, valueDesc }

void showBaseErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(
      title: Text('Something went wrong.'),
      content: Text('Pull to refresh to try again.'),
    ),
  );
}
