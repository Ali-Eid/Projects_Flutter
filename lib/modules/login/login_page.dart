import 'package:buildcondition/buildcondition.dart';
// import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
// import 'package:softagi/bloc/login_bloc.dart';

import 'package:softagi/layout/home_layout.dart';
import 'package:softagi/modules/login/cubit/login_cubit.dart';
import 'package:softagi/modules/signup/sign_up.dart';
import 'package:softagi/shared/components/components.dart';
import 'package:softagi/shared/components/network/cache.dart';
import 'package:softagi/shared/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  bool isSecure1 = true;
  TextEditingController passwordController = TextEditingController();
  Icon secureIcon = Icon(Icons.visibility, color: Colors.deepOrange);
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is SuccessStateLogIn) {
          if (state.loginmodel?.status == true) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginmodel?.data!.token)
                .then((value) {
              token = CacheHelper.getData(key: 'token');
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (_) => HomeLayout()));
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => HomeLayout()),
                  (route) => false);
            });
            showToast(
                message: state.loginmodel?.message, state: ToastState.success);
          } else {
            showToast(
                message: state.loginmodel?.message, state: ToastState.error);
          }
        }
        // TODO: implement listener
      }, builder: (context, state) {
        if (state is ErrorStateLogIn) {
          return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.do_disturb_rounded,
                  color: Colors.red,
                  size: 30,
                ),
                Text('please check your connection',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ],
            )),
          );
        }
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: FormKey,
                    child: Column(
                      children: [
                        //Lottie.asset('assets/images/animations/login.json',
                        //  height: MediaQuery.of(context).size.height * 0.25),
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                          },
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          text: 'Email Address',
                          icon: const Icon(
                            Icons.email_outlined,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          submit: (value) {
                            FormKey.currentState?.validate();
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.text,
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (isSecure1) {
                                  setState(() {
                                    isSecure1 = !isSecure1;
                                    secureIcon = const Icon(
                                        Icons.visibility_off,
                                        color: Colors.deepOrange);
                                  });
                                } else {
                                  setState(() {
                                    isSecure1 = !isSecure1;
                                    secureIcon = const Icon(Icons.visibility,
                                        color: Colors.deepOrange);
                                  });
                                }
                              },
                              icon: secureIcon),
                          text: 'Password',
                          IsSecure: isSecure1,
                          icon: const Icon(
                            Icons.lock,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 12),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Don't have an account",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => SignUp()));
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 20),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          //borderRadius: BorderRadius.circular(20)),
                          child: BuildCondition(
                            condition: state is! LoadingStateLogIn,
                            builder: (context) => defaultElevatedButton(
                                child: Text('LOGIN'),
                                onPressed: () {
                                  FormKey.currentState!.validate()
                                      ? LoginCubit.get(context).SubmitLogin(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      : 'null';
                                }),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }
          // }

          ),
    );
  }
}
