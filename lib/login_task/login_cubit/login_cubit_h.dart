import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/login_task/login_cubit/login_cubit_state.dart';

class LoginCubit extends Cubit<LoginStateCubit> {
  LoginCubit() : super(LoginInitializeState());

  static LoginCubit get(context) => BlocProvider.of(context);
}
