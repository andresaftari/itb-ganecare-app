import 'package:itb_ganecare/models/contact_data.dart';

enum RequestStatus {
  requested,
  accepted,
  declined,
  canceled,
  closedByCounselee,
  closedByAdmin,
}

class RegisterStatus {
  int? counselorId;
  int? counselingId;
  RequestStatus? requestStatus;
  ContactData? peerCounselorContactData;

  RegisterStatus({
    required this.counselorId,
    required this.counselingId,
    required this.requestStatus,
    required this.peerCounselorContactData,
  });

  factory RegisterStatus.fromJson(json) {
    return RegisterStatus(
      counselorId: json['counselor_id'],
      counselingId: json['id'],
      requestStatus: RequestStatus.values[json['request_status']],
      peerCounselorContactData: ContactData.fromJson(json['peer_counselor']),
    );
  }
}
