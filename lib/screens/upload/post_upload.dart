// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_admin_dashboard/screens/Dashboard/components/custom_appbar.dart';

import '../../widgets/text_field_input.dart';

List<DropdownMenuItem<String>> get postCategoryItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Audio"), value: "audio"),
    const DropdownMenuItem(child: Text("Video"), value: "video"),
    const DropdownMenuItem(child: Text("Image"), value: "image"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get postTypeItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Free"), value: "free"),
    const DropdownMenuItem(child: Text("Paid"), value: "paid"),
  ];
  return menuItems;
}

class PostUpload extends StatefulWidget {
  const PostUpload({Key? key}) : super(key: key);

  @override
  _PostUploadState createState() => _PostUploadState();
}

class _PostUploadState extends State<PostUpload> {
  late var dataShow;
  late double screenHeight;
  late double screenWidth;
  String selectedPostTypeValue = "free";
  String selectedValue = "audio";

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  Widget header() {
    return RichText(
      text: TextSpan(
        children: const <TextSpan>[
          TextSpan(
            text: 'Post ',
            style: TextStyle(
              fontSize: 34,
            ),
          ),
          TextSpan(
              text: 'Upload',
              style: TextStyle(
                color: Color(0xff21a179),
                fontSize: 34,
              )),
          TextSpan(
            text: '!',
            style: TextStyle(
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            CustomAppbar(),
            const SizedBox(
              height: 34,
            ),
            header(),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Text(
                'Add Basic Description',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Title',
              textInputType: TextInputType.text,
              textEditingController: _titleController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Description',
              textInputType: TextInputType.text,
              textEditingController: _descriptionController,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Post Category Type',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButton(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      value: selectedPostTypeValue,
                      items: postTypeItems,
                      dropdownColor: Colors.grey[100],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPostTypeValue = newValue!;
                          print(newValue);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Post Type',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButton(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      isExpanded: true,
                      value: selectedValue,
                      items: postCategoryItems,
                      dropdownColor: Colors.grey[100],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              minWidth: screenWidth,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.grey[500],
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                );

                if (result != null) {
                  PlatformFile file = result.files.first;

                  print(file.name);
                  // print(file.bytes);
                  print(file.size);
                  print(file.extension);
                  print(file.path);
                  print(file.readStream);
                } else {
                  // User canceled the picker
                }
              },
              child: Text(
                'Select File'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(height: screenHeight * 0.01),
            MaterialButton(
              minWidth: screenWidth,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: const Color(0xff21a179),
              onPressed: () {},
              child: const Text(
                "PRESS TO UPLOAD FILE",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03)
          ],
        ),
      ),
    );
  }
}
