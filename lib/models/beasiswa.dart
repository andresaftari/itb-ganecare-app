import 'dart:convert';

Beasiswa beasiswaFromJson(String str) => Beasiswa.fromJson(json.decode(str));
String beasiswaToJson(Beasiswa data) => json.encode(data.toJson());

class Beasiswa {
  Beasiswa({
    required this.status,
    required this.content,
  });

  int status;
  List<String> content;

  factory Beasiswa.fromJson(Map<String, dynamic> json) => Beasiswa(
    status: json['status'],
    content: List<String>.from(json['content'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'content': List<String>.from(content.map((x) => x)),
  };
}