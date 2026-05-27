import 'package:flutter/material.dart';

class Popup {
  const Popup({
    required this.id,
    required this.title,
    required this.category,
    required this.area,
    required this.address,
    required this.subtitle,
    required this.period,
    required this.heroLabel,
    required this.waitTime,
    required this.entryFee,
    required this.hours,
    required this.distance,
    required this.dday,
    required this.tags,
    required this.colors,
  });

  final String id;
  final String title;
  final String category;
  final String area;
  final String address;
  final String subtitle;
  final String period;
  final String heroLabel;
  final String waitTime;
  final String entryFee;
  final String hours;
  final String distance;
  final String dday;
  final List<String> tags;
  final List<Color> colors;

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'category': category,
    'area': area,
    'address': address,
    'subtitle': subtitle,
    'period': period,
    'heroLabel': heroLabel,
    'waitTime': waitTime,
    'entryFee': entryFee,
    'hours': hours,
    'distance': distance,
    'dday': dday,
    'tags': tags,
  };
}

class PopupReview {
  const PopupReview({
    required this.author,
    required this.date,
    required this.rating,
    required this.body,
  });

  final String author;
  final String date;
  final double rating;
  final String body;
}
