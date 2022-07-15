import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/login_task/register/register_cubit/register_cubit_state.dart';

class RegisterCubit extends Cubit<RegisterStateCubit> {
  RegisterCubit() : super(RegisterInitializeState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  void userLogin({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(CubitStateSocialDataLoadingRegister2());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      emit(CubitStateSocialDataSuccessRegister2());
    }).catchError((error) {
      print(error.toString());
      CubitStateSocialDataErrorRegister2(error);
    });
  }
}
