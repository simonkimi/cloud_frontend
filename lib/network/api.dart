import 'package:cloud_frontend/network/bean/mine.dart';
import 'package:cloud_frontend/network/bean/token.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseUrl = 'http://127.0.0.1:8000/';

final api = Api();

class Api {
  Api() {
    SharedPreferences.getInstance().then((pref) {
      token = pref.getString('token') ?? '';
    });
  }

  set token(String value) =>
      _dio.options.headers = {'authorization': 'Token $value'};

  final _dio = Dio()
    ..options.baseUrl = baseUrl
    ..options.connectTimeout = 10;

  Future<TokenBean> register(
      String username, String password, int server) async {
    final rsp = await _dio.post('user/register/',
        data: {'username': username, 'password': password, 'server': server});
    return TokenBean.fromJson(rsp.data);
  }

  Future<TokenBean> login(String username, String password) async {
    final rsp = await _dio.post('user/login/',
        data: {'username': username, 'password': password});
    return TokenBean.fromJson(rsp.data);
  }

  Future<MineBean> mine() async {
    final rsp = await _dio.get('user/mine/');
    return MineBean.fromJson(rsp.data);
  }
}
