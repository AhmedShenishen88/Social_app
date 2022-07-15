import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/compoent_social.dart';
import 'package:social_app/home/home_screen.dart';
import 'package:social_app/login_social/cubit_login/cubit_state.dart';
import 'package:social_app/login_social/login_screen/login.dart';
import 'package:social_app/register_social/cubit_register/cubit_bottom_register/cubit_screen_register.dart';
import 'package:social_app/register_social/cubit_register/cubit_bottom_register/states_register.dart';

class RegisterScreenSocial extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textNameControl = TextEditingController();
  var textEmailControl = TextEditingController();
  var textPasswordControl = TextEditingController();
  var textPhoneControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CubitSocialRegister(),
        child: BlocConsumer<CubitSocialRegister, CubitSocialStateRegister>(
          listener: (context, state) {
            if (state is CubitStateSocialCreateUserSuccessRegister) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Register',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: Colors.black)),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                                "Don't Forget your Name , Email ,Password And Phone ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.grey)),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormFieldSocial(
                              controlText: textNameControl,
                              type: TextInputType.name,
                              prefix: Icons.person,
                              text: 'Name',
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'name Must Not Empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormFieldSocial(
                              controlText: textEmailControl,
                              type: TextInputType.emailAddress,
                              prefix: Icons.email,
                              text: 'Email Address',
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Email Must Not Empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormFieldSocial(
                                controlText: textPasswordControl,
                                isPassword:
                                    CubitSocialRegister.get(context).isPassword,
                                onSubmit: (value) {
                                  if (formKey.currentState.validate()) {
                                    CubitSocialRegister.get(context)
                                        .userRegister(
                                      name: textNameControl.text,
                                      email: textEmailControl.text,
                                      password: textPasswordControl.text,
                                      phone: textPhoneControl.text,
                                    );
                                  }
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Password Must Not Empty';
                                  }
                                  return null;
                                },
                                type: TextInputType.visiblePassword,
                                prefix: Icons.lock_outline,
                                suffix: CubitSocialRegister.get(context).suffix,
                                suffixPressed: () {
                                  CubitSocialRegister.get(context)
                                      .changeSeeVisibilityPassword();
                                },
                                text: 'Password'),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormFieldSocial(
                              controlText: textPhoneControl,
                              type: TextInputType.phone,
                              prefix: Icons.phone,
                              text: 'Phone',
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Phone Must Not Empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition:
                                  state is! CubitStateSocialDataLoadingRegister,
                              builder: (context) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      CubitSocialRegister.get(context)
                                          .userRegister(
                                        name: textNameControl.text,
                                        email: textEmailControl.text,
                                        password: textPasswordControl.text,
                                        phone: textPhoneControl.text,
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              fallback: (context) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have account ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreenSocial()
                                              //RegisterScreen()
                                              ));
                                    },
                                    child: Text('Log in'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue)))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
