import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/users/edit_user.dart';
import 'screens/users/user_detail.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  CollectionReference owners = FirebaseFirestore.instance.collection('users');
  final Stream<QuerySnapshot> ownersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  Future<void> deleteUser(id) {
    return owners
        .doc(id)
        .delete()
        .then((value) => Get.snackbar(
              'User Deleted Successfully',
              '',
              isDismissible: true,
              maxWidth: MediaQuery.of(context).size.width * 0.5,
              duration: const Duration(
                seconds: 2,
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            ))
        .catchError((error) => Get.snackbar(
              'User Deleted Failed',
              '$error',
              isDismissible: true,
              maxWidth: MediaQuery.of(context).size.width * 0.5,
              duration: const Duration(
                seconds: 2,
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ownersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something Went Wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List userDetails = [];

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map data = document.data() as Map<String, dynamic>;
            userDetails.add(data);
            data['id'] = document.id;
            print(document.id);
            print(data);
          }).toList();
          return ListView(
            children: [
              DataTable(
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Action'))
                ],
                rows: [
                  for (var i = 0; i < userDetails.length; i++) ...[
                    DataRow(cells: [
                      DataCell(Text( userDetails[i]['first_name'].toString(),)),
                      DataCell(Text('Flutter Basics')),
                      DataCell(Row(
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Get.to(
                                            () => UserDetailsPage(
                                                id: userDetails[i]['id']),
                                          );
                                          // print(userDetails);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Get.to(
                                            () => UserDetailsEditPage(
                                                id: userDetails[i]['id']),
                                          );
                                          // print(userDetails);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          deleteUser(userDetails[i]['id']);
                                        },
                                      ),
                                    ),
                                  ],
                                ),)
                    ]),
                  ]
                ],
              ),
            ],
          );
        });
  }
}
