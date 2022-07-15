import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/compoent_social.dart';
import 'package:social_app/home/Cubitbig/cubit_home.dart';
import 'package:social_app/home/home_screen.dart';
import 'package:social_app/network/sharedpreferance/shared.dart';
import 'end_points/endpoints.dart';
import 'login_social/cubit_login/cubit_observe.dart';
import 'login_social/login_screen/login.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on BackGround Message Success');
  print(message.data.toString());

  showToast(
      massage: 'on BackGround Message Success', state: lockToastStats.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  var token = await FirebaseMessaging.instance.getToken();

  print('token here');
  print(token);

  // ForGround message
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(massage: 'on message', state: lockToastStats.SUCCESS);
  });

  //For Click On Message
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(massage: 'on Message Opening App', state: lockToastStats.SUCCESS);
  });

  //For BackGround Message
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await CacheHelper.init();

  Widget widget;

  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreenSocial();
  }

  runApp(MaterialHome(
    startWidget: widget,
  ));
}

class MaterialHome extends StatelessWidget {
  final Widget startWidget;

  MaterialHome({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CubitHomeSocial()
              ..getUserData()
              ..getPost()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(
                bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'jannah'),
                subtitle1: TextStyle(fontSize: 16.0, color: Colors.white)),
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
                elevation: 0.0,
                backgroundColor: Colors.white,
                // backwardsCompatibility: false,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.black, size: 20),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                )),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              elevation: 10.0,
              type: BottomNavigationBarType.fixed,
            )),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
