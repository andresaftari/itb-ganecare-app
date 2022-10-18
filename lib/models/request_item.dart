import 'package:itb_ganecare/models/contact_data.dart';
import 'package:itb_ganecare/models/register_status.dart';
import 'package:itb_ganecare/models/user_status.dart';

class RequestItem {
  int counselorId;
  int counselingId;
  RequestStatus requestStatus;
  UserStatus? lastUserStatus;
  ContactData mahasiswaContactData;

  RequestItem({
    required this.counselorId,
    required this.counselingId,
    required this.requestStatus,
    required this.lastUserStatus,
    required this.mahasiswaContactData,
  });

  factory RequestItem.fromJson(json) {
    return RequestItem(
      counselorId: json['counselor_id'],
      counselingId: json['id'],
      lastUserStatus: json['last_status'] != null
          ? UserStatus.fromJson(json['last_status'])
          : null,
      requestStatus: RequestStatus.values[json['request_status']],
      mahasiswaContactData: ContactData.fromJson(json['mahasiswa']),
    );
  }
}
