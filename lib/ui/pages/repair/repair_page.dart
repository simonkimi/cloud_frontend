import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/repair.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer.dart';
import 'package:cloud_frontend/ui/components/loading_switch_tile.dart';
import 'package:cloud_frontend/ui/components/paginated_table.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:cloud_frontend/utils/time_utils.dart';

class RepairPage extends StatefulWidget {
  @override
  _RepairPageState createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  @override
  Widget build(BuildContext context) {
    if (!mainStore.isLogin) {
      Future.delayed(const Duration(seconds: 0), () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('login/', (route) => false);
      });
      return Container();
    }
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MainDrawer(tag: 'repair'),
      body: Observer(
        builder: (_) => buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          buildSwitch(),
          buildRepairTable(),
        ],
      ),
    );
  }

  Widget buildSwitch() {
    return Card(
      child: LoadingSwitchTile(
        title: const Text('修理开关'),
        value: mainStore.repairSwitch,
        onChange: (value) async {
          try {
            await mainStore.setRepairSwitch(value);
          } on DioError catch (e) {
            BotToast.showText(text: getDioErr(e));
          } catch (e) {
            BotToast.showText(text: e.toString());
          }
        },
      ),
    );
  }

  Widget buildRepairTable() {
    return PaginatedTable<RepairResults, RepairBean>(
      columns: const [
        DataColumn(label: Text('名称')),
        DataColumn(label: Text('时间')),
      ],
      onLoadNextPage: api.getRepair,
      itemBuilder: (RepairResults data) {
        return DataRow(cells: [
          DataCell(Text(data.name)),
          DataCell(Text(
              DateFormat('MM-dd HH:mm:ss').format(data.createTime.bySeconds))),
        ]);
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        '修理',
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
}
