import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_admin_dashboard/screens/Dashboard/dash_board_screen.dart';
import 'package:responsive_admin_dashboard/screens/posts/post_main.dart';

import '../../resources/auth_methods.dart';
import '../../widgets/text_field_input.dart';
import '../upload/upload_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {});
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      setState(() {
        Get.snackbar(
          'Login Successful',
          'Click on Home Tab to Add a Post',
          isDismissible: true,
          maxWidth: MediaQuery.of(context).size.width * 0.5,
          duration: const Duration(
            seconds: 2,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
        );
      });
      Get.offAll(const PostUploadScreen());
    } else if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() {});
      Get.snackbar(
        'Login Failed',
        'All fields are Required.',
        isDismissible: true,
        maxWidth: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: Colors.white,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (_passwordController.text.length < 6) {
      setState(() {});
      Get.snackbar(
        'Login Failed',
        'Password Length is too Short.',
        isDismissible: true,
        maxWidth: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: Colors.white,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (_emailController.text.isEmail != true) {
      setState(() {});
      Get.snackbar(
        'Login Failed',
        'Please Enter a Valid E-Mail.',
        isDismissible: true,
        maxWidth: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: Colors.white,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      setState(() {});
      Get.snackbar(
        'Login Failed',
        'Wrong Credentials',
        isDismissible: true,
        maxWidth: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: Colors.white,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Card(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              width: screenW < 1024 ? screenW * 0.95 : screenW * 0.4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 44,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Welcome to ',
                          style: GoogleFonts.oswald(
                            fontSize: 34,
                          ),
                        ),
                        TextSpan(
                            text: 'Mission K3',
                            style: GoogleFonts.oswald(
                              color: Color(0xff21a179),
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                            )),
                        TextSpan(
                          text: '!',
                          style: GoogleFonts.oswald(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   'Logo Area',
                  //   style: GoogleFonts.oswald(
                  //     textStyle: const TextStyle(
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black),
                  //   ),
                  // ),

                  const SizedBox(
                    height: 64,
                  ),
                  // EMAIL FIELD
                  TextFieldInput(
                    hintText: 'E-Mail',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldInput(
                    hintText: 'Password',
                    isPass: true,
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  // LOGIN Button
                  InkWell(
                    onTap: loginUser,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                      decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
