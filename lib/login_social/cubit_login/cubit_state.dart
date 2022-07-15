abstract class CubitSocialState {}

class CubitSocialInitialize extends CubitSocialState {}

class CubitStateSocialDataLoading extends CubitSocialState {}

class CubitStateSocialDataSuccess extends CubitSocialState {
  final String uId;

  CubitStateSocialDataSuccess(this.uId);
}

class CubitStateSocialDataError extends CubitSocialState {
  final error;
  CubitStateSocialDataError(this.error);
}

class ChangeSeeVisibilityPasswordState extends CubitSocialState {}
