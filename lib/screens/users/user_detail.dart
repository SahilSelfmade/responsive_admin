import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_admin_dashboard/screens/Dashboard/dash_board_screen.dart';

import '../../widgets/text_field_input.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool isLoading = false;
  CollectionReference owners = FirebaseFirestore.instance.collection('users');

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _referralCode = TextEditingController();
  final TextEditingController _profileImg = TextEditingController();
  final TextEditingController _referredBy = TextEditingController();

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
                  .collection('users')
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
                var firstName = data!['first_name'];
                var lastName = data['last_name'];
                var phoneNumber = data['phone_number'];
                var profileImg = data['profile_img'];
                var referralCode = data['referralCode'];
                var referredBy = data['referredBy'];

                _firstName.text = firstName.toString();
                _lastName.text = lastName.toString();
                _profileImg.text = profileImg.toString();
                _phoneNumber.text = phoneNumber.toString();
                _referralCode.text = referralCode.toString();
                _referredBy.text = referredBy.toString();

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
                              'Registered User Details',
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
                            textEditingController: _firstName,
                            enabled: false,
                            labelText: 'First Name',
                            textInputType: TextInputType.text,
                            onChanged: (value) => firstName = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            textEditingController: _lastName,
                            enabled: false,
                            labelText: 'Last Name',
                            textInputType: TextInputType.text,
                            onChanged: (value) => lastName = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            enabled: false,
                            labelText: 'Phone',
                            textEditingController: _phoneNumber,
                            textInputType: TextInputType.text,
                            onChanged: (value) => phoneNumber = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            enabled: false,
                            labelText: 'Referral Code',
                            textEditingController: _referralCode,
                            textInputType: TextInputType.text,
                            onChanged: (value) => referralCode = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            enabled: false,
                            labelText: 'Referred By',
                            textEditingController: _referredBy,
                            textInputType: TextInputType.text,
                            onChanged: (value) => referredBy = value,
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
                                'HOME'.toUpperCase(),
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
