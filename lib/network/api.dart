import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/bean/campaign.dart';
import 'package:cloud_frontend/network/bean/dashboard.dart';
import 'package:cloud_frontend/network/bean/explore.dart';
import 'package:cloud_frontend/network/bean/mine.dart';
import 'package:cloud_frontend/network/bean/repair.dart';
import 'package:cloud_frontend/network/bean/statistic.dart';
import 'package:cloud_frontend/network/bean/token.dart';
import 'package:dio/dio.dart';

const baseUrl = 'http://192.168.2.242:8000/api/';

final api = Api();

class Api {
  final _dio = Dio()
    ..options.baseUrl = baseUrl
    ..options.connectTimeout = 1000 * 30
    ..interceptors.add(AuthInterceptor());

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

  Future<DashBoardBean> dashboard() async {
    final rsp = await _dio.get('user/dashboard/');
    return DashBoardBean.fromJson(rsp.data);
  }

  Future<UserProfile> setSwitch(bool value) async {
    final rsp = await _dio.post('user/setting/', data: {'switch': value});
    return UserProfile.fromJson(rsp.data);
  }

  Future<UserProfile> setExploreSwitch(bool value) async {
    final rsp =
        await _dio.post('user/setting/', data: {'explore_switch': value});
    return UserProfile.fromJson(rsp.data);
  }

  Future<UserProfile> setCampaignSetting(int map, int formats) async {
    final rsp = await _dio.post('user/setting/',
        data: {'campaign_map': map, 'campaign_format': formats});
    return UserProfile.fromJson(rsp.data);
  }

  Future<UserProfile> setRepairSwitch(bool value) async {
    final rsp =
        await _dio.post('user/setting/', data: {'repair_switch': value});
    return UserProfile.fromJson(rsp.data);
  }

  Future<ExploreBean> getExplore([int page]) async {
    final rsp = await _dio.get('explore/', queryParameters: {'p': page ?? 1});
    return ExploreBean.fromJson(rsp.data);
  }

  Future<CampaignBean> getCampaign([int page]) async {
    final rsp = await _dio.get('campaign/', queryParameters: {'p': page ?? 1});
    return CampaignBean.fromJson(rsp.data);
  }

  Future<RepairBean> getRepair([int page]) async {
    final rsp = await _dio.get('repair/', queryParameters: {'p': page ?? 1});
    return RepairBean.fromJson(rsp.data);
  }

  Future<StatisticBean> getExploreStatistic(int startTime, int endTime) async {
    final rsp = await _dio.get('explore/statistic/', queryParameters: {
      'start_time': startTime,
      'end_time': endTime,
    });
    return StatisticBean.fromJson(rsp.data);
  }

  Future<StatisticBean> getCampaignStatistic(int startTime, int endTime) async {
    final rsp = await _dio.get('campaign/statistic/', queryParameters: {
      'start_time': startTime,
      'end_time': endTime,
    });
    return StatisticBean.fromJson(rsp.data);
  }
}

class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError err) async {
    if (err?.response?.statusCode == 401 ?? false) {
      mainStore.logout();
    }
    return err;
  }

  @override
  Future onRequest(RequestOptions options) async {
    if (mainStore.token.isNotEmpty) {
      options.headers['authorization'] = 'Token ${mainStore.token}';
    }
    return options;
  }
}
