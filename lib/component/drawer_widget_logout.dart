import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/main.dart';
import 'package:dream_gallary/screen/account/login/login_screen.dart';
import 'package:dream_gallary/screen/contact_us/contact_us.dart';
import 'package:dream_gallary/screen/sale/sale.dart';
import 'package:dream_gallary/screen/terms&condition/term&condition.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidgetLogout extends StatefulWidget {
  @override
  _DrawerWidgetLogoutState createState() => _DrawerWidgetLogoutState();
}

class _DrawerWidgetLogoutState extends State<DrawerWidgetLogout> {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  bool _toggled =
      store.state.darkModeState == null || store.state.darkModeState == false
          ? false
          : true;

  @override
  Widget build(BuildContext context) {
    final name = 'Dreams Gallery';

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
              urlImage: '',
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
                    text: 'Sign In',
                    icon: Icons.login,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  buildMenuItem(
                    text: 'Contact Us',
                    icon: Icons.call,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  buildMenuItem(
                    text: 'Terms & Conditions',
                    icon: Icons.fact_check_outlined,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  buildMenuItem(
                    text: 'Sale!',
                    icon: Icons.add_shopping_cart_sharp,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  SwitchListTile(
                    value: _toggled,
                    title: Text(
                      "Dark Mode",
                      style: KTextStyle.subtitle3.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    secondary: Icon(
                      Icons.nights_stay_outlined,
                      color: store.state.darkModeState == false ||
                              store.state.darkModeState == null
                          ? Colors.black
                          : Colors.grey,
                    ),
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
                  )
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
  }) =>
      Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            store.state.darkModeState == null ||
                    store.state.darkModeState == false
                ? Container(
                    width: 23 * SizeConfig.imageSizeMultiplier,
                    height: 15 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                            image: AssetImage("assets/images/DG Logo.jpg"),
                            fit: BoxFit.contain)),
                  )
                : Container(
                    height: 28 * SizeConfig.imageSizeMultiplier,
                    width: 40.2 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.grey[900],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.all(4.4 * SizeConfig.imageSizeMultiplier),
                      child: SvgPicture.asset("assets/icons/DG SVG.svg"),
                    ),
                  ),
            const SizedBox(height: 8),
          ],
        ),
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
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyApp(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LogInScreen(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ContactUsScreen(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TermCondition(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Sale(),
        ));
        break;
    }
  }
}
