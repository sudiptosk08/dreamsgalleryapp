import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/shoppage/shopPage_screen.dart';
import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class BrandPage extends StatefulWidget {
  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == false ||
              store.state.darkModeState == null
          ? Colors.white
          : Color(0xFF0F0E0E),
      appBar: AppBar(
        elevation: 0.6,
        backgroundColor: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Colors.grey[900],
        centerTitle: true,
        title: Text(
          "Brand",
          style: KTextStyle.headline5.copyWith(
            color: store.state.darkModeState == false ||
                    store.state.darkModeState == null
                ? Colors.black
                : Colors.grey[400],
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 6 * SizeConfig.imageSizeMultiplier,
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: 2.3 * SizeConfig.imageSizeMultiplier),
          child: Column(
            children: List.generate(
              store.state.homeBrandState.length,
              (index) => SpecialOfferCard(
                imagePath: store.state.homeBrandState[index]['image'],
                press: () {
                  setState(() {
                    store.dispatch(HomeFilterBrandAction(
                        store.state.homeBrandState[index]['id']));
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopPageProduct(
                                groupCategoryValue: null,
                              )));
                }, //id: null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    required this.imagePath,
    required this.press,
    //this.id,
  });

  final String imagePath;
  final GestureTapCallback press;
  //late int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            2.3 * SizeConfig.imageSizeMultiplier,
            2 * SizeConfig.imageSizeMultiplier,
            2.3 * SizeConfig.imageSizeMultiplier,
            0),
        child: GestureDetector(
            onTap: press,
            child: SizedBox(
              width: double.infinity,
              height: 30 * SizeConfig.imageSizeMultiplier,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Colors.black,
                    image: DecorationImage(
                      image: NetworkImage(
                        imagePath,
                      ),
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    )),
              ),
            )));
  }
}
