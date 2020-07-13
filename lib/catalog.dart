import 'package:catalog/filter.dart';
import 'package:catalog/global_variable.dart';
import 'package:catalog/product.dart';
import 'package:catalog/style.dart';
import 'package:catalog/userSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  AsyncSnapshot mySnapshot;

  Future<void> addOrRemoveFavorite(int index) async {
    setState(() {
      if (userSettings.checkFavorite(index)) {
        userSettings.removeFavorite(index);
      } else {
        userSettings.addFavorite(index);
      }
    });
    final pref = await SharedPreferences.getInstance();
    await pref.setString('userSettings', userSettings.toJson());
  }

  @override
  Widget build(BuildContext context) {
    {
      Widget filterParameters() {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: 84,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => filter(1),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://sun9-4.userapi.com/c857324/v857324456/1cdf9c/l_0xdlF-1Ww.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Сортировать',
                            textAlign: TextAlign.center,
                            style: mediumGrayTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 86,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => filter(2),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://sun9-21.userapi.com/c857324/v857324456/1cdfa3/kM7zX6AWV34.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Овощи и фрукты',
                            textAlign: TextAlign.center,
                            style: mediumGrayTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 86,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => filter(3),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://sun9-35.userapi.com/c857324/v857324456/1cdfaa/Qh0uxQFDO_I.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Хлеб и выпечка',
                            textAlign: TextAlign.center,
                            style: mediumGrayTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 86,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => filter(4),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://sun9-47.userapi.com/c857324/v857324456/1cdfb1/R2yXjgpHYUg.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Молоко и яйца',
                            textAlign: TextAlign.center,
                            style: mediumGrayTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => filter(5),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://sun9-4.userapi.com/c857324/v857324456/1cdf9c/l_0xdlF-1Ww.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Сортировать',
                            textAlign: TextAlign.center,
                            style: mediumGrayTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      Widget _productBuilder(BuildContext context, int index) {
        Widget favorite(int index) {
          Widget returnWithColor(Color color) {
            return Positioned(
              right: 10,
              top: 10,
              child: Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor)),
                child: GestureDetector(
                  onTap: () => addOrRemoveFavorite(index),
                  child: Icon(
                    Icons.favorite_border,
                    color: color,
                  ),
                ),
              ),
            );
          }

          if (userSettings.checkFavorite(index)) {
            return returnWithColor(Colors.green);
          }
          return returnWithColor(Colors.black);
        }

        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 18, 25, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  idAndProduct[mySnapshot.data[index]]
                                      .imageUrl),
                            ),
                          ),
                          width: 130,
                          height: 130,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(14, 17, 14, 0),
                        alignment: Alignment.topLeft,
                        child: FittedBox(
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text:
                                    idAndProduct[mySnapshot.data[index]].title,
                                style: smallBlackTextStyle,
                              ),
                              TextSpan(
                                  text:
                                      ' /${idAndProduct[mySnapshot.data[index]].unitOfMeasurement}',
                                  style: smallGrayTextStyle),
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 27, 14, 0),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                  color: idAndProduct[mySnapshot.data[index]]
                                      .colorOfRating,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Text(
                                '${idAndProduct[mySnapshot.data[index]].rating}',
                                style: smallWhiteTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '${idAndProduct[mySnapshot.data[index]].numberOfRatings} оценок',
                                style: smallGrayTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 140,
                            height: 30,
                            child: Text(
                              idAndProduct[mySnapshot.data[index]].description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: smallGrayTextStyle,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 7, 14, 0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              idAndProduct[mySnapshot.data[index]].from,
                              style: superSmallBlackTextStyle,
                              textAlign: TextAlign.left,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 25, 14, 25),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${idAndProduct[mySnapshot.data[index]].price} Р',
                            style: mediumBlackTextStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                  favorite(index),
                ],
              ),
            ),
          ),
        );
      }

      return SafeArea(
        child: StreamBuilder(
          stream: filteredMap,
          initialData: numberAndIdSet(idAndProduct),
          builder: (context, snapshot) {
            mySnapshot = snapshot;
            return CustomScrollView(slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.white,
                expandedHeight: 130.0,
                toolbarHeight: 130,
                actions: [
                  filterParameters(),
                ],
              ),
              snapshot.data.length == 0
                  ? const SliverPadding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 40),
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: Text('Нет товаров в этой категории'),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 40),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          //childAspectRatio: (MediaQuery.of(context).size.width/MediaQuery.of(context).size.height*1.2)
                          childAspectRatio: 190 / 350,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          // стоило сделать функцию _productBuilder(BuildContext context, int index) => ... вместо products(int index), тогда бы не была нужна эта анонимка
                          _productBuilder,
                          childCount: snapshot.data.length,
                        ),
                      ),
                    ),
            ]);
          },
        ),
      );
    }
  }
}
