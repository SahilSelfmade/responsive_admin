import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_admin_dashboard/screens/Dashboard/components/custom_appbar.dart';
import 'post_detail.dart';

class PostDetails extends StatefulWidget {
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  CollectionReference posts =
      FirebaseFirestore.instance.collection('home_posts');
  final Stream<QuerySnapshot> postsStream =
      FirebaseFirestore.instance.collection('home_posts').snapshots();

  Future<void> deleteUser(id) {
    return posts
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

  DataColumn _topRow(String name) => DataColumn(
        label: Text(
          name.toUpperCase(),
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: postsStream,
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
          return Column(
            children: [
              Scrollbar(
                child: ListView(
                  // scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    CustomAppbar(),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            _topRow("Post Description"),
                            _topRow('Post Type'),
                            _topRow('Action')
                          ],
                          rows: [
                            for (var i = 0; i < userDetails.length; i++) ...[
                              DataRow(cells: [
                                DataCell(Text(
                                  userDetails[i]['description'].toString(), 
                                )),
                                DataCell(Text(
                                  userDetails[i]['post_type'].toString(),
                                )),
                                DataCell(
                                  Row(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            Get.to(
                                              () => PostDetailsPage(
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
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            deleteUser(userDetails[i]['id']);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
