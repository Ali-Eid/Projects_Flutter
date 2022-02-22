import 'package:cached_network_image/cached_network_image.dart';
import 'package:dardesh/layout/cubit/home_cubit.dart';
import 'package:dardesh/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  var textController = TextEditingController();
  PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is SuccessUploadPostState) {
        Navigator.of(context).pop();
        HomeCubit.get(context).postImageFile = null;
        // HomeCubit.get(context).getPosts();
      }
    }, builder: (context, state) {
      var now = DateTime.now();
      var postImage = HomeCubit.get(context).postImageFile;
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              // color: Colors.black,
              icon: Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Create Post',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  HomeCubit.get(context).uploadPostImag(
                      name: HomeCubit.get(context).model!.name!,
                      image: HomeCubit.get(context).model!.image!,
                      text: textController.text,
                      date: now.toString().substring(0, 16));
                },
                child: Text('post'),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                if (state is LoadingPostUserState) LinearProgressIndicator(),
                if (state is LoadingPostUserState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          '${HomeCubit.get(context).model!.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${HomeCubit.get(context).model!.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 1.4, fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 16),
                        hintText: 'what\'s in your minds'),
                  ),
                ),
                if (postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                image: Image.file(postImage).image)),
                      ),
                      IconButton(
                          onPressed: () {
                            HomeCubit.get(context).removePhotoPost();
                          },
                          icon: Icon(IconBroken.Close_Square))
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            HomeCubit.get(context).addImageToPost();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('add photos'),
                              Icon(IconBroken.Image)
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child:
                            TextButton(onPressed: () {}, child: Text('# tags')))
                  ],
                )
              ],
            ),
          ));
    });
  }
}
