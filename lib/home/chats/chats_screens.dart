import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/Cubitbig/cubit_home.dart';
import 'package:social_app/home/Cubitbig/cubit_home_state.dart';
import 'package:social_app/home/chats_detailes/chat_detail.dart';
import 'package:social_app/models/model_create_users/model_create.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeSocial, CubitHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: CubitHomeSocial.get(context).allUsers.length > 0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => buildItemChats(
                  context, CubitHomeSocial.get(context).allUsers[index]),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
              itemCount: CubitHomeSocial.get(context).allUsers.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildItemChats(context, UserCreateModel model) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatsDetails(
                      userCreateModel: model,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 37.0,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text('${model.name}',
                style: Theme.of(context).textTheme.bodyText1.copyWith()),
          ],
        ),
      ),
    );
