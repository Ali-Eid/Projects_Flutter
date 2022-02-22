import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dardesh/layout/cubit/home_cubit.dart';
import 'package:dardesh/module/edit_profile/edit_profile.dart';
import 'package:dardesh/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var usermodel = HomeCubit.get(context).model;
        return BuildCondition(
          fallback: (context) => Center(child: CircularProgressIndicator()),
          condition: HomeCubit.get(context).model != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 12,
                            margin: EdgeInsets.zero,
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 160,
                                imageUrl: '${usermodel!.cover}',
                                placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.purple,
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error,
                                        color: Colors.purple))),
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                            radius: 55,
                            backgroundImage: CachedNetworkImageProvider(
                                '${usermodel.image}')),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${usermodel.name!.toUpperCase()}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  '${usermodel.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '18',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '102K',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '65',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1, color: Colors.purple)),
                        child: Text('Add Photo'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctxt) => EditProfileScreen()));
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1, color: Colors.purple)),
                      child: Icon(
                        IconBroken.Edit,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
