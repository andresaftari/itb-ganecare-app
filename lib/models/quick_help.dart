import 'dart:convert';

QuickHelp quickHelpFromJson(String str) => QuickHelp.fromJson(json.decode(str));
String quickHelpToJson(QuickHelp data) => json.encode(data.toJson());

class QuickHelp {
  QuickHelp({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  HelpData data;

  factory QuickHelp.fromJson(Map<String, dynamic> json) => QuickHelp(
        statusCode: json['status_code'],
        message: json['message'],
        data: HelpData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'message': message,
        'data': data.toJson(),
      };
}

class HelpData {
  HelpData({
    required this.status,
    required this.createdDate,
    required this.idQuickHelp,
    required this.registerId,
    required this.counselorId,
  });

  dynamic status;
  DateTime createdDate;
  int idQuickHelp;
  String registerId;
  String counselorId;

  factory HelpData.fromJson(Map<String, dynamic> json) => HelpData(
        status: json['status'],
        createdDate: DateTime.parse(json['created_date']),
        idQuickHelp: json['id-quick-help'],
        registerId: json['register_id'],
        counselorId: json['counselor_id'],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'created_date': createdDate.toIso8601String(),
        'id-quick-help': idQuickHelp,
        'register_id': registerId,
        'counselor_id': counselorId,
      };
}
