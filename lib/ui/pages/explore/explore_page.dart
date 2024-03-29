import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer.dart';
import 'package:cloud_frontend/ui/components/loading_switch_tile.dart';
import 'package:cloud_frontend/ui/components/statistic_table.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'explore_table.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

mixin _ExplorePageStateMixin<T extends StatefulWidget> on State<T> {
  var isSwitchLoading = false;

  Future<void> onExploreSwitch(bool value) async {
    try {
      setState(() {
        isSwitchLoading = true;
      });
      await mainStore.setExploreSwitch(value);
    } on DioError catch (e) {
      BotToast.showText(text: getDioErr(e));
    } finally {
      setState(() {
        isSwitchLoading = false;
      });
    }
  }
}

class _ExplorePageState extends State<ExplorePage> with _ExplorePageStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(tag: 'explore'),
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (!mainStore.isLogin) {
      Future.delayed(const Duration(seconds: 0), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('login/', (route) => false);
      });
      return Container();
    }
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          cacheExtent: 9999,
          children: [
            buildSwitch(mainStore.exploreSwitch),
            StatisticTable(
              title: '资源统计',
              showDate: true,
              onLoadStatistic: api.getExploreStatistic,
            ),
            ExploreTable(),
          ],
        ),
      );
    });
  }

  Card buildSwitch(bool value) {
    return Card(
      child: LoadingSwitchTile(
        title: const Text('远征开关'),
        value: value ?? false,
        onChange: onExploreSwitch,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('远征', style: TextStyle(fontSize: 18)),
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }
}
