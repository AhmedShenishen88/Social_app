import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/model_create_users/model_create.dart';
import 'package:social_app/register_social/cubit_register/cubit_bottom_register/states_register.dart';

class CubitSocialRegister extends Cubit<CubitSocialStateRegister> {
  CubitSocialRegister() : super(CubitSocialInitializeRegister());

  static CubitSocialRegister get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(CubitStateSocialDataLoadingRegister());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      userCreate(
        uId: value.user.uid,
        phone: phone,
        email: email,
        name: name,
      );
    }).catchError((error) {
      print(error.toString());
      CubitStateSocialDataErrorRegister(error);
    });
  }

  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,
  }) {
    UserCreateModel model = UserCreateModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      bio: 'Write Your Bio....',
      image:
          'https://image.freepik.com/free-photo/confused-attractive-woman-dress-frowning-pointing-fingers-up-looking-puzzled-cant-understand_1258-64264.jpg',
      cover:
          'https://image.freepik.com/free-photo/hawaiian-tuna-poke-bowl-flat-lay-photography_53876-128376.jpg',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CubitStateSocialCreateUserSuccessRegister());
    }).catchError((error) {
      print(error.toString());
      CubitStateSocialCreateUserErrorRegister(error.toString());
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeSeeVisibilityPassword() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSeeVisibilityPasswordStateRegister());
  }
}
