import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/build.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer.dart';
import 'package:cloud_frontend/ui/components/loading_button.dart';
import 'package:cloud_frontend/ui/components/paginated_table.dart';
import 'package:cloud_frontend/ui/components/res_row.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_frontend/utils/string_util.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_frontend/utils/time_utils.dart';

class BuildPage extends StatefulWidget {
  @override
  _BuildPageState createState() => _BuildPageState();
}

mixin _BuildPageStateMixin<T extends StatefulWidget> on State<T> {
  final _oilController = TextEditingController();
  final _ammoController = TextEditingController();
  final _steelController = TextEditingController();
  final _aluminiumController = TextEditingController();

  bool buildSwitch;
  int buildOil;
  int buildAmmo;
  int buildSteel;
  int buildAluminium;

  void initStoreState() {
    buildSwitch = mainStore.buildSwitch;
    buildOil = mainStore.buildOil;
    buildAmmo = mainStore.buildAmmo;
    buildSteel = mainStore.buildSteel;
    buildAluminium = mainStore.buildAluminium;
  }

  void initController() {
    _oilController.text = buildOil.toString();
    _ammoController.text = buildAmmo.toString();
    _steelController.text = buildSteel.toString();
    _aluminiumController.text = buildAluminium.toString();
  }

  Future<void> setBuild() async {
    try {
      await mainStore.setBuildSetting(
          buildSwitch, buildOil, buildAmmo, buildSteel, buildAluminium);
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
}

class _BuildPageState extends State<BuildPage> with _BuildPageStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initStoreState();
    initController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MainDrawer(tag: 'build'),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [buildSettingCard(context), buildTable()],
      ),
    );
  }

  Widget buildSettingCard(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text('设置'),
          SwitchListTile(
              title: const Text('建造开关'),
              value: buildSwitch,
              onChanged: (value) {
                setState(() {
                  buildSwitch = value;
                });
              }),
          ListTile(
            title: const Text('资源'),
            subtitle: ResRow(
              oil: buildOil,
              ammo: buildAmmo,
              steel: buildSteel,
              aluminium: buildAluminium,
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            onTap: showResDialog,
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
                    onPressed: setBuild,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTable() {
    return PaginatedTable<BuildResults, BuildBean>(
      columns: const [
        DataColumn(label: Text('名称')),
        DataColumn(label: Text('新船')),
        DataColumn(label: Text('时间')),
        DataColumn(label: Text('cid')),
      ],
      onLoadNextPage: api.getBuild,
      itemBuilder: (BuildResults data) {
        return DataRow(cells: [
          DataCell(Text(data.name)),
          DataCell(data.isNew ? const Icon(Icons.check) : const SizedBox()),
          DataCell(Text(
              DateFormat('MM-dd HH:mm:ss').format(data.createTime.bySeconds))),
          DataCell(Text(data.cid.toString())),
        ]);
      },
    );
  }

  Future<void> showResDialog() async {
    final validator = (String value) =>
        30 <= value.toInt && value.toInt <= 999 ? null : '资源错误';

    initController();
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('设置资源'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: ListBody(
                  children: [
                    TextFormField(
                      controller: _oilController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '油',
                      ),
                      validator: validator,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    TextFormField(
                      controller: _ammoController,
                      decoration: const InputDecoration(
                        labelText: '弹',
                      ),
                      validator: validator,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    TextFormField(
                      controller: _steelController,
                      decoration: const InputDecoration(
                        labelText: '钢',
                      ),
                      validator: validator,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    TextFormField(
                      controller: _aluminiumController,
                      decoration: const InputDecoration(
                        labelText: '铝',
                      ),
                      validator: validator,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      buildOil = _oilController.text.toInt;
                      buildAmmo = _ammoController.text.toInt;
                      buildSteel = _steelController.text.toInt;
                      buildSteel = _aluminiumController.text.toInt;
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('确定'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
              )
            ],
          );
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        '建造',
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
