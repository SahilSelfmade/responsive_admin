import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_admin_dashboard/screens/Dashboard/dash_board_screen.dart';
import '../../widgets/text_field_input.dart';

class UserDetailsEditPage extends StatefulWidget {
  const UserDetailsEditPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<UserDetailsEditPage> createState() => _UserDetailsEditPageState();
}

class _UserDetailsEditPageState extends State<UserDetailsEditPage> {
  bool isLoading = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _referralCode = TextEditingController();
  final TextEditingController _referredBy = TextEditingController();
  final TextEditingController _profileImg = TextEditingController();

  Future<void> updateUser(
    id,
    firstName,
    lastName,
    phoneNumber,
    profileImg,
    referralCode,
    referredBy,
  ) {
    return users
        .doc(id)
        .update({
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneNumber,
          'referralCode': referralCode,
          'referred_by': referredBy,
          'profile_img': referredBy,
        })
        .then(
          (value) => print("User Updated"),
        )
        .catchError(
          (onError) => print(onError),
        );
  }

  // Future<void> updateUser() {
  //   return Container();
  // }

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
                var profileImg = data['profile_img'];
                var phoneNumber = data['phone_number'];
                var referralCode = data['referralCode'];
                var referredBy = data['referred_by'];

                _profileImg.text = profileImg.toString();
                _firstName.text = firstName.toString();
                _lastName.text = lastName.toString();
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
                              'Edit User Details',
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
                            labelText: 'First Name',
                            textInputType: TextInputType.text,
                            onChanged: (value) => firstName = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            textEditingController: _lastName,
                            labelText: 'Last Name',
                            // hintText: 'Hello',
                            textInputType: TextInputType.text,
                            onChanged: (value) => lastName = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            labelText: 'Phone',
                            enabled: false,
                            textEditingController: _phoneNumber,
                            textInputType: TextInputType.text,
                            onChanged: (value) => phoneNumber = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            labelText: 'Referral Code',
                            enabled: false,
                            textEditingController: _referralCode,
                            textInputType: TextInputType.text,
                            onChanged: (value) => referralCode = value,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFieldInput(
                            labelText: 'Referred By',
                            enabled: false,
                            textEditingController: _referredBy,
                            textInputType: TextInputType.text,
                            onChanged: (value) => referredBy = value,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                  updateUser(
                                    widget.id,
                                    firstName,
                                    lastName,
                                    phoneNumber,
                                    referralCode,
                                    referredBy,
                                    profileImg,
                                  );
                                });
                                // print(updateUser);
                                Get.off;
                                Get.snackbar(
                                  'Success',
                                  'User Updated Successfully.',
                                  isDismissible: true,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5,
                                  backgroundColor: Colors.white,
                                  duration: const Duration(
                                    seconds: 2,
                                  ),
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                // Get.to
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
                                'Update'.toUpperCase(),
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
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                Get.off(const DashBoardScreen());
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
