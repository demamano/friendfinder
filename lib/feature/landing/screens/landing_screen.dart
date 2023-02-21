import 'package:flutter/material.dart';
import 'package:friendfinder/common/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../feature/auth/screens/login.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget _buildTitle(BuildContext context, String s, double f, FontWeight h,
        double hfactor) {
      return Center(
        heightFactor: hfactor,
        child: Text(
          s,
          style: TextStyle(fontSize: f, fontWeight: h, color: Colors.black),
        ),
      );
    }

    List<String> imagesUrl = [
      'assets/image4.jpg',
      'assets/image2.jpg',
      'assets/image3.jpg',
      'assets/image2.jpg',
      'assets/image3.jpg',
    ];
    Widget _imageCircle(BuildContext context, int i) {
      return CircleAvatar(
        radius: 35,
        // child: Text('key'),

        backgroundImage: AssetImage(imagesUrl[i]),
      );
    }

    Widget imageCard(BuildContext context) {
      return Container(
        color: Color.fromARGB(255, 8, 28, 71),
        width: double.infinity,
        height: 70.0,
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              '4K friend finder',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Find New friends from every country',
              style: GoogleFonts.seymourOne(
                  fontSize: 16, color: Color.fromARGB(255, 177, 177, 177)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'And Any college of the world',
              style: GoogleFonts.seymourOne(
                  fontSize: 16, color: Color.fromARGB(255, 177, 177, 177)),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: size.width * 0.75,
                child: CustomButton(
                    text: 'Get Started',
                    onPressed: () {
                      // Navigator.pushReplacement(context, newRoute)
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LogInPage(),
                      ));
                    }))
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 1,
            children: [
              _buildTitle(
                  context, 'Find New Friends', 32.0, FontWeight.bold, 2.0),
              _buildTitle(context, 'Find New friends from every where', 18.0,
                  FontWeight.normal, 0.01),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: _imageCircle(context, 0),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: _imageCircle(context, 2),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: _imageCircle(context, 1),
          ),
          const SizedBox(
            height: 150.0,
          ),
          Expanded(child: imageCard(context))
        ],
      )),
    );
  }
}
