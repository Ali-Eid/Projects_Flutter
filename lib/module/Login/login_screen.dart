import 'package:buildcondition/buildcondition.dart';
import 'package:dardesh/layout/home.dart';
import 'package:dardesh/module/Login/cubit/login_cubit.dart';
import 'package:dardesh/module/Signup/signup.dart';
import 'package:dardesh/shared/cach_helper.dart';
import 'package:dardesh/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var FormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isSecure1 = true;
  Icon secureIcon = Icon(
    Icons.visibility,
    color: Colors.purple,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // if (state is SuccessStateLogIn) {}
          if (state is SuccessStateLogIn) {
            CacheHelper.saveData(key: 'token', value: state.uid).then((value) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomePage()));
            });
          }
          // TODO: implement listener
        },
        builder: (context, state) {
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
                              color: Colors.purple,
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
                                          color: Colors.purple);
                                    });
                                  } else {
                                    setState(() {
                                      isSecure1 = !isSecure1;
                                      secureIcon = const Icon(Icons.visibility,
                                          color: Colors.purple);
                                    });
                                  }
                                },
                                icon: secureIcon),
                            text: 'Password',
                            IsSecure: isSecure1,
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.purple,
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
                                        color: Colors.purple, fontSize: 12),
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => SignUp()));
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: Colors.purple, fontSize: 20),
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
                                    // CachHelper.saveData(key: 'uid', value: )
                                    FormKey.currentState!.validate()
                                        ? LoginCubit.get(context).SubmitLogin(
                                            email: emailController.text,
                                            password: passwordController.text)
                                        : 'null';
                                  }),
                              fallback: (context) => Center(
                                  child: Lottie.asset(
                                'assets/loader.json',
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
