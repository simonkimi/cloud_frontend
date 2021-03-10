import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key, this.tag}) : super(key: key);
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Observer(
        builder: (_) {
          return Column(
            children: [
              UserAccountsDrawerHeader(
                accountEmail: Text(mainStore.nickname ?? '未登录'),
                accountName: Text(mainStore.username ?? '未登录'),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage('assets/img/header.jpg'))),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('主页'),
                      onTap: () {
                        if (tag != 'home') {
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/', (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.format_list_bulleted),
                      title: const Text('远征'),
                      onTap: () {
                        if (tag != 'explore') {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'explore/', (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.king_bed_outlined),
                      title: const Text('修理'),
                      onTap: () {
                        if (tag != 'repair') {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'repair/', (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.api),
                      title: const Text('战役'),
                      onTap: () {
                        if (tag != 'campaign') {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'campaign/', (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.supervisor_account_sharp),
                      title: const Text('演习'),
                      onTap: () {
                        if (tag != 'pvp') {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'pvp/', (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.build),
                      title: const Text('建造'),
                      onTap: () {
                        if (tag != 'build') {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'build/', (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings_applications_outlined),
                      title: const Text('开发'),
                      onTap: () {
                        if (tag != 'equipment') {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'equipment/', (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('设置'),
                      onTap: () {
                        if (tag != 'setting') {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'setting/', (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
