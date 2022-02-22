import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dardesh/layout/cubit/home_cubit.dart';
import 'package:dardesh/model/user_model.dart';
import 'package:dardesh/module/chat_details/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          condition: HomeCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildChatItem(context, HomeCubit.get(context).users[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: HomeCubit.get(context).users.length),
        );
      },
    );
  }

  Widget buildChatItem(context, UserModel model) => InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ChatDetailsScreen(
                    model: model,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider('${model.image}'),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                '${model.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(height: 1.4, fontSize: 13),
              ),
            ],
          ),
        ),
      );
}
