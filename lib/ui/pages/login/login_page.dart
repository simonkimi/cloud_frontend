import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/constant.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'file:///H:/Web/cloud_frontend/lib/ui/components/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smart_select/smart_select.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

mixin _LoginPageStateMixin<T extends StatefulWidget> on State<T> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  int server = 0;
  bool isLoginPage = true;
  bool isLoading = false;

  Future<void> onLogin() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final username = _usernameController.value.text;
      final password = _passwordController.value.text;
      if (username.isEmpty || password.isEmpty) {
        BotToast.showText(text: '账号与密码不能为空!');
        return;
      }
      await mainStore.login(username, password);
      await mainStore.getMine();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } on DioError catch (e) {
      print(e);
      BotToast.showText(text: getDioErr(e));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> onRegister() async {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final username = _usernameController.value.text;
      final password = _passwordController.value.text;
      if (username.isEmpty || password.isEmpty) {
        BotToast.showText(text: '账号与密码不能为空!');
        return;
      }
      await mainStore.register(username, password, server);
      await mainStore.getMine();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } on DioError catch (e) {
      BotToast.showText(text: getDioErr(e));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class _LoginPageState extends State<LoginPage> with _LoginPageStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MainDrawer(),
      body: buildBody(context),
    );
  }


  @override
  void initState() {
    super.initState();
    print('_LoginPageState');
  }

  Widget buildBody(BuildContext context) {
    return Observer(builder: (context) {
      if (mainStore.isLogin && mounted) {
        Future.delayed(const Duration(seconds: 0), () {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        });
        return Container();
      }
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(child: child, scale: animation);
        },
        child:
            isLoginPage ? buildLoginCard(context) : buildRegisterCard(context),
      );
    });
  }

  Widget buildRegisterCard(BuildContext context) {
    return Center(
      key: const ValueKey('RegisterCard'),
      child: Container(
        width: 300,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '注册',
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
                const SizedBox(height: 20),
                SmartSelect.single(
                  value: 0,
                  title: '服务器',
                  modalType: S2ModalType.popupDialog,
                  onChange: (value) {
                    setState(() {
                      server = value.value;
                    });
                  },
                  choiceItems: SERVER_LIST
                      .map((key, value) => MapEntry(
                          key, S2Choice<int>(value: key, title: value)))
                      .values.toList(),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (!isLoading) {
                          setState(() {
                            isLoginPage = true;
                          });
                        }
                      },
                      child: const Text('已有账号?'),
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.zero)),
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      width: 65,
                      height: 35,
                      child: TextButton(
                        onPressed: onRegister,
                        child: isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text('注册'),
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
    );
  }

  Center buildLoginCard(BuildContext context) {
    return Center(
      key: const ValueKey('LoginCard'),
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
                      onPressed: () {
                        if (!isLoading) {
                          setState(() {
                            isLoginPage = false;
                          });
                        }
                      },
                      child: const Text('注册'),
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.zero)),
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      width: 65,
                      height: 35,
                      child: TextButton(
                        onPressed: onLogin,
                        child: isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text('登录'),
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
