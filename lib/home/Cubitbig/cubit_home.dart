import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/end_points/endpoints.dart';
import 'package:social_app/home/Cubitbig/cubit_home_state.dart';
import 'package:social_app/home/chats/chats_screens.dart';
import 'package:social_app/home/feeds/feeds_screens.dart';
import 'package:social_app/home/settings/settings_screens.dart';
import 'package:social_app/home/users/users_screens.dart';
import 'package:social_app/models/model_create_users/model_create.dart';
import 'package:social_app/models/model_post/post_model.dart';
import 'package:social_app/models/modelcahts/modelchats.dart';
import 'package:social_app/post/pos_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CubitHomeSocial extends Cubit<CubitHomeState> {
  CubitHomeSocial() : super(InitializeStateHome());
  static CubitHomeSocial get(context) => BlocProvider.of(context);

  UserCreateModel model;
  void getUserData() {
    emit(LoadingGetDataStateHome());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = UserCreateModel.fromJson(value.data());
      emit(SuccessGetDataStateHome());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetDataStateHome(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'News Feed',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeCurrentScreen(int index) {
    if (index == 1) getAllUsers();

    if (index == 2) {
      emit(AddPostScreenSuccess());
    } else {
      currentIndex = index;
      emit(ChangeCurrentScreen());
    }
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      // source: ImageSource.camera,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ChooseImagePickerScreenSuccess());
    } else {
      print('No image selected.');
      emit(ChooseImagePickerScreenError());
    }
  }

  File profileCover;

  Future<void> getProfileCover() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileCover = File(pickedFile.path);
      print(pickedFile.path);
      emit(ChooseCoverPickerScreenSuccess());
    } else {
      print('No image selected.');
      emit(ChooseCoverPickerScreenError());
    }
  }

  void uploadingProfileImage({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(UpdateScreenLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(UploadImageScreenSuccess());
        print(value);
        updateUserData(name: name, bio: bio, phone: phone, image: value);
      }).catchError((error) {
        emit(UploadImageScreenError());
      });
    }).catchError((error) {
      emit(UploadImageScreenError());
    });
  }

  void uploadingProfileCover({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(UpdateScreenLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileCover.path).pathSegments.last}')
        .putFile(profileCover)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(UploadCoverScreenSuccess());
        print(value);
        updateUserData(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((error) {
        emit(UploadCoverScreenError());
      });
    }).catchError((error) {
      emit(UploadCoverScreenError());
    });
  }

  // void updateProfile({
  //   @required String name,
  //   @required String bio,
  //   @required String phone,
  // }) {
  //
  //
  //   if (profileCover != null) {
  //     uploadingProfileCover();
  //   } else if (profileImage != null) {
  //     uploadingProfileImage();
  //   } else {
  //     updateUserData(
  //       bio: bio,
  //       name: name,
  //       phone: phone,
  //     );
  //   }
  // }

  void updateUserData({
    @required String name,
    @required String bio,
    @required String phone,
    String cover,
    String image,
  }) {
    //emit(UpdateScreenLoading());
    UserCreateModel userCreateModel = UserCreateModel(
      image: image ?? model.image,
      cover: cover ?? model.cover,
      uId: model.uId,
      isEmailVerified: false,
      phone: phone,
      name: name,
      bio: bio,
      email: model.email,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(userCreateModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateScreenError());
    });
  }

  File postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ChooseCoverPickerScreenSuccess());
    } else {
      print('No image selected.');
      emit(ChooseCoverPickerScreenError());
    }
  }

  void uploadingPostImage({
    @required String text,
    @required String timeDate,
  }) {
    emit(UploadPostImageLoading());
    firebase_storage.FirebaseStorage.instance
        .ref('posts')
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, imagePost: value, dateTime: timeDate);
      }).catchError((error) {
        emit(UploadPostImageError());
      });
    }).catchError((error) {
      emit(UploadPostImageError());
    });
  }

  void createPost(
      {@required String text, String imagePost, @required String dateTime}) {
    emit(CreatePostLoading());

    UserCreatePost modelPost = UserCreatePost(
      name: model.name,
      uId: model.uId,
      image: model.image,
      text: text,
      postImage: imagePost ?? '',
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(modelPost.toMap())
        .then((value) {
      emit(CreatePostSuccess());
    }).catchError((error) {
      emit(CreatePostError());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageSuccess());
  }

  void removeImageSender() {
    imageSend = null;
    emit(RemoveImageSenderSuccess());
  }

  List<UserCreatePost> postItem = [];
  List<String> postId = [];
  List<int> like = [];
  List<int> comment = [];
  void getPost() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      emit(SuccessGetPostDataStateHome());
      value.docs.forEach((element) {
        // element.reference.collection('comment').get().then((value) {
        //   comment.add(value.docs.length);
        //   postId.add(element.id);
        //   postItem.add(UserCreatePost.fromJson(element.data()));
        // }).catchError(onError);
        element.reference.collection('likes').get().then((value) {
          like.add(value.docs.length);
          postId.add(element.id);
          postItem.add(UserCreatePost.fromJson(element.data()));
        }).catchError(onError);
      });
    }).catchError((error) {
      emit(ErrorGetPostDataStateHome(error.toString()));
    });
  }

  void createLike(String postUId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postUId)
        .collection('likes')
        .doc(model.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SuccessGetPostLikeStateHome());
    }).catchError((error) {
      ErrorGetPostLikeStateHome(error.toString());
    });
  }

  void getComment(String idComment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(idComment)
        .collection('comment')
        .doc(model.uId)
        .set({'comment': true}).then((value) {
      emit(SuccessGetPostCommentStateHome());
    }).catchError((error) {
      emit(SuccessGetPostCommentStateHome());
    });
  }

  List<UserCreateModel> allUsers = [];

  void getAllUsers() {
    // emit(LoadingGetAllUsersStateHome());
    if (allUsers.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        emit(SuccessGetAllUsersStateHome());
        value.docs.forEach((element) {
          if (element.data()['uId'] != model.uId)
            allUsers.add(UserCreateModel.fromJson(element.data()));
        });
      }).catchError((error) {
        emit(ErrorGetAllUsersStateHome(error.toString()));
      });
  }

  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String text,
  }) {
    ChatDetailsModel chatModel = ChatDetailsModel(
      text: text,
      sendId: model.uId,
      receiveId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });
  }

  void sendChatDetails({
    @required String text,
    @required String dateTime,
    @required String receiveID,
    @required String image,
  }) {
    ChatDetailsModel modelDetails = ChatDetailsModel(
      dateTime: dateTime,
      text: text,
      receiveId: receiveID,
      sendId: model.uId,
      image: image ?? '',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiveID)
        .collection('messages')
        .add(modelDetails.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiveID)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(modelDetails.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });
  }

  List<ChatDetailsModel> messages = [];

  void getMessages({
    @required String receiveID,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiveID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatDetailsModel.fromJson(element.data()));
      });
      emit(SuccessGetAllChatsDetailsStateHome());
    });
  }

  File imageSend;

  Future<void> getImageSend() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageSend = File(pickedFile.path);
      print(pickedFile.path);
      emit(ChooseCoverPickerScreenSuccess());
    } else {
      print('No image selected.');
      emit(ChooseCoverPickerScreenError());
    }
  }

  void uploadingImageSend({
    @required String text,
    @required String dateTime,
    @required String receiveID,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref('messages')
        .child('messages/${Uri.file(imageSend.path).pathSegments.last}')
        .putFile(imageSend)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendChatDetails(
            text: text, dateTime: dateTime, receiveID: receiveID, image: value);
      }).catchError((error) {
        emit(ErrorGetImageSendDetailsStateHome(error.toString()));
      });
    }).catchError((error) {
      emit(ErrorGetImageSendDetailsStateHome(error.toString()));
    });
  }
}
