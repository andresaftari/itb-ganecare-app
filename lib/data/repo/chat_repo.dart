import 'package:itb_ganecare/models/chats.dart';

abstract class ChatRepo {
  Future postEndChat(
    String uuid,
    int conselorId,
    int conseleeId,
    DateTime createdAt,
    String roomId,
    List<Chats> list,
  );
}
