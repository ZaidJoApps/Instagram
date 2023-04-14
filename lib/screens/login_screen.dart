import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:specialinstagram/resources/auth_resource.dart';
import 'package:specialinstagram/responsive/mobile_screen_layout.dart';
import 'package:specialinstagram/responsive/responsive_layout.dart';
import 'package:specialinstagram/responsive/web_screen_layout.dart';
import 'package:specialinstagram/screens/signup_screen.dart';
import 'package:specialinstagram/utils/colors.dart';
import 'package:specialinstagram/utils/utils.dart';

import '../widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void login(String email, String password) async {
    setState(() {
      _isLoading = true;
    });
    String signInResponse =
        await AuthResource().signIn(email: email, password: password);

    if (signInResponse == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              )));
    } else {
      showSnakBar(signInResponse, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              //Logo
              Image(
                image: AssetImage('assets/logo.png'),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                textEditingController: _emailController,
                hintText: 'Enter Your Email',
                isPass: false,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextField(
                textEditingController: _passController,
                hintText: 'Enter Your Password',
                isPass: true,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  //Login
                  login(_emailController.text, _passController.text);
                },
                child: Container(
                  child: (_isLoading)
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text('Login'),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Don\'t you have an account? '),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Go To SignUp Pag
                      navigateToSignUp();
                    },
                    child: Container(
                      child: Text(
                        'Signup',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
