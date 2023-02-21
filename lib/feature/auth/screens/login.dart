import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendfinder/feature/auth/controller/auth_controller.dart';
import 'package:friendfinder/feature/auth/screens/signup.dart';
import 'package:friendfinder/widgets/labelpage.dart';
import 'package:friendfinder/widgets/route.dart';

import '../../../colors.dart';

class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  bool _isHidden = true;
  bool isLoading = false;
  final _emailConroller = TextEditingController();
  final _passwordController = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String result = await ref.read(authControllerProvider).signInWithEmail(
        _emailConroller.text.trim(), _passwordController.text.trim(), context);
    if (result == "success") {
      print("dema amano");
      if (mounted) {
        next(context, const Label());
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailConroller.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.android),
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
              Container(
                child: Row(children: const <Widget>[
                  Text('Forgotten Password?'),
                  SizedBox(
                    width: 10.0,
                  ),
                ]),
              ),
              const SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    color: textColor,
                  ),
                  child: !isLoading
                      ? const Text(
                          'Log In',
                        )
                      : const CircularProgressIndicator(
                          color: messageColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildSocialBtn(
                    () => print('Login with Facebook'),
                    const AssetImage(
                      'assets/logos/facebook.jpg',
                    ),
                  ),
                  buildSocialBtn(
                    () => print('Login with Google'),
                    const AssetImage(
                      'assets/logos/google.jpg',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Not to a member?'),
                    const SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        nextScreen(context, const SignUpScreen());
                      },
                      child: const Text('Register',
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
      height: 60.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        // color: Color(0xFF6CA8F1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: hintText == "Email" ? _emailConroller : _passwordController,
        decoration: InputDecoration(
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

  Widget buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }
}
