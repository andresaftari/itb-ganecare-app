import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.statusCode,
    required this.statusLogin,
    required this.data,
  });

  int statusCode;
  int statusLogin;
  LoginData data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    statusCode: json['statusCode'],
    statusLogin: json['statusLogin'],
    data: LoginData.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'statusLogin': statusLogin,
    'data': data.toJson(),
  };
}

class LoginData {
  LoginData({
    required this.statusCode,
    required this.data,
    required this.userGroup,
  });

  int statusCode;
  DataData data;
  UserGroup userGroup;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    statusCode: json['status_code'],
    data: DataData.fromJson(json['data']),
    userGroup: UserGroup.fromJson(json['user_group']),
  );

  Map<String, dynamic> toJson() => {
    'status_code': statusCode,
    'data': data.toJson(),
    'user_group': userGroup.toJson(),
  };
}

class DataData {
  DataData({
    required this.id,
    required this.nim,
    required this.name,
    required this.major,
    required this.studentSchoolyear,
    required this.gender,
    required this.profile,
  });

  String id;
  String nim;
  String name;
  String major;
  int studentSchoolyear;
  String gender;
  String profile;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    id: json['id'],
    nim: json['nim'],
    name: json['name'],
    major: json['major'],
    studentSchoolyear: json['student_schoolyear'],
    gender: json['gender'],
    profile: json['profile'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nim': nim,
    'name': name,
    'major': major,
    'student_schoolyear': studentSchoolyear,
    'gender': gender,
    'profile': profile,
  };
}

class UserGroup {
  UserGroup({
    required this.conselee,
    required this.conselor,
  });

  String conselee;
  String conselor;

  factory UserGroup.fromJson(Map<String, dynamic> json) => UserGroup(
    conselee: json['conselee'],
    conselor: json['conselor'],
  );

  Map<String, dynamic> toJson() => {
    'conselee': conselee,
    'conselor': conselor,
  };
}
