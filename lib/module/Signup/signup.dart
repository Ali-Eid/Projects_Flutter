import 'package:buildcondition/buildcondition.dart';
import 'package:dardesh/layout/home.dart';
import 'package:dardesh/module/Signup/cubit/signup_cubit.dart';
import 'package:dardesh/shared/cach_helper.dart';
import 'package:dardesh/shared/components/components.dart';
import 'package:dardesh/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var FormKey = GlobalKey<FormState>();
  bool isSecure1 = true;
  Icon secureIcon = Icon(Icons.visibility, color: Colors.purple);
  TextEditingController? emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  TextEditingController? phoneController = TextEditingController();

  TextEditingController? usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SuccessStateCreateUser) {
            CacheHelper.saveData(key: 'token', value: state.uid).then((value) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false);
            });

            // Navigator.of(context)
            //     .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
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
                            'SignUP',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                            },
                            controller: usernameController,
                            type: TextInputType.text,
                            text: 'User Name',
                            icon: const Icon(
                              Icons.person,
                              color: Colors.purple,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
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
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Phone Number';
                              }
                            },
                            controller: phoneController,
                            type: TextInputType.number,
                            text: 'Phone Number',
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.purple,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            //borderRadius: BorderRadius.circular(20)),
                            child: BuildCondition(
                              condition: state is! LoadingStateSignIn,
                              builder: (context) => defaultElevatedButton(
                                  child: Text('Sign UP'),
                                  onPressed: () {
                                    FormKey.currentState!.validate()
                                        ? SignupCubit.get(context).SignUp(
                                            username: usernameController!.text,
                                            email: emailController!.text,
                                            password: passwordController!.text,
                                            phone: phoneController!.text,
                                          )
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
                )),
          );
        },
      ),
    );
  }
}
