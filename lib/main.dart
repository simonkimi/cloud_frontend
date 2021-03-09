import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/data/store/main_store.dart';
import 'package:cloud_frontend/ui/pages/build/build_page.dart';
import 'package:cloud_frontend/ui/pages/campaign/campaign_page.dart';
import 'package:cloud_frontend/ui/pages/equipment/equipment_page.dart';
import 'package:cloud_frontend/ui/pages/explore/explore_page.dart';
import 'package:cloud_frontend/ui/pages/home/home_page.dart';
import 'package:cloud_frontend/ui/pages/login/login_page.dart';
import 'package:cloud_frontend/ui/pages/pvp/pvp_page.dart';
import 'package:cloud_frontend/ui/pages/repair/repair_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await mainStore.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '云服务',
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'login/': (context) => LoginPage(),
        'explore/': (context) => ExplorePage(),
        'repair/': (context) => RepairPage(),
        'campaign/': (context) => CampaignPage(),
        'pvp/': (context) => PvpPage(),
        'build/': (context) => BuildPage(),
        'equipment/': (context) => EquipmentPage(),
      },
    );
  }
}
