import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendfinder/colors.dart';
import 'package:friendfinder/feature/auth/controller/auth_controller.dart';
import 'package:friendfinder/feature/auth/screens/user_information_save.dart';
import 'package:friendfinder/widgets/route.dart';
import 'login.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  bool isLoading = false;
  Uint8List? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  final _emailConroller = TextEditingController();
  final _passwordController = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailConroller.dispose();
    _passwordController.dispose();
  }

  void signUpuser() async {
    //  set loading is true
    setState(() {
      isLoading = true;
    });
    final email = _emailConroller.text.trim();
    final password = _passwordController.text.trim();

    String refer =
        await ref.read(authControllerProvider).signUp(email, password, context);
    if (refer == 'success') {
      setState(() {
        isLoading = false;
      });
      if (!mounted) {
        return;
      }
      // next(context, const MobileLayoutScreen());
      next(context, const UserInfoSave());
    } else {
      setState(() {
        isLoading = false;
      });
      // show the error

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SignUpPage()

      body: SingleChildScrollView(
        child: Container(
          color: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              buildTextField('Email'),
              const SizedBox(
                height: 20.0,
              ),
              buildTextField('Password'),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: signUpuser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                    color: textColor,
                  ),
                  child: !isLoading
                      ? const Text(
                          'Sign up',
                        )
                      : const CircularProgressIndicator(
                          color: messageColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already have an account?'),
                    const SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () => nextScreen(context, const LogInPage()),
                      child: const Text('Login',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: textColor,
        // borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 55.0,
      child: TextField(
        controller: hintText == "Email" ? _emailConroller : _passwordController,
        decoration: InputDecoration(
          alignLabelWithHint: mounted,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 14.0),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
          prefixIcon: hintText == "Email"
              ? const Icon(Icons.email)
              : const Icon(Icons.lock_outline),
          suffixIcon: hintText == "Password"
              ? IconButton(
                  onPressed: _toggleVisibility,
                  icon: _isHidden
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                )
              : null,
        ),
        obscureText: hintText == "Password" ? _isHidden : false,
      ),
    );
  }
}
//  void signUpUser() async {
//     // set loading is true
//     setState(() {
//       isLoading = true;
//     });
//     // sign up user using authmethod
//     String res = await FirebaseAuthMethods().signUpUser(
//       email: _emailConroller.text.trim(),
//       fullName: _fullNameController.text.trim(),
//       password: _passwordController.text.trim(),
//       username: _usernameController.text.trim(),
//       file: _image!,
//     );
//     // if string returned success user has been created
//     if (res == 'success') {
//       setState(() {
//         isLoading = false;
//       });
//       if (!mounted) {
//         return;
//       }
//       // next(context, const MobileLayoutScreen());
//       next(context, Label());
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       // show the error
//       if (mounted) {
//         return showSnackBar(context, res);
//       }
//     }
//   }
