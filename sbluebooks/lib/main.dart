import 'package:comlogin_sdk/comlogin_sdk.dart';
import 'package:comlogin_sdk/dao/login_dao.dart';

import 'package:comlogin_sdk/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sbluebooks/pages/bottom_navigator.dart';
import 'package:sbluebooks/provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget get _loadingPage => const MaterialApp(
          home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ));

  // This widget is the root of your application.5
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: doInt(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            widget = (LoginDao().getBoardingPass() == null)
                ? const LoginPage()
                : const BottomNavigator();
          } else {
            return _loadingPage;
          }
          return MultiProvider(
            providers: mainProviders,
            child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: widget),
          );
        });
  }

  Future<void> doInt() async {
    hideScreen();
    await LoginConfig.instance().init(homePage: const BottomNavigator());
    await HiCache.preInit();
  }

  Future<void> hideScreen() async {
    Future.delayed(const Duration(milliseconds: 1800), () {
      FlutterSplashScreen.hide();
    });
  }
}
