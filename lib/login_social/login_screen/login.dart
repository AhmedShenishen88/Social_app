import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/compoent_social.dart';
import 'package:social_app/home/home_screen.dart';
import 'package:social_app/login_social/cubit_login/cubit_social.dart';
import 'package:social_app/login_social/cubit_login/cubit_state.dart';
import 'package:social_app/network/sharedpreferance/shared.dart';
import 'package:social_app/register_social/register_social/register_screen_social.dart';

class LoginScreenSocial extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textEmailControl = TextEditingController();
  var textPasswordControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CubitSocial(),
        child: BlocConsumer<CubitSocial, CubitSocialState>(
          listener: (context, state) {
            if (state is CubitStateSocialDataError) {
              showToast(massage: state.error, state: lockToastStats.ERROR);
            }
            if (state is CubitStateSocialDataSuccess) {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              });
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: Colors.black)),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Don't Forget your Email And Password ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.grey)),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormFieldSocial(
                                controlText: textEmailControl,
                                type: TextInputType.emailAddress,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Email Must Not Empty';
                                  }
                                  return null;
                                },
                                text: 'Email',
                                prefix: Icons.email),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormFieldSocial(
                                controlText: textPasswordControl,
                                isPassword: CubitSocial.get(context).isPassword,
                                onSubmit: (value) {
                                  if (formKey.currentState.validate()) {
                                    CubitSocial.get(context).userLogin(
                                        email: textEmailControl.text,
                                        password: textPasswordControl.text);
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
                                suffix: CubitSocial.get(context).suffix,
                                suffixPressed: () {
                                  CubitSocial.get(context)
                                      .changeSeeVisibilityPassword();
                                },
                                text: 'Password'),
                            SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! CubitStateSocialDataLoading,
                              builder: (context) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      CubitSocial.get(context).userLogin(
                                          email: textEmailControl.text,
                                          password: textPasswordControl.text);
                                    }
                                  },
                                  child: Text(
                                    'LOGIN',
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
                                  "Don't have Email ",
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
                                                  RegisterScreenSocial()));
                                    },
                                    child: Text('Register'.toUpperCase(),
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
