import 'package:flutter/material.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

//SingleTickerProviderStateMixin : FadeTransition에서 애니메이션 컨트롤러를 주기위한 것
class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {

  // SignUp , SignIn pages list
  List<Widget> forms = [
    SignUpForm(),
    SignInForm(),
  ];

  SelectedForm selectedForm = SelectedForm.signup; // 0 : SignUpForm()

 



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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
