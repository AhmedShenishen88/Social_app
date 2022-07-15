import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/Cubitbig/cubit_home.dart';
import 'package:social_app/home/Cubitbig/cubit_home_state.dart';
import 'package:social_app/models/model_post/post_model.dart';
import 'package:social_app/styles/icons_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeSocial, CubitHomeState>(
      listener: (context, index) {},
      builder: (context, index) {
        return ConditionalBuilder(
          condition: CubitHomeSocial.get(context).postItem.length > 0 &&
              CubitHomeSocial.get(context).model != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  elevation: 10.0,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://image.freepik.com/free-photo/winter-holidays-people-concept-indecisive-redhead-girl-sweater-pointing-fingers-down-thinking-having-doubts-standing-blue-background_1258-55278.jpg'),
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ]),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => cardBuilderComplete(
                        context,
                        CubitHomeSocial.get(context).postItem[index],
                        index),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                    itemCount: CubitHomeSocial.get(context).postItem.length),
                SizedBox(
                  height: 8.0,
                )
              ],
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget cardBuilderComplete(context, UserCreatePost model, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.check_circle,
                            size: 14.0,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      Text(
                        model.dateTime,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(height: 1.4),
                      )
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
              ],
            ),
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '${model.text}',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.black, height: 1.4),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 8.0),
            //           child: Container(
            //             child: MaterialButton(
            //               onPressed: () {},
            //               child: Text(
            //                 '#software',
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .caption
            //                     .copyWith(color: Colors.blue),
            //               ),
            //               padding: EdgeInsets.zero,
            //               height: 0.25,
            //               minWidth: 1.0,
            //             ),
            //             height: 25.0,
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 8.0),
            //           child: Container(
            //             child: MaterialButton(
            //               onPressed: () {},
            //               child: Text(
            //                 '#flutter',
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .caption
            //                     .copyWith(color: Colors.blue),
            //               ),
            //               padding: EdgeInsets.zero,
            //               height: 0.25,
            //               minWidth: 1.0,
            //             ),
            //             height: 25.0,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 14,
                              color: Colors.red,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              '${CubitHomeSocial.get(context).like[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //  Text(
                            //    '${CubitHomeSocial.get(context).comment[index]}',
                            //  style: Theme.of(context).textTheme.caption,
                            //  ),
                            // SizedBox(
                            //   width: 2.0,
                            // ),
                            Icon(
                              IconBroken.Chat,
                              size: 14,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              'comment',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 1.0,
                color: Colors.grey,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        CubitHomeSocial.get(context).getComment(
                            CubitHomeSocial.get(context).postId[index]);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(
                                '${CubitHomeSocial.get(context).model.image}'),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'write a comment...',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      CubitHomeSocial.get(context).createLike(
                          CubitHomeSocial.get(context).postId[index]);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 14,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
