abstract class HomeRepo {
  Future getQuickHelp();

  Future postQuickHelp(String idUser);
  Future postUserID(String nim);
  Future postBeasiswaList(String userid);
}