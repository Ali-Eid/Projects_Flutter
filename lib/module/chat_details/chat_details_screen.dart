import 'package:buildcondition/buildcondition.dart';
import 'package:dardesh/layout/cubit/home_cubit.dart';
import 'package:dardesh/model/message_model.dart';
import 'package:dardesh/model/user_model.dart';
import 'package:dardesh/shared/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? model;
  var textController = TextEditingController();
  var scrolController = new ScrollController();
  ChatDetailsScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context).getMessage(recieveID: model!.uid!);
      return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(model!.image!),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  model!.name!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          body: BuildCondition(
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
              condition: HomeCubit.get(context).messages.length > 0,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            reverse: true,
                            shrinkWrap: true,
                            controller: scrolController,
                            itemBuilder: (context, index) {
                              var message =
                                  HomeCubit.get(context).messages[index];

                              if (HomeCubit.get(context).model!.uid ==
                                  message.sendID) {
                                return buildMyMessage(message);
                              } else {
                                return buildMessage(message);
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 5,
                                ),
                            itemCount: HomeCubit.get(context).messages.length),
                      ),
                      // Spacer(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300],
                              ),
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write your messeage here ....',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple,
                                // borderRadius: BorderRadius.circular(4),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).sendMessage(
                                        recieveID: model!.uid!,
                                        dateTime: DateTime.now().toString(),
                                        text: textController.text);
                                    textController.text = '';
                                    // scrolController.jumpTo(scrolController
                                    //     .position.maxScrollExtent);
                                  },
                                  icon: Icon(
                                    IconBroken.Send,
                                    color: Colors.white,
                                  )))
                        ],
                      )
                    ],
                  ),
                );
              }),
        ),
      );
    });
  }

  Widget buildMessage(MessageModel modelMSG) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                topEnd: Radius.circular(20),
                bottomEnd: Radius.circular(20),
              )),
          child: Text('${modelMSG.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel modelMSG) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.2),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                topEnd: Radius.circular(20),
                bottomStart: Radius.circular(20),
              )),
          child: Text('${modelMSG.text}'),
        ),
      );
}
