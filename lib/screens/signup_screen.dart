import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:specialinstagram/resources/auth_resource.dart';
import 'package:specialinstagram/responsive/mobile_screen_layout.dart';
import 'package:specialinstagram/responsive/responsive_layout.dart';
import 'package:specialinstagram/responsive/web_screen_layout.dart';
import 'package:specialinstagram/screens/login_screen.dart';
import 'package:specialinstagram/utils/colors.dart';
import 'package:specialinstagram/utils/utils.dart';

import '../widgets/textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  Uint8List? image;
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _userNameController.dispose();
    _bioController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String signupResponse = await AuthResource().signUpUser(
        email: _emailController.text,
        password: _passController.text,
        bio: _bioController.text,
        userName: _userNameController.text,
        file: image);

     print("SignUp Responsse: $signupResponse");
    if (signupResponse == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              )));
    }

    setState(() {
      _isLoading = false;
    });
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              Stack(
                children: [
                  (image != null)
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://c4.wallpaperflare.com/wallpaper/616/450/559/anime-hunter-x-hunter-killua-zoldyck-hd-wallpaper-preview.jpg'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      color: blueColor,
                      onPressed: () {
                        //open Gellery
                        selectImage();
                      },
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                textEditingController: _userNameController,
                hintText: 'Enter Your User Name',
                isPass: false,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: _emailController,
                hintText: 'Enter Your Email',
                isPass: false,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: _passController,
                hintText: 'Enter Your Password',
                isPass: true,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: _bioController,
                hintText: 'Enter Your Bio',
                isPass: false,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  //SignUp
                  signUpUser();
                },
                child: Container(
                  child: (_isLoading)
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text('Signup'),
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
                    child: Text('Do you have an account? '),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Go To SignUp Pag
                      navigateToLogin();
                    },
                    child: Container(
                      child: Text(
                        'Login',
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
