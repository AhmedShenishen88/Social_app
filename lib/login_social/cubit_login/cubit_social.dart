import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit_state.dart';

class CubitSocial extends Cubit<CubitSocialState> {
  CubitSocial() : super(CubitSocialInitialize());

  static CubitSocial get(context) => BlocProvider.of(context);

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(CubitStateSocialDataLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      emit(CubitStateSocialDataSuccess(value.user.uid));
    }).catchError((error) {
      print(error.toString());
      emit(CubitStateSocialDataError(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changeSeeVisibilityPassword() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeSeeVisibilityPasswordState());
  }
}
