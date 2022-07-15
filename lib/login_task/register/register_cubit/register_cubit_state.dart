abstract class RegisterStateCubit {}

class RegisterInitializeState extends RegisterStateCubit {}

class CubitSocialInitializeRegister extends RegisterStateCubit {}

class CubitStateSocialDataLoadingRegister2 extends RegisterStateCubit {}

class CubitStateSocialDataSuccessRegister2 extends RegisterStateCubit {}

class CubitStateSocialDataErrorRegister2 extends RegisterStateCubit {
  final error;
  CubitStateSocialDataErrorRegister2(this.error);
}

class ChangeSeeVisibilityPasswordStateRegister2 extends RegisterStateCubit {}
