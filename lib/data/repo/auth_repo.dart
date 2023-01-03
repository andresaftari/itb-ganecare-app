abstract class AuthRepository {
  Future postLogin(String username, String password, String deviceId);
}