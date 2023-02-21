import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:friendfinder/widgets/labelpage.dart';
import 'package:friendfinder/widgets/route.dart';

import '../../../utils/showSnackBar.dart';
import '../../landing/screens/landing_screen.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  const UserProfile({super.key, required this.uid});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userData = {};
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      // var postSnap = await FirebaseFirestore.instance
      //     .collection('posts')
      //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      //     .get();

      // postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      // followers = userSnap.data()!['followers'].length;
      // following = userSnap.data()!['following'].length;
      // isFollowing = userSnap
      //     .data()!['followers']
      //     .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          )
        : Scaffold(
            appBar: buildAppBar(),
            body: Column(
              children: [
                Container(
                  height: size.height * 0.25,
                  child: Stack(children: [
                    Container(
                      // height: size.height * 0.10 - 27,
                      height: size.height * 0.25 - 44,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(48))),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        // height: 70,
                        height: size.height * 0.25,
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
                        child: Column(
                          children: [
                            Container(
                              // color: Colors.purple,
                              margin: EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                    userData['photoUrl'],
                                  ),
                                  radius: 40,
                                ),
                              ),
                            ),
                            Text(
                              userData['fullName'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(userData['username']),
                            Text(userData['email']),
                          ],
                          // color: Colors.blue,
                        ),
                      ),
                    )
                  ]),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  height: size.height * 0.50,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowBuilder(Icon(Icons.group), 'Groups'),
                      rowBuilder(Icon(Icons.card_membership), 'joined'),
                      ElevatedButton(
                          onPressed: () async {
                            // await FirebaseAuthMethods().signOut();
                            next(context, LandingPage());
                          },
                          child: const Text('sign out'))
                    ],
                  ),
                ),
              ],
            ),
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
                      label: 'Profile',
                      Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      )),
                  bottonNavBar(
                      label: 'Notification',
                      Icon(
                        Icons.notifications,
                        color: Colors.black,
                      )),
                  bottonNavBar(
                      label: '',
                      Icon(
                        Icons.add_circle,
                        color: Colors.black,
                      )),
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
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                onTap: _onItemTapped,
              ),
            ),
          );
  }

  Row rowBuilder(Icon icon, String text) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 10.0,
        ),
        Text(text),
      ],
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
