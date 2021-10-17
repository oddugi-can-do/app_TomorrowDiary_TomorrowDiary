import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/bindings/bindings.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

import 'views.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cfPasswordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  UserController uc = Get.put(UserController());

  String? userInfo = "";

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.initState();
  }

  _asyncMethod() async {
    userInfo = await UserController.storage.read(key: "login");

    if (userInfo != null) {
      final user = userInfo!.split(" ");
      uc.login(user[1], user[3],context);
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   widget.onCanceled();
  // }
  final _duration = Duration(milliseconds: 500);
  bool isRegister = true;
  @override
  Widget build(BuildContext context) {
    if (screenSize == null) screenSize = MediaQuery.of(context).size;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/tomorrow2.gif'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                reverse: true,
                padding: EdgeInsets.all(16),
                children: [
                  SizedBox(height: 16),

                  //Title
                  Text(
                    "Tomorrow Diary",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),

                  //Register and Login
                  ButtonBar(children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isRegister = false;
                            _usernameController.clear();
                            _cfPasswordController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                          });
                        },
                        child: Text("Login",
                            style: TextStyle(
                                color:
                                    isRegister ? Colors.white24 : Colors.white,
                                fontWeight: isRegister
                                    ? FontWeight.w200
                                    : FontWeight.bold))),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isRegister = true;
                          });
                        },
                        child: Text("Register",
                            style: TextStyle(
                                color:
                                    isRegister ? Colors.white : Colors.white24,
                                fontWeight: isRegister
                                    ? FontWeight.bold
                                    : FontWeight.w200))),
                  ]),
                  SizedBox(height: 40),
                  AnimatedContainer(
                    duration: _duration,
                    curve: Curves.fastOutSlowIn,
                    height: isRegister ? 60 : 0,
                    child: SizedBox(
                      height: 60,
                      child: AuthFormField(
                        hint: 'Username',
                        controller: _usernameController,
                        isRegister: isRegister,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                      duration: _duration, height: isRegister ? 16 : 0),
                  // Email
                  AuthFormField(hint: 'Email', controller: _emailController),
                  SizedBox(height: 16),

                  // Password
                  AuthFormField(
                      hint: 'Password', controller: _passwordController),
                  SizedBox(height: 16),

                  // Confirm password
                  AnimatedContainer(
                    duration: _duration,
                    curve: Curves.fastOutSlowIn,
                    height: isRegister ? 60 : 0,
                    child: SizedBox(
                      height: 60,
                      child: AuthFormField(
                        hint: 'Confirm Password',
                        controller: _cfPasswordController,
                        isRegister: isRegister,
                      ),
                    ),
                  ),

                  // 공백 애니메이션
                  AnimatedContainer(
                      duration: _duration, height: isRegister ? 12 : 0),

                  // Submit Button
                  Container(
                    height: 60,
                    child: _submitButton(),
                  ),
                  SizedBox(height: 16),
                  Divider(
                    height: 1,
                    thickness: 3,
                    color: Colors.white30,
                  ),

                  // Social Login
                  SizedBox(height: 30),
                  _socialLoginButton('google', () async {
                    await uc.googleLogin(context);
                  }),
                  SizedBox(height: 5),
                  _socialLoginButton('facebook', () async {
                    await uc.facebookLogin(context);
                    // Get.to(HomeScreen());
                  })
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _submitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          isRegister
              ? (_cfPasswordController.text == _passwordController.text)
                  ? uc.join(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      _usernameController.text.trim(),
                      context
                      )
                  : snackBar(msg: "패스워드가 맞지 않습니다.")
              : uc.login(_emailController.text.trim(),
                  _passwordController.text.trim(),
                  context
                  );
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(isRegister ? "Register" : "Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Container _socialLoginButton(String? social, Function fn) {
    return Container(
      height: 50,
      child: SignInButton(
        social == 'google' ? Buttons.Google : Buttons.Facebook,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: fn,
      ),
    );
  }

 
}
