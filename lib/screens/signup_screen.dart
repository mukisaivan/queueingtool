import 'dart:typed_data';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queueingtool/common/custom_button.dart';
import 'package:queueingtool/common/custom_textfield.dart';
import 'package:queueingtool/common/space.dart';
import 'package:queueingtool/constants/global_variables.dart';
import 'package:queueingtool/constants/utils.dart';
import 'package:queueingtool/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:queueingtool/methods/auth_methods.dart';
import 'package:queueingtool/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signup-screen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();
  Uint8List? _image;

  final _formKey = GlobalKey<FormState>();

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: SpinKitWave(
                  color: Color.fromARGB(255, 191, 0, 255),
                ),
              );
            });
      }

      if (_image != null) {
        await AuthMethods().signUpUser(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          file: _image!,
        );

        if (context.mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
      } else {
        Fluttertoast.showToast(
          msg: "Please provide your image",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red[800],
        );
        Navigator.pop(context);
      }
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    secondPasswordController.dispose();
  }

  void registerShowToast() =>
      Fluttertoast.showToast(msg: "Account created successfully");

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder(
                future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: SpinKitWave(
                          color: Color.fromARGB(255, 191, 0, 255),
                        ),
                      );

                    case ConnectionState.done:
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // const Logo(),
                            Image(
                              image: const AssetImage(
                                "assets/logo/goldenq.png",
                              ),
                              // height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            const Space(),
                            Stack(
                              children: [
                                _image != null
                                    ? CircleAvatar(
                                        radius: 64,
                                        backgroundImage: MemoryImage(_image!),
                                        backgroundColor:
                                            GlobalVariables.primaryColor,
                                      )
                                    : const CircleAvatar(
                                        radius: 64,
                                        backgroundImage: AssetImage(
                                            'assets/images/blank.png'),
                                        backgroundColor:
                                            GlobalVariables.primaryColor,
                                      ),
                                Positioned(
                                  bottom: -10,
                                  left: 80,
                                  child: IconButton(
                                    onPressed: selectImage,
                                    icon: const Icon(Icons.add_a_photo),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            MyTextField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Enter your name";
                                }
                                return null;
                              },
                              inputType: TextInputType.name,
                              label: "Name",
                              controller: nameController,
                              obscure: false,
                            ),
                            const Space(),
                            MyTextField(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter an Email";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return "Invalid Email !";
                                }
                                return null;
                              },
                              inputType: TextInputType.emailAddress,
                              label: "Email",
                              controller: emailController,
                              obscure: false,
                            ),
                            const Space(),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return MyTextField(
                                  obscure: !_isVisible,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter Password";
                                    }
                                    if (value.length < 6) {
                                      return "Password is Short";
                                    }
                                    return null;
                                  },
                                  inputType: TextInputType.text,
                                  label: "Password",
                                  controller: passwordController,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                    icon: _isVisible
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                );
                              },
                            ),
                            const Space(),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return MyTextField(
                                  obscure: !_isVisible,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Confirm your Password";
                                    }
                                    if (value.length < 6) {
                                      return "Password is Short";
                                    }
                                    if (secondPasswordController.text !=
                                        passwordController.text) {
                                      return "Passwords do not match";
                                    }
                                    return null;
                                  },
                                  inputType: TextInputType.text,
                                  label: "Re-Type Password",
                                  controller: secondPasswordController,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                    icon: _isVisible
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                );
                              },
                            ),
                            const Space(),
                            CustomButton(
                              onTap: signUp,
                              label: "Sign Up",
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, LoginScreen.routeName),
                              child: const Text("Already Have an Account"),
                            )
                          ],
                        ),
                      );
                    default:
                      return const Text("Loading");
                  }
                }),
          ),
        ),
      ),
    );
  }
}
