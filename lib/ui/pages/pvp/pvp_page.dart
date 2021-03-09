import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/constant.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/pvp.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer.dart';
import 'package:cloud_frontend/ui/components/loading_button.dart';
import 'package:cloud_frontend/ui/components/paginated_table.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:cloud_frontend/utils/time_utils.dart';
import 'package:intl/intl.dart';

class PvpPage extends StatefulWidget {
  @override
  _PvpPageState createState() => _PvpPageState();
}

mixin _PvpPageStateMixin<T extends StatefulWidget> on State<T> {
  int pvpFleet;
  int pvpFormat;
  bool pvpNight;

  Future<void> setPvp() async {
    try {
      await mainStore.setPvpSetting(pvpFleet, pvpFormat, pvpNight);
      setState(() {
        initStoreState();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('设置成功'),
        duration: Duration(seconds: 1),
      ));
    } on DioError catch (e) {
      BotToast.showText(text: getDioErr(e));
    } catch (e) {
      BotToast.showText(text: e.toString());
    }
  }

  void initStoreState() {
    pvpFleet = mainStore.pvpFleet;
    pvpFormat = mainStore.pvpFormat;
    pvpNight = mainStore.pvpNight;
  }
}

class _PvpPageState extends State<PvpPage> with _PvpPageStateMixin {
  @override
  void initState() {
    super.initState();
    initStoreState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      drawer: const MainDrawer(tag: 'pvp'),
    );
  }

  Padding buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [buildSettingCard(), buildTable()],
      ),
    );
  }

  Widget buildTable() {
    return PaginatedTable<PvpResults, PvpBean>(
      columns: const [
        DataColumn(label: Text('评级')),
        DataColumn(label: Text('用户名')),
        DataColumn(label: Text('UID')),
        DataColumn(label: Text('时间')),
        DataColumn(label: Text('对方阵容')),
      ],
      onLoadNextPage: api.getPvp,
      itemBuilder: (PvpResults data) {
        return DataRow(cells: [
          DataCell(Text(PVP_RESULT[data.result])),
          DataCell(Text(data.username)),
          DataCell(Text(data.uid.toString())),
          DataCell(Text(
              DateFormat('MM-dd HH:mm:ss').format(data.createTime.bySeconds))),
          DataCell(Text(data.ships.split('||').join('  ')))
        ]);
      },
    );
  }

  Widget buildSettingCard() {
    final fleetItem = <S2Choice<int>>[
      S2Choice(value: 0, title: '关闭'),
      S2Choice(value: 1, title: '一队'),
      S2Choice(value: 2, title: '二队'),
      S2Choice(value: 3, title: '三队'),
      S2Choice(value: 4, title: '四队'),
    ];

    final formatItem = FLEET_FORMAT.keys
        .map((e) => S2Choice(value: e, title: FLEET_FORMAT[e]))
        .toList();

    return Card(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text('设置'),
          SmartSelect<int>.single(
            title: '队伍',
            modalType: S2ModalType.popupDialog,
            choiceItems: fleetItem,
            value: pvpFleet,
            onChange: (value) {
              setState(() {
                pvpFleet = value.value;
              });
            },
          ),
          SmartSelect<int>.single(
            title: '阵型',
            modalType: S2ModalType.popupDialog,
            choiceItems: formatItem,
            value: pvpFormat,
            onChange: (value) {
              setState(() {
                pvpFormat = value.value;
              });
            },
          ),
          SwitchListTile(
              title: const Text('夜战'),
              value: pvpNight,
              onChanged: (value) {
                setState(() {
                  pvpNight = value;
                });
              }),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 55,
                  height: 35,
                  child: LoadingButton(
                    child: const Text('确定'),
                    onPressed: setPvp,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        '演习',
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
