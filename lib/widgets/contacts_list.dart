import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:friendfinder/colors.dart';
import 'package:friendfinder/screens/mobile_chat_screen.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isNotEqualTo: "sPQnyG2GclPLWBPTjcZNaKZHdN43")
            .get(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // return Container(
          //   child: Text((snapshot.data as dynamic).docs['username']),
          // );

          return ListView.builder(
              shrinkWrap: true,
              itemCount: (snapshot.data as dynamic).docs.length,
              itemBuilder: ((context, index) {
                // return ListTile(
                //   leading: CircleAvatar(
                //     backgroundImage: NetworkImage(
                //         (snapshot.data as dynamic).docs[index]['photoUrl']),
                //   ),
                //   title:
                //       Text((snapshot.data as dynamic).docs[index]['username']),
                // );
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MobileChatScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(
                            (snapshot.data as dynamic)!
                                .docs[index]['fullName']
                                .toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              (snapshot.data as dynamic)!
                                  .docs[index]['username']
                                  .toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data as dynamic)!
                                  .docs[index]['photoUrl']
                                  ,
                            ),
                            radius: 30,
                          ),
                          trailing: Text(
                            (snapshot.data as dynamic)!
                                .docs[index]['username']
                                .toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(color: dividerColor, indent: 85),
                  ],
                );
              }));
        }),
      ),
    );
  }
}
