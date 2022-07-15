import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/compoent_social.dart';
import 'package:social_app/home/Cubitbig/cubit_home.dart';
import 'package:social_app/home/Cubitbig/cubit_home_state.dart';
import 'package:social_app/models/model_create_users/model_create.dart';
import 'package:social_app/styles/icons_broken.dart';

class UpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameControl = TextEditingController();
    var bioControl = TextEditingController();
    var phoneControl = TextEditingController();
    return BlocConsumer<CubitHomeSocial, CubitHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userCreateModel = CubitHomeSocial.get(context).model;

        var profileImagePicker = CubitHomeSocial.get(context).profileImage;
        var profileCoverPicker = CubitHomeSocial.get(context).profileCover;

        nameControl.text = userCreateModel.name;
        bioControl.text = userCreateModel.bio;
        phoneControl.text = userCreateModel.phone;
        return Scaffold(
          appBar: defaultAppBar(
              spaceTitle: 5,
              title: 'Edit Profile',
              icon: IconButton(
                icon: Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actionButton: [
                MaterialButton(
                  onPressed: () {
                    CubitHomeSocial.get(context).updateUserData(
                        name: nameControl.text,
                        bio: bioControl.text,
                        phone: phoneControl.text);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 16.0),
                  ),
                )
              ]),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (state is UpdateScreenLoading) LinearProgressIndicator(),
                  if (state is UpdateScreenLoading)
                    SizedBox(
                      height: 10,
                    ),
                  Container(
                    height: 210,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: profileCoverPicker == null
                                          ? NetworkImage(
                                              '${userCreateModel.cover}')
                                          : FileImage(profileCoverPicker),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    CubitHomeSocial.get(context)
                                        .getProfileCover();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 55.0,
                              backgroundColor: Colors.blue,
                              child: CircleAvatar(
                                radius: 53.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 51.0,
                                  backgroundImage: profileImagePicker == null
                                      ? NetworkImage('${userCreateModel.image}')
                                      : FileImage(profileImagePicker),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  CubitHomeSocial.get(context)
                                      .getProfileImage();
                                },
                                icon: Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  if (CubitHomeSocial.get(context).profileCover != null ||
                      CubitHomeSocial.get(context).profileImage != null)
                    Row(
                      children: [
                        if (CubitHomeSocial.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: TextButton(
                                    onPressed: () {
                                      CubitHomeSocial.get(context)
                                          .uploadingProfileImage(
                                              name: nameControl.text,
                                              bio: bioControl.text,
                                              phone: phoneControl.text);
                                      print('Update Profile Image');
                                    },
                                    child: Text(
                                      'Update Profile',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                if (state is UpdateScreenLoading)
                                  SizedBox(
                                    height: 7,
                                  ),
                                if (state is UpdateScreenLoading)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (CubitHomeSocial.get(context).profileCover != null ||
                            CubitHomeSocial.get(context).profileImage != null)
                          SizedBox(
                            width: 10,
                          ),
                        if (CubitHomeSocial.get(context).profileCover != null)
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: TextButton(
                                    onPressed: () {
                                      CubitHomeSocial.get(context)
                                          .uploadingProfileCover(
                                              name: nameControl.text,
                                              bio: bioControl.text,
                                              phone: phoneControl.text);
                                      print('Update Cover Image');
                                    },
                                    child: Text(
                                      'Update Cover',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                if (state is UpdateScreenLoading)
                                  SizedBox(
                                    height: 7,
                                  ),
                                if (state is UpdateScreenLoading)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  SizedBox(
                    height: 25,
                  ),
                  defaultFormFieldSocial(
                      controlText: nameControl,
                      type: TextInputType.name,
                      prefix: IconBroken.User,
                      text: 'Name',
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormFieldSocial(
                      controlText: bioControl,
                      type: TextInputType.text,
                      prefix: IconBroken.Info_Circle,
                      text: 'Bio',
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Bio must not be empty';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormFieldSocial(
                      controlText: phoneControl,
                      type: TextInputType.phone,
                      prefix: IconBroken.Call,
                      text: 'Phone',
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
