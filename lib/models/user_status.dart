import 'dart:math';

import 'package:flutter/material.dart';

// KUADRAN AROUSED/POSITIVE
// bersemangat
// percaya diri
// senang
// berharap

// KUADRAN PASSIVE/POSITIVE
// lega
// rileks
// puas
// kalem

// KUADRAN AROUSED/NEGATIVE
// marah
// takut
// stress
// frustrasi

// KUADRAN PASSIVE/NEGATIVE
// kecewa
// sedih
// depresi
// bosan

enum MoodLabels {
  percaya_diri,
  bersemangat,
  senang,
  berharap,
  lega,
  puas,
  santai,
  tenang,
  marah,
  takut,
  kesal,
  stress,
  sedih,
  kecewa,
  bosan,
  depresi,
}

// percaya diri   bersemangat   | marah          takut
// senang         berharap      | kesal          stress
// ------------------------------------------------------
// lega           puas          | sedih          kecewa
// santai         tenang         | bosan          depresi

class UserStatus {
  final int id;
  final DateTime date;
  final int mood;
  final MoodLabels emotion;
  final String text;

  UserStatus({
    required this.id,
    required this.date,
    required this.mood,
    required this.emotion,
    required this.text,
  });

  static const Map<MoodLabels, String> mapMoodLabels = {
    MoodLabels.percaya_diri: 'percaya diri',
    MoodLabels.bersemangat: 'bersemangat',
    MoodLabels.senang: 'senang',
    MoodLabels.berharap: 'berharap',
    MoodLabels.lega: 'lega',
    MoodLabels.puas: 'puas',
    MoodLabels.santai: 'santai',
    MoodLabels.tenang: 'tenang',
    MoodLabels.marah: 'marah',
    MoodLabels.takut: 'takut',
    MoodLabels.kesal: 'kesal',
    MoodLabels.stress: 'stress',
    MoodLabels.sedih: 'sedih',
    MoodLabels.kecewa: 'kecewa',
    MoodLabels.bosan: 'bosan',
    MoodLabels.depresi: 'depresi',
  };

  factory UserStatus.fromJson(dynamic json) {
    return UserStatus(
      id: json['id'],
      date: DateTime.parse(json['created_at']).toLocal(),
      mood: json['mood'],
      emotion: MoodLabels.values[json['emotion']],
      text: json['text'],
    );
  }

  Map toJson() => {
        'id': id,
        'created_at': date.toString(),
        'mood': mood,
        'emotion': emotion.index,
        'text': text,
      };
}

class UserStatusMoodAverage {
  DateTime date;
  double moodAverage;

  UserStatusMoodAverage({
    required this.date,
    required this.moodAverage,
  });

  factory UserStatusMoodAverage.fromJson(dynamic data) {
    return UserStatusMoodAverage(
      date: DateTime.parse(data['Date']),
      moodAverage: data['Avg'].toDouble(),
    );
  }
}
