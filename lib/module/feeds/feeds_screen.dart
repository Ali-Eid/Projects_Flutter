import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dardesh/layout/cubit/home_cubit.dart';
import 'package:dardesh/model/post_model.dart';
import 'package:dardesh/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BuildCondition(
            condition: HomeCubit.get(context).posts.length > 0,
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 12,
                    shadowColor: Colors.purple,
                    margin: EdgeInsets.all(8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          width: double.infinity,
                          image: AssetImage('assets/images/home.jpg'),
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate With Your Friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: HomeCubit.get(context).posts.length,
                      itemBuilder: (contex, index) => buildPostItem(
                          contex, HomeCubit.get(context).posts[index], index)),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildPostItem(context, PostModel postmodel, int index) => Card(
      color: Theme.of(context).cardColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 12,
      shadowColor: Colors.purple,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${postmodel.image}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${postmodel.name}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(height: 1.4, fontSize: 13),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.purple,
                            size: 15,
                          )
                        ],
                      ),
                      Text(
                        '${postmodel.date}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconBroken.More_Circle,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${postmodel.text}',
              style:
                  Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 13),
            ),
            // Container(
            //   padding: EdgeInsets.only(
            //     bottom: 10,
            //     top: 5,
            //   ),
            //   width: double.infinity,
            //   child: Wrap(
            //     alignment: WrapAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(end: 6),
            //         child: Container(
            //           height: 25,
            //           child: MaterialButton(
            //               minWidth: 1,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#software',
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .caption!
            //                     .copyWith(color: Colors.blue),
            //               )),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsetsDirectional.only(end: 6),
            //         child: Container(
            //           height: 25,
            //           child: MaterialButton(
            //               minWidth: 1,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#flutter',
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .caption!
            //                     .copyWith(color: Colors.blue),
            //               )),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            if (postmodel.postimage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 12,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: ('${postmodel.postimage}}'),
                    fit: BoxFit.cover,
                    // height: 140,
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 15,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${HomeCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat, size: 15, color: Colors.amber),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0 comments',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${HomeCubit.get(context).model!.image}'),
                          radius: 10,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'write comment ...',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    HomeCubit.get(context)
                        .likePost(HomeCubit.get(context).postID[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 15,
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
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(IconBroken.Upload, size: 15, color: Colors.amber),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'share',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ));
}
