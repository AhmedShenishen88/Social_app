import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/Cubitbig/cubit_home.dart';
import 'package:social_app/home/Cubitbig/cubit_home_state.dart';
import 'package:social_app/models/model_create_users/model_create.dart';
import 'package:social_app/models/modelcahts/modelchats.dart';
import 'package:social_app/styles/icons_broken.dart';

class ChatsDetails extends StatelessWidget {
  UserCreateModel userCreateModel;
  ChatsDetails({this.userCreateModel});
  var textControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        CubitHomeSocial.get(context)
            .getMessages(receiveID: userCreateModel.uId);
        return BlocConsumer<CubitHomeSocial, CubitHomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 23.0,
                      backgroundImage: NetworkImage('${userCreateModel.image}'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${userCreateModel.name}',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: CubitHomeSocial.get(context).messages.length >= 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  CubitHomeSocial.get(context).messages[index];
                              if (CubitHomeSocial.get(context).model.uId ==
                                  message.sendId) {
                                return sendMine(message, context);
                              } else {
                                return sendToHim(message, context);
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 6,
                                ),
                            itemCount:
                                CubitHomeSocial.get(context).messages.length),
                      ),
                      if (CubitHomeSocial.get(context).imageSend != null &&
                          userCreateModel.uId ==
                              CubitHomeSocial.get(context).model.uId)
                        Column(
                          children: [
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              height: 140,
                              width: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: FileImage(
                                      CubitHomeSocial.get(context).imageSend,
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      if (CubitHomeSocial.get(context).imageSend != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: FileImage(
                                        CubitHomeSocial.get(context).imageSend),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    CubitHomeSocial.get(context)
                                        .removeImageSender();
                                  },
                                  icon: Icon(
                                    IconBroken.Delete,
                                    color: Colors.deepOrange,
                                  )),
                            )
                          ],
                        ),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.grey[200], width: 1),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.black),
                                    controller: textControl,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here.....',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue.withOpacity(0.7),
                              radius: 27,
                              child: TextButton(
                                onPressed: () {
                                  CubitHomeSocial.get(context).getImageSend();
                                  print('send');
                                },
                                child: Icon(
                                  IconBroken.Image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue.withOpacity(0.7),
                              radius: 27,
                              child: TextButton(
                                onPressed: () {
                                  if (CubitHomeSocial.get(context).imageSend ==
                                      null) {
                                    CubitHomeSocial.get(context)
                                        .sendChatDetails(
                                            text: textControl.text,
                                            dateTime: DateTime.now().toString(),
                                            receiveID: userCreateModel.uId);
                                    print('send Without image');
                                  } else {
                                    CubitHomeSocial.get(context)
                                        .uploadingImageSend(
                                            text: textControl.text,
                                            dateTime: DateTime.now().toString(),
                                            receiveID: userCreateModel.uId);
                                    print('send with image');
                                  }
                                },
                                child: Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget sendToHim(ChatDetailsModel model, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(15),
                    topEnd: Radius.circular(15),
                    topStart: Radius.circular(15),
                  )),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                model.text,
              ),
            ),
          ),
          if (model.image != '')
            SizedBox(
              height: 6,
            ),
          if (model.image != '')
            Container(
              height: 150,
              width: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.cover,
                  )),
            ),
          if (model.image != '')
            SizedBox(
              height: 14,
            ),
          SizedBox(
            height: 4,
          )
        ],
      );
  Widget sendMine(ChatDetailsModel model, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(15),
                    topEnd: Radius.circular(15),
                    topStart: Radius.circular(15),
                  )),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                model.text,
              ),
            ),
          ),
          if (model.image != '')
            SizedBox(
              height: 6,
            ),
          if (model.image != '')
            Container(
              height: 150,
              width: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.cover,
                  )),
            ),
          if (model.image != '')
            SizedBox(
              height: 6,
            ),
          SizedBox(
            height: 4,
          )
        ],
      );
}
