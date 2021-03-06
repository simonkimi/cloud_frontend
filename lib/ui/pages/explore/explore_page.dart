import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

mixin _ExplorePageStateMixin<T extends StatefulWidget> on State<T> {
  bool isSwitchLoading = false;

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
        child: Column(
          children: [
            buildSwitch(mainStore.exploreSwitch),
          ],
        ),
      );
    });
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
