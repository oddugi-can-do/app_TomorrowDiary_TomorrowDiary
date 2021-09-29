import 'package:flutter/material.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/tdsize.dart';
import 'package:tomorrow_diary/views/views.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';
import 'package:provider/provider.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form에 대한 상태를 알기 위해 필요한 키이다.
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: TdSize.xl,),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Join Tomorrow Diary",
                style: TextStyle(fontSize: TdSize.l),
              ),
            ),
            SizedBox(height:TdSize.m),
            CustomTextFormField(
                hint: "Username",
                controller: _usernameController,
                validation: (text) {
                  if (text!.isEmpty) {
                    return "이름을 입력해주세요";
                  }
                  return null;
                }),
            CustomTextFormField(
              hint: "Email",
              controller: _emailController,
              validation: (text) {
                if (text!.isEmpty) {
                  return "이메일을 입력해주세요";
                }
                return null;
              },
            ),
            CustomTextFormField(
              hint: "Password",
              controller: _passwordController,
              validation: (text) {
                if (text!.isEmpty) {
                  return "패스워드를 입력해주세요";
                }
                return null;
              },
            ),
            CustomTextFormField(
              hint: "Confirm Password",
              controller: _confirmPasswordController,
              validation: (text) {
                if (text != _passwordController.text) {
                  return "패스워드가 맞지 않습니다.";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(TdSize.s),
              child: Container(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: TdColor.blue, // background
                    onPrimary: TdColor.white, // foreground
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<FirebaseAuthState>(context, listen:false).registerUser(email: _emailController.text, password: _passwordController.text);
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => HomeScreen(),
                      //   ),
                      // );
                    }
                  },
                  child: Text("Join", style: TextStyle(fontSize: TdSize.m)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
