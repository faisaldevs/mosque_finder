import 'package:flutter/material.dart';

class Event {
  final String id;
  final String title;
  final String categoryId;
  final String hijriDate;
  final String gregorianDate;
  final String time;
  final String location;
  final String description;
  final int attending;
  final bool featured;
  final Color color;
  bool rsvpd;

  Event({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.hijriDate,
    required this.gregorianDate,
    required this.time,
    required this.location,
    required this.description,
    required this.attending,
    required this.color,
    this.featured = false,
    this.rsvpd = false,
  });
}
