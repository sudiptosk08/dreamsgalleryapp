import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/shoppage/shopPage_screen.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../main.dart';

class PCategories extends StatefulWidget {
  @override
  _PCategoriesState createState() => _PCategoriesState();
}

class _PCategoriesState extends State<PCategories> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1 * SizeConfig.imageSizeMultiplier),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: store.state.isLoadingState == true
            ? Shimmer.fromColors(
                child: Row(children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        margin: EdgeInsets.only(right: 1.2),
                        height: 16 * SizeConfig.imageSizeMultiplier,
                        width: 16.2 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              0.5 * SizeConfig.imageSizeMultiplier)),
                      Container(
                        margin: EdgeInsets.only(right: 1.2),
                        height: 2.5 * SizeConfig.imageSizeMultiplier,
                        width: 13 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3 * SizeConfig.imageSizeMultiplier,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        margin: EdgeInsets.only(right: 1.2),
                        height: 16 * SizeConfig.imageSizeMultiplier,
                        width: 16.2 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              0.5 * SizeConfig.imageSizeMultiplier)),
                      Container(
                        margin: EdgeInsets.only(right: 1.2),
                        height: 2.5 * SizeConfig.imageSizeMultiplier,
                        width: 13 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3 * SizeConfig.imageSizeMultiplier,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        margin: EdgeInsets.only(right: 1.2),
                        height: 16 * SizeConfig.imageSizeMultiplier,
                        width: 16.2 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              0.5 * SizeConfig.imageSizeMultiplier)),
                      Container(
                        margin: EdgeInsets.only(right: 1.2),
                        height: 2.5 * SizeConfig.imageSizeMultiplier,
                        width: 13 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3 * SizeConfig.imageSizeMultiplier,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        margin: EdgeInsets.only(right: 1.2),
                        height: 16 * SizeConfig.imageSizeMultiplier,
                        width: 16.2 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              0.5 * SizeConfig.imageSizeMultiplier)),
                      Container(
                        margin: EdgeInsets.only(right: 1.2),
                        height: 2.5 * SizeConfig.imageSizeMultiplier,
                        width: 13 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3 * SizeConfig.imageSizeMultiplier,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        margin: EdgeInsets.only(right: 1.2),
                        height: 16 * SizeConfig.imageSizeMultiplier,
                        width: 16.2 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              0.5 * SizeConfig.imageSizeMultiplier)),
                      Container(
                        margin: EdgeInsets.only(right: 1.2),
                        height: 2.5 * SizeConfig.imageSizeMultiplier,
                        width: 13 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                ]),
                baseColor: Colors.grey[350]!,
                highlightColor: Colors.white,
                period: Duration(seconds: 4),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  store.state.groupProductState.length,
                  (index) => CategoryCard(
                    id: store.state.groupProductState[index]['id'],
                    icon: store.state.groupProductState[index]['image'],
                    text: store.state.groupProductState[index]['groupName'],
                    press: () {
                      setState(() {
                        store.dispatch(CategoryIndexAction(index));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopPageProduct(
                                      groupCategoryValue: store
                                          .state.groupProductState[index]['id'],
                                    )));
                      });
                    },
                  ),
                )),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.id,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final int id;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.5),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 16.15 * SizeConfig.imageSizeMultiplier,
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.all((3.31 * SizeConfig.imageSizeMultiplier)),
                height: 16 * SizeConfig.imageSizeMultiplier,
                width: 20.52 * SizeConfig.imageSizeMultiplier,
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          icon,
                        ))),
              ),
              SizedBox(height: 5),
              Text(text,
                  maxLines: 1,
                  style: KTextStyle.caption.copyWith(
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.grey[900]!.withOpacity(0.9)
                          : Colors.white,
                      fontSize: 9.5),
                  textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}
