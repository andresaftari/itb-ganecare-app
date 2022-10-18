class ChatRoomInfo {
  final String? roomId;
  final String sourceUserId;
  final String partnerUserId;
  final DateTime dateCreated;
  DateTime? lastMessageAt;
  String? lastMessageId;

  ChatRoomInfo({
    required this.roomId,
    required this.sourceUserId,
    required this.partnerUserId,
    required this.dateCreated,
    required DateTime? lastMessageAt,
    String? lastMessageId,
  }) {
    this.lastMessageId ?? lastMessageId;
    this.lastMessageAt ?? lastMessageAt;
  }

  factory ChatRoomInfo.fromJson(dynamic jsonData, String sourceUserId) {
    String id1 = jsonData['user1'].toString();
    String id2 = jsonData['user2'].toString();

    // print(jsonData);

    return ChatRoomInfo(
      roomId: jsonData['id'].toString(),
      sourceUserId: sourceUserId,
      partnerUserId: sourceUserId == id1 ? id2 : id1,
      dateCreated: DateTime.parse(jsonData['created_at']),
      lastMessageAt: jsonData['updated_at'] != null
          ? DateTime.parse(jsonData['updated_at'])
          : null,
      // lastMessageId: jsonData['updated_at'],
      // lastMessageId: jsonData['updated_at'],
    );
  }

// @override
// List<Object> get props => [roomId, participantsId, dateCreated, lastMessageAt ?? '', lastMessageId ?? ''];

}
