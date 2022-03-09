// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'post_detail.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({Key? key}) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  CollectionReference owners =
      FirebaseFirestore.instance.collection('home_posts');

  final Stream<QuerySnapshot> ownersStream =
      FirebaseFirestore.instance.collection('home_posts').snapshots();

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

  _bodyRowCell(
    List<dynamic> ownerDetails,
    int i,
    filedName,
  ) {
    return ListTile(
      title: Text(
        ownerDetails[i][filedName].toString(),
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      tileColor: Colors.grey[100],
    );
  }

  _topRowCell(text) {
    return ListTile(
      title: Text(
        text.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      tileColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
        final List ownerDetails = [];

        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map data = document.data() as Map<String, dynamic>;
          ownerDetails.add(data);
          data['id'] = document.id;
          print(document.id);
          print(data);
        }).toList();

        return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.bottom,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        border: TableBorder.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                        defaultColumnWidth: FixedColumnWidth(
                            screenWidth > 1024 ? 220.0 : 150.0),
                        // columnWidths: const <int, TableColumnWidth>{
                        //   1: FixedColumnWidth(100),
                        // },
                        children: [
                          TableRow(
                            children: [
                              _topRowCell('title'),
                              _topRowCell('Post Type'),
                              _topRowCell('Action'),
                            ],
                          ),
                          for (var i = 0; i < ownerDetails.length; i++) ...[
                            TableRow(
                              children: [
                                _bodyRowCell(ownerDetails, i, 'desccription'
                                    // .length > 7
                                    //     ? '{description.substring(0, 7)}...'
                                    //     : 'description'
                                    ),
                                _bodyRowCell(ownerDetails, i, 'post_type'),
                                TableCell(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Get.to(
                                              () => PostDetailsPage(
                                                  id: ownerDetails[i]['id']),
                                            );
                                            print(ownerDetails);
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
                                            deleteUser(ownerDetails[i]['id']);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
