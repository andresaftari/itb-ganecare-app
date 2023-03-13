abstract class ProfileRepository {
  Future getProfile(String nim);
  Future getProfileV2(String noreg);
  Future updateProfileService(
      String noReg, String nickName, String about, String role);
}
