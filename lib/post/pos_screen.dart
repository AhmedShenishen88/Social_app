import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component/compoent_social.dart';

import 'package:social_app/home/Cubitbig/cubit_home.dart';
import 'package:social_app/home/Cubitbig/cubit_home_state.dart';
import 'package:social_app/styles/icons_broken.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeSocial, CubitHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var textControl = TextEditingController();
          var now = DateTime.now();
          return Scaffold(
            appBar: defaultAppBar(
                title: 'Create Post',
                icon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(IconBroken.Arrow___Left_2)),
                actionButton: [
                  TextButton(
                      onPressed: () {
                        if (CubitHomeSocial.get(context).postImage == null) {
                          CubitHomeSocial.get(context).createPost(
                              text: textControl.text, dateTime: now.toString());
                        } else {
                          CubitHomeSocial.get(context).uploadingPostImage(
                              text: textControl.text, timeDate: now.toString());
                        }
                      },
                      child: Text(
                        'Post',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.deepOrange),
                      ))
                ]),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is CreatePostLoading) LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 38.0,
                        backgroundImage: NetworkImage(
                            'https://image.freepik.com/free-photo/confused-attractive-woman-dress-frowning-pointing-fingers-up-looking-puzzled-cant-understand_1258-64264.jpg'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ahmed Shenishen',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 16),
                            ),
                            // Text(
                            //   'Public',
                            //   style: Theme.of(context).textTheme.caption,
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textControl,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What is on your mind.....',
                      ),
                    ),
                  ),
                  if (CubitHomeSocial.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: FileImage(
                                    CubitHomeSocial.get(context).postImage),
                                fit: BoxFit.cover,
                              )),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                CubitHomeSocial.get(context).removePostImage();
                              },
                              icon: Icon(
                                IconBroken.Delete,
                                color: Colors.deepOrange,
                              )),
                        )
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                CubitHomeSocial.get(context).getPostImage();
                              },
                              child: Row(
                                children: [
                                  Icon(IconBroken.Image),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Add Photo')
                                ],
                              ))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {}, child: Text('# tag'))),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
