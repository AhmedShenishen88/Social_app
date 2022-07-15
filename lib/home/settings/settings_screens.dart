import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/Cubitbig/cubit_home.dart';
import 'package:social_app/home/Cubitbig/cubit_home_state.dart';
import 'package:social_app/home/updata_screen/screnn_updata.dart';
import 'package:social_app/models/model_create_users/model_create.dart';
import 'package:social_app/styles/icons_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeSocial, CubitHomeState>(
      listener: (context, stata) {},
      builder: (context, state) {
        var userCreateModel = CubitHomeSocial.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 210,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${userCreateModel.cover}'),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    CircleAvatar(
                      radius: 55.0,
                      backgroundColor: Colors.blue,
                      child: CircleAvatar(
                        radius: 53.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 51.0,
                          backgroundImage:
                              NetworkImage('${userCreateModel.image}'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '${userCreateModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                userCreateModel.bio,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text('100'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Posts',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text('256'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Photos',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text('10K'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Followers',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text('64'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Followings',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Add Photos'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        print('you pressed');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateScreen()));
                      },
                      child: Icon(IconBroken.Edit))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
