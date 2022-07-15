import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/login_task/login_cubit/component/component.dart';
import 'package:social_app/login_task/login_task.dart';
import 'package:social_app/login_task/register/register_cubit/register_cubit_h.dart';
import 'package:social_app/login_task/register/register_cubit/register_cubit_state.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var controlEmail = TextEditingController();
  var controlPassword = TextEditingController();
  var controlName = TextEditingController();
  var controlPhone = TextEditingController();
  var controlConfirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStateCubit>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Let's Get Started",
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
                        'Create an account to Q Allure to get all features',
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
                        controlText: controlName,
                        type: TextInputType.name,
                        prefix: Icons.person,
                        text: 'Fall Name',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'you must write your Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
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
                        height: 30.0,
                      ),
                      defaultFormField(
                        controlText: controlPhone,
                        type: TextInputType.phone,
                        prefix: Icons.phone,
                        text: 'Phone',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'you must write your Phone';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
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
                        height: 30,
                      ),
                      defaultFormField(
                        controlText: controlConfirmPassword,
                        type: TextInputType.visiblePassword,
                        prefix: Icons.lock_outline,
                        text: 'Confirm Password',
                        isPassword: true,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'you must write your Confirm Password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // Container(
                      //   width: 200,
                      //   child: MaterialButton(
                      //     child: Text('Create',
                      //         style: TextStyle(
                      //             fontSize: 17,
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold)),
                      //     onPressed: () {
                      //       if (forKey.currentState.validate()) {}
                      //     },
                      //   ),
                      //   decoration: BoxDecoration(
                      //       color: Colors.blue[900],
                      //       borderRadius: BorderRadius.circular(30)),
                      // ),
                      ConditionalBuilder(
                        condition:
                            state is! CubitStateSocialDataLoadingRegister2,
                        builder: (context) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                RegisterCubit.get(context).userLogin(
                                  name: controlName.text,
                                  email: controlEmail.text,
                                  password: controlPassword.text,
                                  phone: controlPhone.text,
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
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          MaterialButton(
                              child: Text(
                                'Login here',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginHome()));
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
