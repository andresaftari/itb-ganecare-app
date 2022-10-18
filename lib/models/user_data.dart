// The data model for representing user data

// Enumerate object signifying different user roles.
// May need to be dynamically created instead later.

import 'dart:convert';

import 'package:itb_ganecare/models/schedule.dart';

enum UserRoles {
  mahasiswa,
  peerCounselor,
  konselor,
}

class UserData {
  final String id;
  final String inaId;
  final String? deviceId;
  final String name;
  String? nickname;
  String? description;
  final UserRoles? role;
  final String affiliation;
  String? profileImage;
  Schedule? schedule;
  String gender;
  String year;
  String major;

  UserData({
    required this.id,
    required this.inaId,
    this.deviceId,
    required this.name,
    this.nickname,
    required this.role,
    required this.affiliation,
    this.description,
    this.profileImage,
    this.schedule,
    required this.gender,
    required this.year,
    required this.major,
  }) {
    profileImage = profileImage ?? '0000000000000000000000000';
    schedule = schedule ?? Schedule();
  }

  factory UserData.fromJson(dynamic jsonData) {
    final Map<int, UserRoles> _intRoleCodeToRoleEnum = {
      0: UserRoles.mahasiswa,
      1: UserRoles.peerCounselor,
      2: UserRoles.konselor,
    };
    // print(json.decode(jsonData['schedule']).toString());

    return UserData(
        id: "${jsonData['id']}",
        inaId: "${jsonData['ina_id']}",
        name: jsonData['name'],
        nickname: jsonData['nickname'],
        role: _intRoleCodeToRoleEnum[jsonData['role'] as int],
        affiliation: jsonData['affiliation'],
        profileImage: jsonData['profilepic_image'],
        description: jsonData['description'] ?? '',
        schedule: jsonData['schedule'] != null
            ? Schedule.fromJsonDecoded(json.decode(jsonData['schedule']))
            : Schedule(),
        gender: jsonData['gender'] == 'P' ? 'wanita' : 'pria',
        year: jsonData['angkatan'].toString(),
        major: jsonData['jurusan']);
  }

  factory UserData.fromUserData(UserData srcUserData) {
    return UserData(
      id: srcUserData.id,
      inaId: srcUserData.inaId,
      deviceId: srcUserData.deviceId,
      name: srcUserData.name,
      nickname: srcUserData.nickname,
      role: srcUserData.role,
      affiliation: srcUserData.affiliation,
      profileImage: srcUserData.profileImage,
      description: srcUserData.description,
      schedule: Schedule.fromSchedule(srcUserData.schedule!),
      gender: srcUserData.gender,
      year: srcUserData.year,
      major: srcUserData.major,
    );
  }

  String get fiveDigitId {
    var output = id;

    for (int i = 0; i < 5 - id.length; i++) {
      output = '0' + output;
    }

    return output;
  }

  String getUserRoleString() {
    return role.toString().split('.').last;
  }

  List<Object> get props => [];
}
