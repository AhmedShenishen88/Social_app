abstract class CubitHomeState {}

class InitializeStateHome extends CubitHomeState {}

class LoadingGetDataStateHome extends CubitHomeState {}

class SuccessGetDataStateHome extends CubitHomeState {}

class ErrorGetDataStateHome extends CubitHomeState {
  final error;

  ErrorGetDataStateHome(this.error);
}

class ChangeCurrentScreen extends CubitHomeState {}

class AddPostScreenSuccess extends CubitHomeState {}

class ChooseImagePickerScreenSuccess extends CubitHomeState {}

class ChooseImagePickerScreenError extends CubitHomeState {}

class ChooseCoverPickerScreenSuccess extends CubitHomeState {}

class ChooseCoverPickerScreenError extends CubitHomeState {}

class UploadImageScreenSuccess extends CubitHomeState {}

class UploadImageScreenError extends CubitHomeState {}

class UploadCoverScreenSuccess extends CubitHomeState {}

class UploadCoverScreenError extends CubitHomeState {}

class UpdateScreenError extends CubitHomeState {}

class UpdateScreenLoading extends CubitHomeState {}

class UploadPostImageSuccess extends CubitHomeState {}

class UploadPostImageLoading extends CubitHomeState {}

class UploadPostImageError extends CubitHomeState {}

class CreatePostError extends CubitHomeState {}

class CreatePostLoading extends CubitHomeState {}

class CreatePostSuccess extends CubitHomeState {}

class RemovePostImageSuccess extends CubitHomeState {}

class RemoveImageSenderSuccess extends CubitHomeState {}

class SuccessGetPostDataStateHome extends CubitHomeState {}

class ErrorGetPostDataStateHome extends CubitHomeState {
  final error;

  ErrorGetPostDataStateHome(this.error);
}

class SuccessGetPostLikeStateHome extends CubitHomeState {}

class ErrorGetPostLikeStateHome extends CubitHomeState {
  final error;

  ErrorGetPostLikeStateHome(this.error);
}

class SuccessGetPostCommentStateHome extends CubitHomeState {}

class ErrorGetPostCommentStateHome extends CubitHomeState {
  final error;

  ErrorGetPostCommentStateHome(this.error);
}

class LoadingGetAllUsersStateHome extends CubitHomeState {}

class SuccessGetAllUsersStateHome extends CubitHomeState {}

class ErrorGetAllUsersStateHome extends CubitHomeState {
  final error;

  ErrorGetAllUsersStateHome(this.error);
}

class SuccessSendAllChatsDetailsStateHome extends CubitHomeState {}

class ErrorSendAllChatsDetailsStateHome extends CubitHomeState {
  final error;

  ErrorSendAllChatsDetailsStateHome(this.error);
}

class SuccessGetAllChatsDetailsStateHome extends CubitHomeState {}

class ErrorGetAllChatsDetailsStateHome extends CubitHomeState {
  final error;

  ErrorGetAllChatsDetailsStateHome(this.error);
}

class SuccessGetImageSendDetailsStateHome extends CubitHomeState {}

class ErrorGetImageSendDetailsStateHome extends CubitHomeState {
  final error;

  ErrorGetImageSendDetailsStateHome(this.error);
}
