import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/utils/tdcolor.dart';
import 'package:tomorrow_diary/utils/tdsize.dart';
import 'package:tomorrow_diary/views/views.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            SizedBox(
              height: TdSize.xl,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Tomorrow Diary",
                style: TextStyle(fontSize: TdSize.l),
              ),
            ),
            SizedBox(height: TdSize.m),
            CustomTextFormField(hint: "Email", controller: _emailController),
            CustomTextFormField(
                hint: "Password", controller: _passwordController),
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
                      Provider.of<FirebaseAuthState>(context, listen: false)
                          .login(
                        context,
                        // email: _emailController.text,
                        // password: _passwordController.text
                        email: "user2@gmail.com",
                        password: "601cert)*",
                      );
                    }
                  },
                  child: Text("Login", style: TextStyle(fontSize: TdSize.m)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
