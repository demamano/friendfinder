import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendfinder/colors.dart';
import 'package:friendfinder/feature/auth/controller/auth_controller.dart';
import 'package:friendfinder/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/labelpage.dart';
import '../../../widgets/route.dart';

class UserInfoSave extends ConsumerStatefulWidget {
  const UserInfoSave({super.key});

  @override
  ConsumerState<UserInfoSave> createState() => _UserInfoSaveState();
}

class _UserInfoSaveState extends ConsumerState<UserInfoSave> {
  String? _selectedOption;

  final List<String> interests = [
    'Art',
    'sport',
    'exploration',
    'technology',
    'random'
  ];
  bool isLoading = false;
  File? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  final _fullNameController = TextEditingController();
  final _fieldController = TextEditingController();
  final _listController = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    super.dispose();

    _fullNameController.dispose();
    _fieldController.dispose();
  }

  void saveDataToFirebase() async {
    File file = _image!;
    setState(() {
      isLoading = true;
    });

    String result = await ref.read(authControllerProvider).saveUser(
        _fullNameController.text.trim(),
        _fieldController.text.trim(),
        file,
        context,
        _listController.text.trim());
    if (result == 'success') {
      setState(() {
        isLoading = false;
      });
      if (!mounted) {
        return;
      }

      next(context, const Label());
    } else {
      setState(() {
        isLoading = false;
      });
      // show the error

    }
  }

  // void selectImage() async {
  //   File im = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = im;
  //   });
  // }
  void selectImage() async {
    _image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget buildF() {
      return Stack(children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            // color: Colors.red,
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
            controller: _listController,
            decoration: InputDecoration(
              alignLabelWithHint: mounted,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              hintText: 'selected text',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
          ),
        ),
        DropdownButton<String>(
          items: interests.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
              _listController.text += '$value ';
            });
          },
          value: _selectedOption,
        ),
      ]);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 54,
                          backgroundImage: FileImage(_image!),
                          backgroundColor: Colors.white,
                        )
                      : const CircleAvatar(
                          radius: 54,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.white,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 70,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              buildTextField('FullName'),
              const SizedBox(
                height: 20.0,
              ),
              buildTextField('Field of Study'),
              const SizedBox(
                height: 20.0,
              ),
              buildF(),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: saveDataToFirebase,
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
                          'Save',
                        )
                      : const CircularProgressIndicator(
                          color: messageColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
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
        controller:
            hintText == "FullName" ? _fullNameController : _fieldController,
        // controller: hintText == "FullName"
        //     ? _fullNameController
        //     : (hintText == "Password"
        //         ? _listController
        //         : (hintText == 'FullName'
        //             ? _fullNameController
        //             : _fieldController)),
        decoration: InputDecoration(
          alignLabelWithHint: mounted,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 14.0),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
          prefixIcon: hintText == "Email"
              ? const Icon(Icons.email)
              : (hintText == "Password"
                  ? const Icon(Icons.lock_outline)
                  : (hintText == 'FullName'
                      ? const Icon(Icons.person_off_outlined)
                      : const Icon(Icons.verified_user_rounded))),
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
