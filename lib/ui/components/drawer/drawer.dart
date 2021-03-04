import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountEmail: Text('simon_xu'),
            accountName: Text('simon菌'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/imgs/header.jpg'))),
          ),
          Expanded(
              child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('主页'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.format_list_bulleted),
                title: const Text('远征'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.king_bed_outlined),
                title: const Text('修理'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.api),
                title: const Text('战役'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.supervisor_account_sharp),
                title: const Text('演习'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.build),
                title: const Text('开发/建造'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('设置'),
                onTap: () {},
              ),
            ],
          ))
        ],
      ),
    );
  }
}
