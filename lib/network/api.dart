import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  //Alamat url untuk backend API , bisa berubah sesuai dengan kebutuhan
  // final String _url = 'https://staggingbackendlaravel.herokuapp.com/api/v1';
  // final String _url = 'http://167.205.57.127:8080/api/v1';
  final String _url = '167.205.57.127:8080/api/v1';
  var _token;

  //method ini berfungsi untuk mencatat token yang didapat setelah user ter-authentikasi
  //fungsi async/ asynchronous sama kayak unity , untuk menunggu respon dari API Backend
  _getToken() async {
    //sharedpreferences berguna untuk mencatat/menyimpan token di cache/storage sementara di device,
    //saat user belum melakukan logout, cache token akan tetap tersimpan di storage
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    //token yang di dapat dari hasil respons backend , frontend tidak perlu pusing memikirkan token yang diterima,
    //biarin backend yg generate token dan mengecek apakah token tsb sudah expire atau belum.

    // Dirty fix, jsondecode-nya ngasih error kalau hasil dari sharedprefs-nya null.
    var tokenFromLocal = localStorage.getString('token');
    if (tokenFromLocal != null) _token = jsonDecode(tokenFromLocal)['token'];
    //print(_token);
  }

  //method ini dipanggil saat flutter(frontend) ingin mengirimkan data authentikasi,
  //dalam hal ini method yg di pakai adalah "POST", karena frontend mengirim/submit data ke backend untuk di proses
  //contoh nya pada saat login, flutter(frontend) mengirimkan data berupa email dan password ke backend,
  authData(data, apiUrl) async {
    try {
      var fullUrl = Uri.http(_url, apiUrl);

      await _getToken(); // FIXME: Jangan lupa dicek dulu kalau token di local-nya null apa nggak.
      return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders(),
      );
    } catch (exception) {
      log('api.dart error: $exception');
      rethrow;
    }
  }

  //beda halnya dengan authdata, disini  flutter meminta data ke backend, jadi method http yg dipakai adalah "GET"
  //contoh pemakaian getData untuk mengambil data user yg sedang login
  getData(apiUrl) async {
    try {
      var fullUrl = Uri.http(_url, apiUrl);

      await _getToken();
      return await http.get(
        fullUrl,
        headers: _setHeaders(),
      );
    } catch (exception) {
      log('api.dart error: $exception');
      rethrow;
    }
  }

  //sengaja dibuat biar ga ngerusak getData dan _getToken. Fungsi ini ngeswitch
  //default token dan return user yg sesuai
  switchToken() async {
    //sharedpreferences berguna untuk mencatat/menyimpan token di cache/storage sementara di device,
    //saat user belum melakukan logout, cache token akan tetap tersimpan di storage
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // Dirty fix, jsondecode-nya ngasih error kalau hasil dari sharedprefs-nya null.
    //print("TokenBefore");
    await _getToken();
    //print(_token);
    //print("tokenMahasiswaToBeCompared");
    //print(jsonDecode(localStorage.getString('token_mahasiswa'))['token']);
    try {
      if (_token ==
              jsonDecode(localStorage.getString('token_mahasiswa').toString())[
                  'token'] &&
          localStorage.getString('token_listener') != null) {
        _token = jsonDecode(
            localStorage.getString('token_listener').toString())['token'];
        //print("TokenEncoded");
        //print((localStorage.getString('token_listener')));
        localStorage.setString(
            'token', localStorage.getString('token_listener').toString());
      } else {
        _token = jsonDecode(
            localStorage.getString('token_mahasiswa').toString())['token'];
        //print("TokenEncoded");
        //print((localStorage.getString('token_mahasiswa')));
        localStorage.setString(
            'token', localStorage.getString('token_mahasiswa').toString());
      }
      //print("TokenAfter");
      //print(_token);

      // return await Network().getData('/user/get_details');
    } catch (exception) {
      log('api.dart error: $exception');
      rethrow;
    }
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token'
  };
}
