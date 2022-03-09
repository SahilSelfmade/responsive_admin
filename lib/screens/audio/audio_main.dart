import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/constants/responsive.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/screens/audio/audio_upload_view.dart';

import '../Dashboard/components/drawer_menu.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: DrawerMenu(),
      key: context.read<Controller>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: DrawerMenu(),
              ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: AudioUpload(),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}