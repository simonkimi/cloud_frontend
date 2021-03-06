import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/ui/components/drawer/drawer.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

mixin _ExplorePageStateMixin<T extends StatefulWidget> on State<T> {}

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
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(

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
