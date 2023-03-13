import 'package:itb_ganecare/models/profile_v2.dart';

abstract class ProfileRepository {
  Future getProfile(String nim);
  Future getProfileV2(String noreg);
}