import 'dart:convert';

PeerCouncelor? peerCouncelorFromJson(String str) => PeerCouncelor.fromJson(json.decode(str));
String peerCouncelorToJson(PeerCouncelor? data) => json.encode(data!.toJson());

class PeerCouncelor {
    PeerCouncelor({
        required this.status,
        required this.message,
    });

    int? status;
    String? message;

    factory PeerCouncelor.fromJson(Map<String, dynamic> json) => PeerCouncelor(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
