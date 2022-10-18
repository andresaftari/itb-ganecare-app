import 'dart:convert';

import 'package:itb_ganecare/models/chat_room_info.dart';
import 'package:itb_ganecare/models/schedule.dart';
import 'package:itb_ganecare/models/user_data.dart';


import 'avatar_data.dart';

class ContactData extends UserData {
  ChatRoomInfo? chatroomData;
  int quota;
  int counselorId;
  int counselingId;
  int contactListId;
  int activeStatus;
  int unreadMesssages;

  ContactData({
    required id,
    required inaId,
    required name,
    nickname,
    description = '',
    required role,
    required affiliation,
    profileImage,
    schedule,
    required gender,
    required year,
    required major,
    required quota,
    chatroomData,
    counselorId,
    counselingId,
    activeStatus,
    unreadMesssages,
    required contactListId,
  })  : this.chatroomData = chatroomData,
        this.quota = quota,
        this.counselorId = counselorId,
        this.counselingId = counselingId,
        this.activeStatus = activeStatus,
        this.unreadMesssages = unreadMesssages,
        this.contactListId = contactListId,
        super(
          id: id,
          inaId: inaId,
          name: name,
          nickname: nickname,
          affiliation: affiliation,
          role: role,
          description: description,
          profileImage: profileImage,
          schedule: schedule,
          gender: gender,
          year: year,
          major: major,
        );

  @override
  factory ContactData.fromJson(dynamic jsonData) {
    final Map<int, UserRoles> _intRoleCodeToRoleEnum = {
      0: UserRoles.mahasiswa,
      1: UserRoles.peerCounselor,
      2: UserRoles.konselor,
    };
    // print('test' + jsonData['contactlist_id'].toString());

    return ContactData(
        id: "${jsonData['id']}",
        inaId: "${jsonData['ina_id']}",
        name: jsonData['name'] ?? 'null',
        nickname: jsonData['nickname'] ?? 'null',
        role: _intRoleCodeToRoleEnum[jsonData['role'] as int] ??
            _intRoleCodeToRoleEnum[0],
        affiliation: jsonData['affiliation'] ?? 'null',
        profileImage: jsonData['profilepic_image'] ?? AvatarData.random().code,
        description:
            jsonData['description'] == null || jsonData['description'] == ''
                ? 'Halo namaku ${jsonData['nickname']}'
                : jsonData['description'],
        // chatroomData: jsonData['chatroom_details'] != null ? "${jsonData['chatroom_details']['id']}" : null,
        chatroomData: jsonData['chatroom_details'] != null
            ? ChatRoomInfo.fromJson(
                jsonData['chatroom_details'],
                jsonData['id'].toString(),
              )
            : null,
        schedule: jsonData['schedule'] != null
            ? Schedule.fromJsonDecoded(json.decode(jsonData['schedule']))
            : Schedule(),
        gender: jsonData['gender'] == 'P' ? 'wanita' : 'pria',
        // ['pria', 'wanita'][Random().nextInt(2)],
        year: jsonData['angkatan'].toString(),
        // ['2016', '2017', '2018', '2019'][Random().nextInt(4)],
        major: jsonData['jurusan'],
        // ['t.elektro', 'dkv', 'matematika'][Random().nextInt(3)],
        //khusus ContactData
        quota: jsonData['mahasiswa_count'],
        counselorId: jsonData['id'] ?? 'null',
        // counselingId: null,
        contactListId: jsonData['contactlist_id'],
        activeStatus: jsonData['active_status'] ?? jsonData['active'] ?? 1,
        unreadMesssages: jsonData['unread_messages'] ?? 0);
  }
}
