import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:cloud_frontend/ui/components/drawer/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: MainDrawer(),
      body: Center(
        child: Card(
          child: Container(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '登录',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: '用户名'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: '密码'),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('注册'),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(0, 0)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.zero)),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        width: 65,
                        height: 35,
                        child: TextButton(
                          onPressed: () async {
                            try {
                              final username = _usernameController.value.text;
                              final password = _passwordController.value.text;
                              if (username.isEmpty || password.isEmpty) {
                                BotToast.showText(text: '账号与密码不能为空!');
                                return;
                              }
                              await mainStore.login(username, password);
                              await mainStore.getMine();
                            } on DioError catch (e) {
                              BotToast.showText(text: getDioErr(e));
                            }
                          },
                          child: const Text('登录'),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        '云服务',
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
