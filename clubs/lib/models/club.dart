import 'package:flutter/material.dart';

class Club {
  final String id;
  final String name;
  final String country;
  final int value;
  final String imageUrl;
  final int europeanTitles;
  ImageProvider get image => NetworkImage(imageUrl);

  Club({
    required this.id,
    required this.name,
    required this.country,
    required this.value,
    required this.imageUrl,
    required this.europeanTitles,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      value: json['value'],
      imageUrl: json['image'],
      europeanTitles: json['european_titles'],
    );
  }
}
