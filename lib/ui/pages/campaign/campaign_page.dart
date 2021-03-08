import 'package:cloud_frontend/data/constant.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/ui/components/drawer.dart';
import 'package:cloud_frontend/ui/components/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class CampaignPage extends StatefulWidget {
  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  int campaignMap;
  int campaignFormat;

  @override
  void initState() {
    super.initState();
    campaignMap = mainStore.campaignMap;
    campaignFormat = mainStore.campaignFormat;
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
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          buildSettingCard(),
        ],
      ),
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
          const Text('设置', style: TextStyle(fontSize: 15)),
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
                    onPressed: () async {
                      await Future.delayed(const Duration(seconds: 3));
                    },
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
