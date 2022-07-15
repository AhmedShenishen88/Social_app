import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/home/Cubitbig/cubit_home.dart';
import 'package:social_app/styles/icons_broken.dart';

void showToast({@required String massage, @required lockToastStats state}) =>
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum lockToastStats { SUCCESS, ERROR, WARNING }

Color chooseToastColor(lockToastStats state) {
  Color color;
  switch (state) {
    case lockToastStats.SUCCESS:
      color = Colors.green;
      break;
    case lockToastStats.ERROR:
      color = Colors.red;
      break;
    case lockToastStats.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget defaultFormFieldSocial({
  @required TextEditingController controlText,
  @required TextInputType type,
  @required IconData prefix,
  @required String text,
  bool isPassword = false,
  @required Function validate,
  Function tap,
  Function onSubmit,
  Function change,
  bool visible = true,
  IconData suffix,
  Function suffixPressed,
}) =>
    TextFormField(
      onTap: tap,
      onFieldSubmitted: onSubmit,
      onChanged: change,
      keyboardType: type,
      style: TextStyle(color: Colors.black),
      enabled: visible,
      validator: validate,
      obscureText: isPassword,
      controller: controlText,
      decoration: InputDecoration(
          prefixIcon: Icon(prefix),
          labelText: text,
          suffix: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );

Widget customSendEmail(context) => ConditionalBuilder(
      condition: CubitHomeSocial.get(context).model != null,
      builder: (context) {
        var model = FirebaseAuth.instance.currentUser.emailVerified;
        print(model);
        return Column(
          children: [
            if (!model)
              Container(
                width: double.infinity,
                color: Colors.amber.withOpacity(0.6),
                child: Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(child: Text('Please Verified Your mail')),
                    SizedBox(width: 20.0),
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.currentUser
                              .sendEmailVerification()
                              .then((value) {
                            showToast(
                                massage: 'Check Email Verified',
                                state: lockToastStats.SUCCESS);
                          }).catchError((error) {
                            print(error.toString());
                          });
                        },
                        child: Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
          ],
        );
      },
      fallback: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

ThemeData whiteTheme() => ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    )),
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.deepOrange,
    appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
    ));
ThemeData darkTheme() => ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    )),
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: HexColor('333739'),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white, size: 20),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739'),
      elevation: 10.0,
      type: BottomNavigationBarType.fixed,
    ));
ThemeData customTheme() => ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        textTheme: TextTheme(
            bodyText1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backwardsCompatibility: false,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      elevation: 20,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    ));

Widget defaultAppBar({
  String title,
  List<Widget> actionButton,
  double spaceTitle = 3,
  Widget icon,
}) =>
    AppBar(
      title: Text(title),
      actions: actionButton,
      titleSpacing: spaceTitle,
      leading: icon,
    );

Widget sendMessageAn() => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200], width: 1),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'type your message here.....',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.blue),
            child: TextButton(
              onPressed: () {},
              child: Icon(
                IconBroken.Send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
