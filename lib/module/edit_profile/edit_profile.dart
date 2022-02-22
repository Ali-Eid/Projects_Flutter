import 'package:cached_network_image/cached_network_image.dart';
import 'package:dardesh/layout/cubit/home_cubit.dart';
import 'package:dardesh/shared/components/components.dart';
import 'package:dardesh/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  var userController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var usermodel = HomeCubit.get(context).model;
        userController.text = usermodel!.name!;
        bioController.text = usermodel.bio!;
        phoneController.text = usermodel.phone!;
        var profileImage = HomeCubit.get(context).profileImage;
        var coverImage = HomeCubit.get(context).coverImage;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              // color: Colors.black,
              icon: Icon(
                IconBroken.Arrow___Left_2,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Edit Profile',
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    HomeCubit.get(context).updateUser(
                        username: userController.text,
                        bio: bioController.text,
                        phone: phoneController.text);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Update'),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is LoadUploadImageState ||
                    state is LoadUploadprofileImageState)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LinearProgressIndicator(),
                  ),
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 12,
                                margin: EdgeInsets.zero,
                                child: coverImage == null
                                    ? CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 160,
                                        imageUrl: '${usermodel.cover}',
                                        placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.purple,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error,
                                                color: Colors.purple))
                                    : Image.file(coverImage)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).changeCoverImage();
                                    },
                                    icon: Icon(IconBroken.Camera)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundImage: profileImage == null
                                  ? CachedNetworkImageProvider(
                                      '${usermodel.image}')
                                  : Image.file(profileImage).image,
                            ),
                            CircleAvatar(
                              radius: 15,
                              child: IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).changeProfileImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 15,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (HomeCubit.get(context).profileImage != null ||
                    HomeCubit.get(context).coverImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        if (HomeCubit.get(context).profileImage != null)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                HomeCubit.get(context).uploadProfileImage(
                                    username: userController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text);
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: Colors.purple)),
                              child: Text('upload profile'),
                            ),
                          ),
                        SizedBox(
                          width: 5,
                        ),
                        if (HomeCubit.get(context).coverImage != null)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                HomeCubit.get(context).uploadCoverImage(
                                    username: userController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text);
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 1, color: Colors.purple)),
                              child: Text('upload cover'),
                            ),
                          ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: defaultFormField(
                      controller: userController,
                      type: TextInputType.name,
                      text: 'Name',
                      icon: Icon(IconBroken.User)),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      text: 'Bio',
                      icon: Icon(IconBroken.Info_Circle)),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      text: 'phone',
                      icon: Icon(IconBroken.Call)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
