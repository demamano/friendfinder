import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendfinder/feature/auth/screens/user_information.dart';
import 'package:friendfinder/screens/mobile_layout_screen.dart';
import 'package:friendfinder/widgets/route.dart';

class Label extends StatefulWidget {
  const Label({super.key});

  @override
  State<Label> createState() => _LabelState();
}

class _LabelState extends State<Label> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      next(context, const Label());
    } else if (index == 1) {
      next(context, MobileLayoutScreen());
    } else if (index == 2) {
      // next(context, CreateGroup());
    } else if (index == 3) {
    } else if (index == 4) {
      next(
          context,
          UserProfile(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(child: Body()),
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: 60.0,
        child: BottomNavigationBar(
          iconSize: 30.0,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(overflow: TextOverflow.visible),
          selectedLabelStyle: TextStyle(overflow: TextOverflow.visible),
          items: <BottomNavigationBarItem>[
            bottonNavBar(
                label: 'Home',
                Icon(
                  Icons.home,
                  color: Colors.black,
                )),
            bottonNavBar(
                label: 'chat',
                Icon(
                  Icons.chat,
                  color: Colors.black,
                )),
            bottonNavBar(
                label: '',
                Icon(
                  Icons.add_circle,
                  color: Colors.black,
                )),
            bottonNavBar(
                label: 'search',
                Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            bottonNavBar(
                label: 'Profile',
                Icon(
                  Icons.account_circle,
                  color: Colors.black,
                )),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  BottomNavigationBarItem bottonNavBar(Icon icon, {required String label}) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      elevation: 0,
      centerTitle: true,
      title: Text('Home'),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.10,
          child: Stack(children: [
            Container(
              height: size.height * 0.10 - 27,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(48))),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xFF0C9869).withOpacity(0.23),
                      )
                    ]),
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
            )
          ]),
        ),
        Container(
          height: size.height * 0.15,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15.0),
          child: Row(
            children: [
              buidCol(size, 'assets/art.png', 'Art', text: 'Category'),
              buidCol(size, 'assets/tech.jpeg', 'Technology', text: ''),
              buidCol(size, 'assets/sport.webp', 'Sport', text: ''),
              buidCol(size, 'assets/explore.jpg', 'Explore', text: ''),
              buidCol(size, 'assets/anonym.png', 'Random', text: ''),
            ],
          ),
        ),
        const Text(
          textAlign: TextAlign.start,
          'Recommended Groups',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        groupInfoContainer(size),
        groupInfoContainer(size),
      ],
    );
  }

  Container groupInfoContainer(Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
      height: size.height * 0.21,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Color(0xFF0C9869).withOpacity(0.23),
            )
          ]),
      child: Row(children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            child: Image.asset(
              'assets/im.webp',
              height: size.height,
              width: size.width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRichText('Music Relax...', ''),
              buildRichText('Category', '  Art'),
              buildRichText('Number of members :', '50'),
              buildRichText('Latest Available Date', '2023-02-14'),
              buildRichText('Location', '3214 zuidland'),
            ],
          ),
        ),
      ]),
    );
  }

  RichText buildRichText(String text1, String text2) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: text1,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          TextSpan(text: text2, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  buidCol(Size size, String imageUrl, String categoryName,
      {required String text}) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
            child: buildcontainer(size, imageUrl, horizontalDistance: 8.0)),
        Text(
          categoryName,
          //   style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }

  Container buildcontainer(Size size, String imageUrl,
      {required double horizontalDistance}) {
    return Container(
      margin: EdgeInsets.only(left: horizontalDistance),
      width: size.width * 0.15,
      decoration: BoxDecoration(
        // color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        image: DecorationImage(
          // image:AssetImage(imageUrl) ,
          image: AssetImage(imageUrl),
        ),
        border: Border.all(
            color: Color.fromARGB(255, 9, 177, 23),
            width: 1.0,
            style: BorderStyle.solid),
      ),
    );
  }
}
