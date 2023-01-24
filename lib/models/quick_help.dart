import 'dart:convert';

String quickHelpToJson(QuickHelp data) => json.encode(data.toJson());

class QuickHelp {
  int statusCode;
  String message;
  HelpData data;

  QuickHelp({
    required this.statusCode,
    required this.message,
    required this.data,
  });

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
  dynamic status;
  DateTime createdDate;
  int idQuickHelp;
  String registerId;
  String counselorId;

  HelpData({
    required this.status,
    required this.createdDate,
    required this.idQuickHelp,
    required this.registerId,
    required this.counselorId,
  });

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

MetaHelp metaHelpFromJson(String str) => MetaHelp.fromJson(json.decode(str));
String metaHelpToJson(MetaHelp data) => json.encode(data.toJson());

class MetaHelp {
  int statusCode;
  MetaData metaData;
  List<MetaDatum> data;

  MetaHelp({
    required this.statusCode,
    required this.metaData,
    required this.data,
  });

  factory MetaHelp.fromJson(Map<String, dynamic> json) => MetaHelp(
        statusCode: json['statusCode'],
        metaData: MetaData.fromJson(json['meta-data']),
        data: List<MetaDatum>.from(
          json['data'].map((x) => MetaDatum.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'meta-data': metaData.toJson(),
        'data': List<MetaDatum>.from(data.map((x) => x.toJson())),
      };
}

class MetaDatum {
  int anonymousId;
  String anonymousName;
  String quickHelp;
  DateTime createdDate;

  MetaDatum({
    required this.anonymousId,
    required this.anonymousName,
    required this.quickHelp,
    required this.createdDate,
  });

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        anonymousId: json['anonymous_id'],
        anonymousName: json['anonymous_name'],
        quickHelp: json['quick_help'],
        createdDate: DateTime.parse(json['created_date']),
      );

  Map<String, dynamic> toJson() => {
        'anonymous_id': anonymousId,
        'anonymous_name': anonymousName,
        'quick_help': quickHelp,
        'created_date': createdDate.toIso8601String(),
      };
}

class MetaData {
  String page;
  int totalData;
  String limit;
  int totalPage;

  MetaData({
    required this.page,
    required this.totalData,
    required this.limit,
    required this.totalPage,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        page: json['page'],
        totalData: json['total-data'],
        limit: json['limit'],
        totalPage: json['total-page'],
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'total-data': totalData,
        'limit': limit,
        'total-page': totalPage,
      };
}
