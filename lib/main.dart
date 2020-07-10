import 'package:flutter/material.dart';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/common/application.dart';
import 'package:flutterapp/common/router_config.dart';
import 'package:flutterapp/ui/splash_screen.dart';
import 'package:flutterapp/utils/sp_utils.dart';
import 'package:flutterapp/common/common.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.getInstance();
  runApp(MyApp());
}




/// 这个 widget 作用这个应用的顶层 widget.
/// 这个 widget 是无状态的，所以我们继承的是 [StatelessWidget].
/// 对应的，有状态的 widget 可以继承 [StatefulWidget]
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}


class MyAppState extends State<MyApp> {
  /** 主题模式 */
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
    Application.eventBus = new EventBus();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName, // 标题
      debugShowCheckedModeBanner: false, //去掉debug图标
      theme: themeData,
      routes: Router.generateRoute(), // 存放路由的配置
      navigatorKey: navigatorKey,
      home: new SplashScreen(), // 启动页
    );
  }

  @override
  void dispose() {
    super.dispose();
    Application.eventBus.destroy();
  }
}
