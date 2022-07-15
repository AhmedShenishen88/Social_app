import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:social_app/login_task/login_cubit/component/component.dart';
import 'package:social_app/login_task/login_cubit/login_cubit_h.dart';
import 'package:social_app/login_task/register/register_screen.dart';

import 'login_cubit/login_cubit_state.dart';

class LoginHome extends StatelessWidget {
  var forKey = GlobalKey<FormState>();
  var controlEmail = TextEditingController();
  var controlPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStateCubit>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: forKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image(
                        image: AssetImage('asserts/images/lo.png'),
                        height: 220.0,
                        width: 220.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Welcome back again',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Please write the correct email and password',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controlText: controlEmail,
                        type: TextInputType.emailAddress,
                        prefix: Icons.email,
                        text: 'Email Address',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'you must write your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controlText: controlPassword,
                        type: TextInputType.visiblePassword,
                        prefix: Icons.lock_outline,
                        text: 'Password',
                        isPassword: true,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'you must write your Password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topEnd,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'Forget Password',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 200,
                        child: MaterialButton(
                          child: Text('LOG IN',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (forKey.currentState.validate()) {}
                          },
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Or connect with',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SignInButton(
                            Buttons.Facebook,
                            mini: true,
                            onPressed: () {
                              print('facebook');
                            },
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () {
                              print('Google');
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('asserts/images/goog.png'),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          SignInButton(
                            Buttons.AppleDark,
                            mini: true,
                            text: 'APPLE',
                            onPressed: () {
                              print('Apple');
                            },
                          ),
                          // SizedBox(
                          //   width: 30,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Colors.blue[800],
                          //       borderRadius: BorderRadius.circular(30)),
                          //   child: MaterialButton(
                          //       onPressed: () {},
                          //       child: Row(
                          //         children: [
                          //           Image(
                          //             image:
                          //                 AssetImage('asserts/images/face.png'),
                          //             height: 20,
                          //             width: 20,
                          //           ),
                          //           SizedBox(
                          //             width: 10,
                          //           ),
                          //           Text(
                          //             'Facebook',
                          //             style: TextStyle(
                          //                 color: Colors.white, fontSize: 18),
                          //           )
                          //         ],
                          //       )),
                          // )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          MaterialButton(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
