import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/explore.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer/drawer.dart';
import 'package:cloud_frontend/ui/components/explore_data_table.dart';
import 'package:cloud_frontend/ui/components/res_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_select/smart_select.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

mixin _ExplorePageStateMixin<T extends StatefulWidget> on State<T> {
  var isSwitchLoading = false;
  ExploreStatistic _statistic;
  var isStatisticLoading = false;

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

  Future<void> loadStatistic(int startTime, int endTime) async {
    setState(() {
      isStatisticLoading = true;
    });
    final data = await api.getExploreStatistic(startTime, endTime);
    _statistic = data;
    isStatisticLoading = false;
    setState(() {});
  }

  Future<void> loadTimeStatistic(int type) async {
    final now = DateTime.now();
    final startTime = now.millisecondsSinceEpoch ~/ 1000;
    int endTime;
    if (type == 1) {
      endTime =
          DateTime(now.year, now.month, now.day).millisecondsSinceEpoch ~/ 1000;
    } else if (type == 2) {
      endTime = startTime - 24 * 60 * 60;
    } else if (type == 3) {
      endTime = startTime - 7 * 24 * 60 * 60;
    } else if (type == 4) {
      endTime = 0;
    }
    await loadStatistic(startTime, endTime);
  }
}

class _ExplorePageState extends State<ExplorePage> with _ExplorePageStateMixin {
  @override
  void initState() {
    super.initState();
    loadTimeStatistic(1);
  }

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
          children: [
            buildSwitch(mainStore.exploreSwitch),
            buildStatistic(),
            ExploreTable(),
          ],
        ),
      );
    });
  }

  Widget buildStatisticNotNull() {
    return Column(
      children: [
        Row(
          children: [
            ResItem(assets: 'you.png', text: _statistic.oil.toString()),
            ResItem(assets: 'dan.png', text: _statistic.ammo.toString()),
            ResItem(assets: 'gang.png', text: _statistic.steel.toString()),
            ResItem(assets: 'lv.png', text: _statistic.aluminium.toString()),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            ResItem(assets: 'jl.png', text: _statistic.buildMap.toString()),
            ResItem(
                assets: 'zblt.png', text: _statistic.equipmentMap.toString()),
            ResItem(assets: 'kj.png', text: _statistic.fastBuild.toString()),
            ResItem(assets: 'kx.png', text: _statistic.fastRepair.toString()),
          ],
        )
      ],
    );
  }

  Widget buildStatisticLoading() {
    return Stack(
      children: [
        Column(
          children: const [
            Text(''),
            SizedBox(height: 5),
            Text(''),
          ],
        ),
        const Align(
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
        )
      ],
    );
  }

  Widget buildStatistic() {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    const Align(
                      child: Text('统计'),
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SmartSelect<int>.single(
                        title: '统计时间',
                        modalType: S2ModalType.popupDialog,
                        tileBuilder: (context, state) {
                          return InkWell(
                            child: const Icon(
                              Icons.date_range,
                              size: 18,
                              color: Color(0xFF222222),
                            ),
                            onTap: () {
                              state.showModal();
                            },
                          );
                        },
                        choiceItems: [
                          S2Choice(value: 1, title: '今日'),
                          S2Choice(value: 2, title: '24小时'),
                          S2Choice(value: 3, title: '一周'),
                          S2Choice(value: 4, title: '全部'),
                        ],
                        value: 1,
                        onChange: (value) => loadTimeStatistic(value.value),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _statistic != null && !isStatisticLoading
                    ? buildStatisticNotNull()
                    : buildStatisticLoading(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Card buildSwitch(bool value) {
    return Card(
      child: ListTile(
        title: const Text('远征开关'),
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: isSwitchLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                  ),
                )
              : Switch(
                  value: value ?? false,
                  onChanged: onExploreSwitch,
                ),
        ),
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
