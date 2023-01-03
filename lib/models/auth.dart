import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));
String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.statusCode,
    required this.data,
    required this.userGroup,
    required this.status,
    required this.auth,
  });

  int statusCode;
  LoginData data;
  UserGroup userGroup;
  int status;
  Auth auth;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        statusCode: json['status_code'],
        data: LoginData.fromJson(json['data']),
        userGroup: UserGroup.fromJson(json['user_group']),
        status: json['status'],
        auth: Auth.fromJson(json['auth']),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'data': data.toJson(),
        'user_group': userGroup.toJson(),
        'status': status,
        'auth': auth.toJson(),
      };
}

class Auth {
  Auth({
    required this.tokenMahasiswa,
    required this.user,
  });

  TokenMahasiswa tokenMahasiswa;
  User user;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        tokenMahasiswa: TokenMahasiswa.fromJson(json['token_mahasiswa']),
        user: User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'token_mahasiswa': tokenMahasiswa.toJson(),
        'user': user.toJson(),
      };
}

class TokenMahasiswa {
  TokenMahasiswa({
    required this.token,
  });

  String token;

  factory TokenMahasiswa.fromJson(Map<String, dynamic> json) => TokenMahasiswa(
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}

class User {
  User({
    required this.email,
    required this.inaId,
    required this.name,
    required this.affiliation,
    required this.nim,
    required this.deviceId,
    required this.gender,
    required this.jurusan,
    required this.angkatan,
    required this.nickname,
    required this.role,
    required this.description,
    required this.profilepicImage,
    required this.mahasiswaCount,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String email;
  int inaId;
  String name;
  String affiliation;
  int nim;
  String deviceId;
  String gender;
  String jurusan;
  int angkatan;
  String nickname;
  int role;
  String description;
  String profilepicImage;
  int mahasiswaCount;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        inaId: json['ina_id'],
        name: json['name'],
        affiliation: json['affiliation'],
        nim: json['nim'],
        deviceId: json['device_id'],
        gender: json['gender'],
        jurusan: json['jurusan'],
        angkatan: json['angkatan'],
        nickname: json['nickname'],
        role: json['role'],
        description: json['description'],
        profilepicImage: json['profilepic_image'],
        mahasiswaCount: json['mahasiswa_count'],
        updatedAt: DateTime.parse(json['updated_at']),
        createdAt: DateTime.parse(json['created_at']),
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'ina_id': inaId,
        'name': name,
        'affiliation': affiliation,
        'nim': nim,
        'device_id': deviceId,
        'gender': gender,
        'jurusan': jurusan,
        'angkatan': angkatan,
        'nickname': nickname,
        'role': role,
        'description': description,
        'profilepic_image': profilepicImage,
        'mahasiswa_count': mahasiswaCount,
        'updated_at': updatedAt.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'id': id,
      };
}

class LoginData {
  LoginData({
    required this.id,
    required this.nim,
    required this.name,
    required this.major,
    required this.studentSchoolyear,
    required this.gender,
    required this.profile,
    required this.userId,
  });

  String id;
  String nim;
  String name;
  String major;
  int studentSchoolyear;
  String gender;
  String profile;
  String userId;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: json['id'],
        nim: json['nim'],
        name: json['name'],
        major: json['major'],
        studentSchoolyear: json['student_schoolyear'],
        gender: json['gender'],
        profile: json['profile'],
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nim': nim,
        'name': name,
        'major': major,
        'student_schoolyear': studentSchoolyear,
        'gender': gender,
        'profile': profile,
        'user_id': userId,
      };
}

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.statusCode,
    required this.data,
    required this.userGroup,
  });

  int statusCode;
  ProfileData data;
  UserGroup userGroup;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        statusCode: json['status_code'],
        data: ProfileData.fromJson(json['data']),
        userGroup: UserGroup.fromJson(json['user_group']),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'data': data.toJson(),
        'user_group': userGroup.toJson(),
      };
}

class ProfileData {
  ProfileData({
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

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
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

ProfileId profileIdFromJson(String str) => ProfileId.fromJson(json.decode(str));

String profileIdToJson(ProfileId data) => json.encode(data.toJson());

class ProfileId {
  ProfileId({
    required this.statusCode,
    required this.userId,
  });

  int statusCode;
  int userId;

  factory ProfileId.fromJson(Map<String, dynamic> json) => ProfileId(
        statusCode: json['statusCode'],
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'user_id': userId,
      };
}
