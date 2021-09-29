import 'package:flutter/material.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            //child가 변경될 때 마다 애니메이션을 줄 수 있음
            FadeAnimation(
              selectedIndex: selectedForm,
              forms: forms,
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if(selectedForm == SelectedForm.signup) {
                      selectedForm = SelectedForm.signin; // Change SignInForm
                    }else{
                      selectedForm = SelectedForm.signup; // Change SignUpForm
                    }
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                      text: selectedForm == SelectedForm.signup ? "이미 가입하셨습니까? ":"가입하시겠습니까? ",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                        text: selectedForm == SelectedForm.signup ? "로그인 하러 가기" : "회원가입 하러 가기", 
                        style: TextStyle(color: Colors.blue),
                        ),
                        
                      ]
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

enum SelectedForm {
  signup, signin
}