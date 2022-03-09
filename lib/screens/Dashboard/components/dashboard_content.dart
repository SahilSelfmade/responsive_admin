import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/constants/responsive.dart';
import 'custom_appbar.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppbar(),
        SizedBox(
          height: 40,
        ),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: const <TextSpan>[
                TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                    fontSize: 34,
                  ),
                ),
                TextSpan(
                    text: 'Mission K3',
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
          ),
        ),
      ],
    );
  }
}
