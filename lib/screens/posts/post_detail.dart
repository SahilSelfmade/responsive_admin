import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_admin_dashboard/screens/Dashboard/dash_board_screen.dart';

import '../../widgets/text_field_input.dart';

class PostDetailsPage extends StatefulWidget {
  const PostDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  bool isLoading = false;
  CollectionReference owners =
      FirebaseFirestore.instance.collection('home_posts');

  final TextEditingController _description = TextEditingController();
  final TextEditingController _postType = TextEditingController();
  final TextEditingController _shares = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
            color: Colors.white,
            width: screenW < 1024 ? screenW * 0.95 : screenW * 0.4,
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('home_posts')
                  .doc(widget.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print('Something went Wrong');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data!.data();
                var description = data!['description'];
                var postType = data['post_type'];
                var shares = data['shares'];

                _description.text = description.toString();
                // .length > 5
                //     ? '{$description.substring(0,5)}...'
                //     : description.toString();
                _postType.text = postType.toString();
                _shares.text = shares.toString();

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Center(
                            child: Text(
                              'Post Details',
                              style: GoogleFonts.oswald(
                                textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          TextFieldInput(
                            textEditingController: _description,
                            enabled: false,
                            labelText: 'Description',
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            textEditingController: _postType,
                            enabled: false,
                            labelText: 'Post Type',
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            enabled: false,
                            labelText: 'Shares',
                            textEditingController: _shares,
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                Get.off(
                                  const DashBoardScreen(),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                'Go Back'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
