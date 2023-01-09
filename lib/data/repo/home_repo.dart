abstract class HomeRepo {
  Future getQuickHelp(String page);

  Future postQuickHelp(String idUser);
  Future postUserID(String nim);
  Future postBeasiswaList(String userid);
}