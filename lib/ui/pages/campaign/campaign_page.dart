import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/constant.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/campaign.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer.dart';
import 'package:cloud_frontend/ui/components/loading_button.dart';
import 'package:cloud_frontend/ui/components/paginated_table.dart';
import 'package:cloud_frontend/ui/components/res_row.dart';
import 'package:cloud_frontend/ui/components/statistic_table.dart';
import 'package:intl/intl.dart';
import 'package:cloud_frontend/utils/time_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class CampaignPage extends StatefulWidget {
  @override
  _CampaignPageState createState() => _CampaignPageState();
}

mixin _CampaignPageStateMixin<T extends StatefulWidget> on State<T> {
  int campaignMap;
  int campaignFormat;

  void initStoreState() {
    campaignMap = mainStore.campaignMap;
    campaignFormat = mainStore.campaignFormat;
  }

  Future<void> setCampaign() async {
    try {
      await mainStore.setCampaignSetting(campaignMap, campaignFormat);
      setState(() {
        initStoreState();
      });
      BotToast.showText(text: '设置成功');
    } on DioError catch(e) {
      BotToast.showText(text: getDioErr(e));
    } catch(e) {
      BotToast.showText(text: e.toString());
    }
  }
}

class _CampaignPageState extends State<CampaignPage>
    with _CampaignPageStateMixin {
  @override
  void initState() {
    super.initState();
    initStoreState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MainDrawer(tag: 'campaign'),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListView(
        cacheExtent: 9999,
        children: [
          buildSettingCard(),
          buildStatistic(),
          buildTable()
        ],
      ),
    );
  }

  Widget buildStatistic() {
    return StatisticTable(
      onLoadStatistic: api.getCampaignStatistic,
      title: '战役统计',
      showDate: true,
      line: 2,
    );
  }

  Widget buildTable() {
    return PaginatedTable<CampaignResults, CampaignBean>(
      columns: const [
        DataColumn(label: Text('地图')),
        DataColumn(label: Text('资源')),
        DataColumn(label: Text('时间')),
      ],
      onLoadNextPage: api.getCampaign,
      itemBuilder: (CampaignResults data) {
        return DataRow(cells: [
          DataCell(Text(data.map)),
          DataCell(ResRow(
            oil: data.oil,
            ammo: data.ammo,
            steel: data.steel,
            aluminium: data.aluminium,
            ddCube: data.ddCube,
            clCube: data.clCube,
            bbCube: data.bbCube,
            cvCube: data.cvCube,
            ssCube: data.ssCube,
          )),
          DataCell(Text(
              DateFormat('MM-dd HH:mm:ss').format(data.createTime.bySeconds))),
        ]);
      },
    );
  }

  Widget buildSettingCard() {
    final campaignItems = CAMPAIGN_MAP.keys
        .map((e) => S2Choice(value: e, title: CAMPAIGN_MAP[e]))
        .toList()
          ..insert(0, S2Choice(value: 0, title: '关闭'));

    final campaignFormatItem = FLEET_FORMAT.keys
        .map((e) => S2Choice(value: e, title: FLEET_FORMAT[e]))
        .toList();

    return Card(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text('设置'),
          SmartSelect<int>.single(
            title: '战役地图',
            modalType: S2ModalType.popupDialog,
            choiceItems: campaignItems,
            value: campaignMap,
            onChange: (value) {
              setState(() {
                campaignMap = value.value;
              });
            },
          ),
          SmartSelect<int>.single(
            title: '战役阵型',
            modalType: S2ModalType.popupDialog,
            choiceItems: campaignFormatItem,
            value: campaignFormat,
            onChange: (value) {
              setState(() {
                campaignFormat = value.value;
              });
            },
          ),
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
                    onPressed: setCampaign,
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
        '战役',
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
