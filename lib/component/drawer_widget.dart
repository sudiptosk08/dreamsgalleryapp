import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/contact_us/contact_us.dart';
import 'package:dream_gallary/screen/notification/notification_screen.dart';
import 'package:dream_gallary/screen/paymentHistory/payment_h_screen.dart';
import 'package:dream_gallary/screen/report_isue/report_isue_screen.dart';
import 'package:dream_gallary/screen/sale/sale.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../k_text_style.dart';
import '../main.dart';

class DrawerWidgetLogIn extends StatefulWidget {
  @override
  _DrawerWidgetLogInState createState() => _DrawerWidgetLogInState();
}

class _DrawerWidgetLogInState extends State<DrawerWidgetLogIn> {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  bool _toggled =
      store.state.darkModeState == null || store.state.darkModeState == false
          ? false
          : true;

  @override
  Widget build(BuildContext context) {
    final name = store.state.newUserDataState == null
        ? store.state.userDataState['name']
        : store.state.newUserDataState['name'];
    final number = store.state.userDataState['contact'];
    final urlImage = store.state.userDataState['image'];
    return Drawer(
      child: Material(
        color: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Colors.grey[900],
        child: ListView(
          children: <Widget>[
            buildHeader(
              name: name,
              number: number,
              urlImage: "$urlImage",
            ),
            Container(
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  buildMenuItem(
                    text: 'Account',
                    icon: Icons.person_outline_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  buildMenuItem(
                    text: 'Notification',
                    icon: Icons.notifications_none_outlined,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  buildMenuItem(
                    text: 'Sale!',
                    icon: Icons.add_shopping_cart_sharp,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  buildMenuItem(
                    text: 'Payment History',
                    icon: Icons.receipt_long_outlined,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  buildMenuItem(
                    text: 'Contact Us',
                    icon: Icons.call,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  buildMenuItem(
                    text: 'Report Issue',
                    icon: Icons.report_problem_outlined,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  SwitchListTile(
                    value: _toggled,
                    title: Text(
                      "Dark Mode",
                      style: KTextStyle.subtitle3.copyWith(
                          color: store.state.darkModeState == false ||
                                  store.state.darkModeState == null
                              ? Colors.black
                              : Colors.grey),
                    ),
                    secondary: Icon(Icons.nights_stay_outlined,
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.grey),
                    onChanged: (bool value) async {
                      setState(() {
                        _toggled = value;
                      });
                      SharedPreferences darkMod =
                          await SharedPreferences.getInstance();
                      darkMod.setString('mode', _toggled.toString());
                      Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => HomeScreen()),
                        ModalRoute.withName('/'),
                      );
                    },
                  ),
                  buildMenuItem(
                    text: 'Sign Out',
                    icon: Icons.logout,
                    onClicked: () async {
                      SharedPreferences localStorage =
                          await SharedPreferences.getInstance();
                      localStorage.remove('token');
                      localStorage.remove('userData');
                      store.state.userDataState = null;
                      store.state.notificationState = null;
                      store.state.subTotalState = null;
                      SharedPreferences getVariableProductStorage =
                          await SharedPreferences.getInstance();
                      getVariableProductStorage.remove('variableProductData');
                      store.state.cartProductState = [];
                      store.state.getVariableProductState = null;
                      store.state.promoCodeState = null;
                      store.state.referralCodeState = null;
                      store.state.cartDataState = [];
                      store.state.giftVoucherState = null;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String number,
    //required VoidCallback onClicked,
  }) =>
      //InkWell(
      //onTap: onClicked,
      //child:
      Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 30)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(urlImage),
              backgroundColor: Colors.grey,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: KTextStyle.subtitle2.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  number,
                  style: KTextStyle.subtitle2.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        //),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon,
          color: store.state.darkModeState == false ||
                  store.state.darkModeState == null
              ? Colors.black
              : Colors.grey),
      title: Text(text,
          style: KTextStyle.subtitle3.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey,
              fontWeight: FontWeight.w600)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
        break;
      case 1:
        store.dispatch(LogoutUserAction("ProfileScreen"));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));

        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotificationScreen(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Sale(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PaymentHistory(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ContactUsScreen(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ReportIssue(),
        ));
        break;
    }
  }
}
