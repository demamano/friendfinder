import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Try extends StatefulWidget {
  const Try({super.key});

  @override
  State<Try> createState() => _TryState();
}

class _TryState extends State<Try> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
              itemCount: (snapshot.data as dynamic).docs.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        (snapshot.data as dynamic).docs[index]['photoUrl']),
                  ),
                  title:
                      Text((snapshot.data as dynamic).docs[index]['username']),
                );
              }));
        }),
      ),
    );
  }
}
