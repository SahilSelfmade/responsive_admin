import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/screens/Dashboard/components/dashboard_content.dart';
import 'package:responsive_admin_dashboard/screens/Dashboard/dash_board_screen.dart';
import 'package:responsive_admin_dashboard/screens/upload/upload_main.dart';
import 'package:responsive_admin_dashboard/screens/users/user_main.dart';

import '../../../controllers/controller.dart';
import '../../audio/audio_main.dart';
import 'drawer_list_tile.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => Controller(),
        child: Drawer(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(appPadding),
                // child: Image.asset("assets/images/logowithtext.png"),
                child: Text(
                  'Logo\nArea',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              DrawerListTile(
                  title: 'Dashboard',
                  svgSrc: 'assets/icons/Dashboard.svg',
                  tap: () {
                    Get.to(DashBoardScreen());
                    print('Dashboard screen butoon clicked');
                  }),
              DrawerListTile(
                  title: 'Post Upload',
                  svgSrc: 'assets/icons/BlogPost.svg',
                  tap: () {
                    Get.to(PostUploadScreen());
                    print('Post screen butoon clicked');
                  }),
              DrawerListTile(
                  title: 'Audio',
                  svgSrc: 'assets/icons/Message.svg',
                  tap: () {
                    Get.to(AudioScreen());
                    print('audio page button clicked');
                  }),
              DrawerListTile(
                  title: 'Users',
                  svgSrc: 'assets/icons/Statistics.svg',
                  tap: () {
                    Get.to(UserScreen());
                    print('User screen butoon clicked');
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
                child: Divider(
                  color: grey,
                  thickness: 0.2,
                ),
              ),
              DrawerListTile(
                  title: 'Settings',
                  svgSrc: 'assets/icons/Setting.svg',
                  tap: () {}),
              DrawerListTile(
                  title: 'Logout',
                  svgSrc: 'assets/icons/Logout.svg',
                  tap: () {
                    print('Log screen butoon clicked');
                  }),
            ],
          ),
        ));
  }
}
