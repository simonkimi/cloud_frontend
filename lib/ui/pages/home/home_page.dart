import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/ui/components/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'home_store.dart';

class HomePage extends StatelessWidget {
  final store = HomeStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: MainDrawer(),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        '主页',
        style: TextStyle(fontSize: 18),
      ),
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

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildBody(BuildContext context) {
    return Observer(builder: (_) {
      if (mainStore.isInit && !mainStore.isLogin) {
        Future.delayed(const Duration(seconds: 0), () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('login/', (route) => false);
        });
        return Container();
      }
      if (store.isLoading) {
        return buildLoading();
      }
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            buildRes(),
            const SizedBox(height: 10),
            buildExplore(),
          ],
        ),
      );
    });
  }

  Widget buildResItem(String imgPath, String text) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/imgs/$imgPath'),
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 3),
          Text(text)
        ],
      ),
    );
  }

  Widget buildExplore() {
    final exploreCard = store.dashBoardData.explore.map((e) {
      final stamp = DateTime.now().millisecondsSinceEpoch;
      final time = ((stamp - e.endTime).abs() / 60).toString();

      return Expanded(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE4E7ED), width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Column(
            children: [Text(e.map.replaceAll('000', '-')), Text(time)],
          ),
        ),
      );
    }).toList();

    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text('远征列表'),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFE4E7ED), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        children: [Text('2-1'), Text('2021/3/5')],
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFE4E7ED), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        children: [Text('2-1'), Text('2021/3/5')],
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFE4E7ED), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        children: [Text('2-1'), Text('2021/3/5')],
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFE4E7ED), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        children: [Text('2-1'), Text('2021/3/5')],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRes() {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text('资源列表'),
              const SizedBox(height: 5),
              Row(
                children: [
                  buildResItem(
                      'you.png', store.dashBoardData.resource.oil.toString()),
                  buildResItem(
                      'dan.png', store.dashBoardData.resource.ammo.toString()),
                  buildResItem('gang.png',
                      store.dashBoardData.resource.steel.toString()),
                  buildResItem('lv.png',
                      store.dashBoardData.resource.aluminium.toString()),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  buildResItem('jl.png',
                      store.dashBoardData.resource.buildMap.toString()),
                  buildResItem('zblt.png',
                      store.dashBoardData.resource.equipmentMap.toString()),
                  buildResItem('kj.png',
                      store.dashBoardData.resource.fastBuild.toString()),
                  buildResItem('kx.png',
                      store.dashBoardData.resource.fastRepair.toString()),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  buildResItem(
                      'qz.png', store.dashBoardData.resource.ddCube.toString()),
                  buildResItem(
                      'xy.png', store.dashBoardData.resource.clCube.toString()),
                  buildResItem(
                      'zl.png', store.dashBoardData.resource.bbCube.toString()),
                  buildResItem(
                      'hm.png', store.dashBoardData.resource.cvCube.toString()),
                  buildResItem(
                      'qt.png', store.dashBoardData.resource.ssCube.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
