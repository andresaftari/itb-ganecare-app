import 'dart:convert';

class Login {
  Login({
    required this.statusCode,
    required this.data,
    required this.userGroup,
    required this.status,
  });

  int statusCode;
  LoginData data;
  UserGroup userGroup;
  int status;
}

LoginCounselor loginCounselorFromJson(String str) =>
    LoginCounselor.fromJson(json.decode(str));
String loginCounselorToJson(LoginCounselor data) => json.encode(data.toJson());

class LoginCounselor extends Login {
  LoginCounselor({
    required int statusCode,
    required LoginData data,
    required UserGroup userGroup,
    required int status,
    required this.auth,
  }) : super(
          statusCode: statusCode,
          data: data,
          userGroup: userGroup,
          status: status,
        );

  AuthCounselor auth;

  factory LoginCounselor.fromJson(Map<String, dynamic> json) => LoginCounselor(
        statusCode: json['status_code'],
        data: LoginData.fromJson(json['data']),
        userGroup: UserGroup.fromJson(json['user_group']),
        status: json['status'],
        auth: AuthCounselor.fromJson(json['auth']),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'data': data.toJson(),
        'user_group': userGroup.toJson(),
        'status': status,
        'auth': auth.toJson(),
      };
}

LoginCounselee loginCounseleeFromJson(String str) =>
    LoginCounselee.fromJson(json.decode(str));
String loginCounseleeToJson(LoginCounselee data) => json.encode(data.toJson());

class LoginCounselee extends Login {
  LoginCounselee({
    required int statusCode,
    required LoginData data,
    required UserGroup userGroup,
    required int status,
    required this.auth,
  }) : super(
          statusCode: statusCode,
          data: data,
          userGroup: userGroup,
          status: status,
        );

  AuthCounseee auth;

  factory LoginCounselee.fromJson(Map<String, dynamic> json) => LoginCounselee(
        statusCode: json['status_code'],
        data: LoginData.fromJson(json['data']),
        userGroup: UserGroup.fromJson(json['user_group']),
        status: json['status'],
        auth: AuthCounseee.fromJson(json['auth']),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'data': data.toJson(),
        'user_group': userGroup.toJson(),
        'status': status,
        'auth': auth.toJson(),
      };
}

class AuthCounseee {
  AuthCounseee({
    required this.tokenMahasiswa,
    required this.user,
  });

  TokenMahasiswa tokenMahasiswa;
  dynamic user;

  factory AuthCounseee.fromJson(Map<String, dynamic> json) => AuthCounseee(
        tokenMahasiswa: TokenMahasiswa.fromJson(json['token_mahasiswa']),
        user: UserCounselor.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'token_mahasiswa': tokenMahasiswa.toJson(),
        'user_mahasiswa': user.toJson(),
      };
}

class AuthCounselor {
  AuthCounselor({
    required this.tokenMahasiswa,
    required this.tokenListener,
    required this.user,
  });

  TokenMahasiswa tokenMahasiswa;
  late TokenListener tokenListener;
  dynamic user;

  factory AuthCounselor.fromJson(Map<String, dynamic> json) => AuthCounselor(
        tokenMahasiswa: TokenMahasiswa.fromJson(json['token_mahasiswa']),
        tokenListener: TokenListener.fromJson(json['token_listener']),
        user: UserCounselor.fromJson(json['user_mahasiswa']),
      );

  Map<String, dynamic> toJson() => {
        'token_mahasiswa': tokenMahasiswa.toJson(),
        'token_listener': tokenListener.toJson(),
        'user_mahasiswa': user.toJson(),
      };
}

class TokenMahasiswa {
  TokenMahasiswa({required this.token});

  String token;

  factory TokenMahasiswa.fromJson(Map<String, dynamic> json) => TokenMahasiswa(
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {'token': token};
}

class TokenListener {
  TokenListener({required this.token});

  String token;

  factory TokenListener.fromJson(Map<String, dynamic> json) => TokenListener(
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {'token': token};
}

class UserCounselor {
  UserCounselor({
    required this.id,
    required this.inaId,
    required this.deviceId,
    required this.name,
    required this.nickname,
    required this.email,
    required this.role,
    required this.affiliation,
    required this.description,
    required this.profilepicImage,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.schedule,
    required this.mahasiswaCount,
    required this.jurusan,
    required this.angkatan,
    required this.gender,
    required this.nim,
    required this.registerId,
    required this.kuota,
  });

  int id;
  int inaId;
  String deviceId;
  String name;
  String nickname;
  String email;
  int role;
  String affiliation;
  String description;
  String profilepicImage;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic schedule;
  int mahasiswaCount;
  String jurusan;
  int angkatan;
  String gender;
  int nim;
  String? registerId;
  int? kuota;

  factory UserCounselor.fromJson(Map<String, dynamic> json) => UserCounselor(
        id: json['id'],
        inaId: json['ina_id'],
        deviceId: json['device_id'],
        name: json['name'],
        nickname: json['nickname'],
        email: json['email'],
        role: json['role'],
        affiliation: json['affiliation'],
        description: json['description'],
        profilepicImage: json['profilepic_image'],
        emailVerifiedAt: json['email_verified_at'] ?? '',
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        schedule: json['schedule'] ?? '',
        mahasiswaCount: json['mahasiswa_count'],
        jurusan: json['jurusan'],
        angkatan: json['angkatan'],
        gender: json['gender'],
        nim: json['nim'],
        registerId: json['register_id'] ?? '',
        kuota: json['kuota'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ina_id': inaId,
        'device_id': deviceId,
        'name': name,
        'nickname': nickname,
        'email': email,
        'role': role,
        'affiliation': affiliation,
        'description': description,
        'profilepic_image': profilepicImage,
        'email_verified_at': emailVerifiedAt,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'schedule': schedule,
        'mahasiswa_count': mahasiswaCount,
        'jurusan': jurusan,
        'angkatan': angkatan,
        'gender': gender,
        'nim': nim,
        'register_id': registerId,
        'kuota': kuota,
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
        conselee: json['conselee'].toString(),
        conselor: json['conselor'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'conselee': conselee,
        'conselor': conselor,
      };

  @override
  String toString() {
    return 'UserGroup{conselee: $conselee, conselor: $conselor}';
  }
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
