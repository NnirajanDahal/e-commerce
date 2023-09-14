import 'package:ecommerce_app/home/home_page.dart';
import 'package:ecommerce_app/login/bloc/login_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  bool isValidEmail(String input) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(input);
  }

  Future<void> createAlertDialog(BuildContext context,
      {String? message}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error!!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(message!),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Okay',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> loadingAlertDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Loading",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            content: Container(
                height: 50, width: 10, child: CircularProgressIndicator()),
          );
        });
  }

  @override
  void initState() {
    usernameController.text = "";
    passwordController.text = "";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFetchingLoadingState) {
            loadingAlertDialog(context);
          } else if (state is LoginFetchingErrorState) {
            Navigator.of(context).pop();
            createAlertDialog(context, message: state.error);
          } else if (state is LoginSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) => Home()),
                (Route<dynamic> route) => false);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Logged in"),
              backgroundColor: Colors.green,
            ));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      height: 200,
                      child: Image.asset("assets/logo-removebg-preview.png")),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "E-Commerce",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 50.0),
                  // Text(
                  //   "Login",
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 30.0,
                  //       fontFamily: 'workSans'),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  Container(
                    width: 350.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .4),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ]),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Cannot be empty";
                                }
                                return null;
                              },
                              controller: usernameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Cannot be empty";
                                }
                                return null;
                              },
                              controller: passwordController,
                              obscureText: !passwordVisible,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                    // onLongPressUp: () {
                                    //   setState(() {
                                    //     passwordVisible = false;
                                    //   });
                                    // },
                                    child: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    width: 140.0,
                    height: 50.0,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // _formKey.currentState!.save();
                            // _loginUser(
                            //     emailController.text, passwordController.text);
                            context.read<LoginBloc>().add(LoginRequestEvent(
                                username: usernameController.text.trim(),
                                password: passwordController.text.trim()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Color.fromARGB(255, 63, 66, 73)),
                        child: Text("Login")),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // Text(
                  //   'Forgot Password?',
                  //   style: TextStyle(
                  //       color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(
                  //   height: 30.0,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text("New to Social App? "),
                  //     GestureDetector(
                  //       onTap: () {
                  //         // Navigator.push(
                  //         //     context,
                  //         //     MaterialPageRoute(
                  //         //         builder: (context) => ));
                  //       },
                  //       child: Text(
                  //         'Sign up',
                  //         style: TextStyle(
                  //             color: Colors.blueAccent,
                  //             fontWeight: FontWeight.bold,
                  //             decoration: TextDecoration.underline),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
