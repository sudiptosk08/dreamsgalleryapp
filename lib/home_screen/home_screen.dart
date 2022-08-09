import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/component/floatingActionButton.dart';
import 'package:dream_gallary/home_screen/home_body.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/account/login/login_screen.dart';
import 'package:dream_gallary/screen/cart/cart_screen.dart';
import 'package:dream_gallary/screen/profile/profile_screen.dart';
import 'package:dream_gallary/screen/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../k_text_style.dart';
import '../main.dart';
import '../size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var token;
  var user;
  void initState() {
    getCredentials();
    getDarkCredentials();
   
    print('Token');
    super.initState();
  }

  getCredentials() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    user = localStorage.getString('userData');
    setState(() {
      store.state.userDataState =
          json.decode(localStorage.getString('userData')!);
    });
  }

  getDarkCredentials() async {
    SharedPreferences darkMod = await SharedPreferences.getInstance();
    darkMod.getString('mode');
    setState(() {
      store.state.darkModeState =
          json.decode(darkMod.getString('mode').toString());
    });
    print("--------store.stetta.darkmode-------");
    print(store.state.darkModeState);
  }

  
  int currentTab = (store.state.logoutUserData == "WishList")
      ? 1
      : (store.state.logoutUserData == "CartPage")
          ? 2
          : (store.state.logoutUserData == "ProfileScreen")
              ? 3
              : 0;
  final List<Widget> screens = [
    HomePage(),
    WishList(),
    CartScreen(),
    ProfileScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = (store.state.logoutUserData == "WishList")
      ? WishList()
      : (store.state.logoutUserData == "CartPage")
          ? CartScreen()
          : (store.state.logoutUserData == "ProfileScreen")
              ? ProfileScreen()
              : HomePage();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
      ),
      floatingActionButton: FloatingActionBottom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.white
            : Colors.grey[900],
        child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[800]!, width: 0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 20 * SizeConfig.imageSizeMultiplier,
                      onPressed: () {
                        setState(() {
                          currentScreen = HomePage();
                          currentTab = 0;
                          store.state.logoutUserData = null;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_outlined,
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? currentTab == 0
                                      ? Colors.red[700]
                                      : Colors.grey[600]
                                  : currentTab == 0
                                      ? Colors.red[700]
                                      : Colors.grey[400]),
                          Text(
                            "Home",
                            style: KTextStyle.buttonText4.copyWith(
                                color: Colors.grey[600], fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 20 * SizeConfig.imageSizeMultiplier,
                      onPressed: () {
                        setState(() {
                          token != null
                              ? currentScreen = WishList()
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => token != null
                                          ? CartScreen()
                                          : LogInScreen()));
                          currentTab = 1;
                          store.dispatch(LogoutUserAction("WishList"));
                          store.state.logoutUserData = null;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border,
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? currentTab == 1
                                      ? Colors.red[700]
                                      : Colors.grey[600]
                                  : currentTab == 1
                                      ? Colors.red[700]
                                      : Colors.grey[400]),
                          Text(
                            "Wishlist",
                            style: KTextStyle.buttonText4.copyWith(
                                color: Colors.grey[600], fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 19 * SizeConfig.imageSizeMultiplier,
                    ),
                    MaterialButton(
                      minWidth: 20 * SizeConfig.imageSizeMultiplier,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => token != null
                                      ? CartScreen()
                                      : LogInScreen()));
                          currentTab = 2;
                          store.dispatch(LogoutUserAction("CartPage"));
                          store.state.logoutUserData = null;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag_outlined,
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? currentTab == 2
                                      ? Colors.red[700]
                                      : Colors.grey[600]
                                  : currentTab == 2
                                      ? Colors.red[700]
                                      : Colors.grey[400]),
                          Text(
                            "Cart",
                            style: KTextStyle.buttonText4.copyWith(
                                color: Colors.grey[600], fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 20 * SizeConfig.imageSizeMultiplier,
                      onPressed: () {
                        setState(() {
                          token != null
                              ? currentScreen = ProfileScreen()
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => token != null
                                          ? CartScreen()
                                          : LogInScreen()));
                          currentTab = 3;
                          store.dispatch(LogoutUserAction("ProfileScreen"));
                          store.state.logoutUserData = null;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_outline_rounded,
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? currentTab == 3
                                      ? Colors.red[700]
                                      : Colors.grey[600]
                                  : currentTab == 3
                                      ? Colors.red[700]
                                      : Colors.grey[400]),
                          Text(
                            "Account",
                            style: KTextStyle.buttonText4.copyWith(
                                color: Colors.grey[600], fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
