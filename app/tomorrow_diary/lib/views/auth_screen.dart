import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/views/home_screen.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
  UserController uc = Get.put(UserController());

  final _duration = Duration(milliseconds: 500);
  bool isRegister = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/book.gif'), fit: BoxFit.cover),
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
                  Text(
                    "Tmorrow Diary",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  ButtonBar(children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isRegister = false;
                            _cfPasswordController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                          });
                        },
                        child: Text("Login",
                            style: TextStyle(
                                color:
                                    isRegister ? Colors.white24 : Colors.white,
                                fontWeight: isRegister ? FontWeight.w200 : FontWeight.bold))),
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
                  AuthFormField(hint: 'Email', controller: _emailController),
                  SizedBox(height: 16),
                  AuthFormField(
                      hint: 'Password', controller: _passwordController),
                  SizedBox(height: 16),
                  AnimatedContainer(
                    duration: _duration,
                    curve: Curves.fastOutSlowIn,
                    height: isRegister ? 60 : 0,
                    child: SizedBox(
                      height: 60,
                      child: AuthFormField(
                        hint: 'Confirm Password',
                        controller: _cfPasswordController,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                      duration: _duration, height: isRegister ? 12 : 0),
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
                  SizedBox(height: 30),
                  _socialLoginButton('google', () async {
                    print("google");
                    Get.to(HomeScreen());
                  }),
                  SizedBox(height: 5),
                  _socialLoginButton('facebook', () {
                    print("facebook");
                    Get.to(HomeScreen());
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
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          isRegister
              ? _cfPasswordController.text == _passwordController.text
                  ? uc.join(_emailController.text.trim(),
                      _passwordController.text.trim())
                  : Get.snackbar("Error", "패스워드가 맞지 않습니다.",
                      snackPosition: SnackPosition.BOTTOM)
              : uc.login(_emailController.text.trim(),
                  _passwordController.text.trim());
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

// import 'package:flutter/material.dart';
// import 'package:tomorrow_diary/utils/tdcolor.dart';
// import 'package:tomorrow_diary/widgets/widgets.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({Key? key}) : super(key: key);

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// //SingleTickerProviderStateMixin : FadeTransition에서 애니메이션 컨트롤러를 주기위한 것
// class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {

//   // SignUp , SignIn pages list
//   List<Widget> forms = [
//     SignUpForm(),
//     SignInForm(),
//   ];

//   SelectedForm selectedForm = SelectedForm.signup; // 0 : SignUpForm()

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             //child가 변경될 때 마다 애니메이션을 줄 수 있음
//             FadeAnimation(
//               selectedIndex: selectedForm,
//               forms: forms,
//               ),
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                       if(selectedForm == SelectedForm.signup) {
//                       selectedForm = SelectedForm.signin; // Change SignInForm
//                     }else{
//                       selectedForm = SelectedForm.signup; // Change SignUpForm
//                     }
//                     });
//                   },
//                   child: RichText(
//                     text: TextSpan(
//                       text: selectedForm == SelectedForm.signup ? "이미 가입하셨습니까? ":"가입하시겠습니까? ",
//                       style: TextStyle(color: Colors.grey),
//                       children: [
//                         TextSpan(
//                         text: selectedForm == SelectedForm.signup ? "로그인 하러 가기" : "회원가입 하러 가기",
//                         style: TextStyle(color: Colors.blue),
//                         ),

//                       ]
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// enum SelectedForm {
//   signup, signin
// }
