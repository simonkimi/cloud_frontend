import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer.dart';
import 'package:cloud_frontend/ui/components/text_input_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

mixin _SettingPageStateMixin<T extends StatefulWidget> on State<T> {
  var _code = '';
}

class _SettingPageState extends State<SettingPage> with _SettingPageStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MainDrawer(tag: 'setting'),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [buildCode()],
      ),
    );
  }

  Widget buildCode() {
    return Card(
      child: Column(
        children: [
          const SizedBox(height: 5),
          TextInputTile(
            title: const Text('激活码'),
            subtitle: Text(_code.isNotEmpty ? _code : '请输入激活码'),
            onChanged: (value) {
              setState(() {
                _code = value;
              });
            },
            positiveText: '确定',
            negativeText: '取消',
            labelText: '10位字符串',
            dialogTitle: const Text('激活码'),
          ),
          const Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () async {
                    await launch(
                        'http://huananka.com/liebiao/952E8D8DCEDEB4F1');
                  },
                  child: const Text('购买')),
              const Expanded(child: SizedBox()),
              TextButton(
                  onPressed: () async {
                    try {
                      if (_code.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('请输入激活码'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        return;
                      }
                      await mainStore.active(_code);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('激活成功'),
                        duration: Duration(seconds: 1),
                      ));
                    } on DioError catch (e) {
                      BotToast.showText(text: getDioErr(e));
                    } catch (e) {
                      BotToast.showText(text: e.toString());
                    }
                  },
                  child: const Text('激活')),
            ],
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        '设置',
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
