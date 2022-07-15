abstract class CubitSocialStateRegister {}

class CubitSocialInitializeRegister extends CubitSocialStateRegister {}

class CubitStateSocialDataLoadingRegister extends CubitSocialStateRegister {}

class CubitStateSocialDataSuccessRegister extends CubitSocialStateRegister {}

class CubitStateSocialDataErrorRegister extends CubitSocialStateRegister {
  final error;
  CubitStateSocialDataErrorRegister(this.error);
}

class CubitStateSocialCreateUserSuccessRegister
    extends CubitSocialStateRegister {}

class CubitStateSocialCreateUserErrorRegister extends CubitSocialStateRegister {
  final error;
  CubitStateSocialCreateUserErrorRegister(this.error);
}

class ChangeSeeVisibilityPasswordStateRegister
    extends CubitSocialStateRegister {}
