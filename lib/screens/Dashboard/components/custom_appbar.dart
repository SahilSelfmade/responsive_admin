import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/constants/responsive.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isDesktop(context))
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: context.read<Controller>().controlMenu,
            icon: Icon(
              Icons.menu,
              color: textColor.withOpacity(0.5),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      );
    else {
      return Container();
    }
  }
}
