class GetMoodTracker {
  GetMoodTracker({
    required this.statusCode,
    required this.status,
    required this.data,
  });

  int statusCode;
  String status;
  List<DatumMoodTracker> data;

  factory GetMoodTracker.fromJson(Map<String, dynamic> json) => GetMoodTracker(
        statusCode: json["statusCode"],
        status: json["status"],
        data: List<DatumMoodTracker>.from(
            json["data"].map((x) => DatumMoodTracker.fromJson(x))),
      );
}

class DatumMoodTracker {
  DatumMoodTracker({
    required this.id,
    required this.mood,
    required this.emotion,
    required this.text,
    required this.deleted,
    required this.postedUser,
    required this.noReg,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int mood;
  int emotion;
  String text;
  int deleted;
  int postedUser;
  int noReg;
  DateTime createdAt;
  DateTime updatedAt;

  factory DatumMoodTracker.fromJson(Map<String, dynamic> json) =>
      DatumMoodTracker(
        id: json["id"],
        mood: json["mood"],
        emotion: json["emotion"],
        text: json["text"],
        deleted: json["deleted"],
        postedUser: json["posted_user"],
        noReg: json["no_reg"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
