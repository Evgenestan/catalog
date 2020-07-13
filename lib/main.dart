import 'package:catalog/product.dart';
import 'package:catalog/style.dart';
import 'package:catalog/userSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Если ты запускаешь какую-то асинхронную функцию в main, которая как-то инициализирует твое приложение - сделай и main асинхронным, и запускай приложение после инициализации
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUserSettings();
  runApp(MyApp());
}

Future<void> setUserSettings() async {
  // final
  var pref = await SharedPreferences.getInstance();
  // Присвоение 'null', если pref вернет обычный null - не имеет смысла, можно было не усложнять + сделай ее final
//  var userSettingsJson = await pref.getString('userSettings') ?? 'null'; // await не нужен, тк pref.getString возвращает String, а не Future<String>
  final userSettingsJson = await pref.getString('userSettings');
  if (userSettingsJson != null) {
    userSettings.fromJson(userSettingsJson);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Каталог',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // Эта переменная не переопределяется - сделай ее final, вообще запомни правило - если переменная не переопределяется - final, если переопределяется - лучше объявлять переменную через тип, а не var
  // с var в прошлый раз я тебе показывал, к каким проблемам может привести его использование при невнимательности, поэтому объявляй так: int numericVariable = 1; вместо var numericVariable = 1;
  var subject = PublishSubject<int>();
  // Вот как тут - тут же не var, а тип, но надо идти до конца и тип будет не просто Map, а Map<int, Product> ...
  // про final уже написал
  Map _idAndProduct = <int, Product>{};
  Map _idAndProductUnmodifiable = <int, Product>{};
  TabController _tabController;
  Map _numberAndId = <int, int>{};

  // я заменил твой analysis_options на свой, мой - более строгий, и подсветит ошибки, например ту, что ты увидишь тут
  // Все, что подсветит тебе линтер - исправь
  void addOrRemoveFavorite(int index) async {
    setState(() {
      if (userSettings.checkFavorite(index)) {
        userSettings.removeFavorite(index);
      } else {
        userSettings.addFavorite(index);
      }
    });
    var pref = await SharedPreferences.getInstance();
    await pref.setString('userSettings', userSettings.toJson());
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverAppBar(
        expandedHeight: 90,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
          child: Container(
            width: 400,
            height: 55,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              /*
              В целом стоит выносить константы куда-то в отдельный файл для переиспользования,
              например сделать этот цвет константой const Color lightColor = Color(0xFFf2f3f3);
              И использовать тут lightColor (название условное) - так ты сможешь не искать в коде
              все использования этого цвета, если он изменится в дизайне, чтобы изменить его в приложении,
              и намного удобнее иметь все в одном месте, перед глазами
              */
              color: Color(0xFFf2f3f3),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: TabBar(
              labelColor: Color(0xFFe3ffe0),
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x99a0a0a0),
                    blurRadius: 3,
                    offset: Offset(1, 1),
                    spreadRadius: 1,
                  )
                ],
                // тоже самое про константы
                color: Color(0xFF47a73d),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              controller: _tabController,
              tabs: [
                Tab(
                  icon: Text(
                    'Продукты',
                    style: nonColorMediumText,
                  ),
                ),
                Tab(
                  icon: Text('Фермеры', style: nonColorMediumText),
                ),
                Tab(
                  icon: Text('Агротуры', style: nonColorMediumText),
                ),
              ],
            ),
          ),
        ),
        floating: true,
      );
    }

    Widget catalog() {
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
                          onTap: () => subject.add(1),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://sun9-4.userapi.com/c857324/v857324456/1cdf9c/l_0xdlF-1Ww.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                          onTap: () => subject.add(2),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://sun9-21.userapi.com/c857324/v857324456/1cdfa3/kM7zX6AWV34.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                          onTap: () => subject.add(3),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://sun9-35.userapi.com/c857324/v857324456/1cdfaa/Qh0uxQFDO_I.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                          onTap: () => subject.add(4),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://sun9-47.userapi.com/c857324/v857324456/1cdfb1/R2yXjgpHYUg.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                          onTap: () => subject.add(5),
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://sun9-4.userapi.com/c857324/v857324456/1cdf9c/l_0xdlF-1Ww.jpg'),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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

      Widget products(int index) {
        Widget favorite(int index) {
          Widget returnWithColor(Color color) {
            return Positioned(
              right: 10,
              top: 10,
              child: Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: borderColor)),
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
            decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(_idAndProduct[_numberAndId[index]].imageUrl),
                            ),
                          ),
                          width: 130,
                          height: 130,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(14, 17, 14, 0),
                        alignment: Alignment.topLeft,
                        child: FittedBox(
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: _idAndProduct[_numberAndId[index]].title,
                                style: smallBlackTextStyle,
                              ),
                              TextSpan(text: ' /${_idAndProduct[_numberAndId[index]].unitOfMeasurement}', style: smallGrayTextStyle),
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
                              decoration: BoxDecoration(color: _idAndProduct[_numberAndId[index]].colorOfRating, borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Text(
                                '${_idAndProduct[_numberAndId[index]].rating}',
                                style: smallWhiteTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                '${_idAndProduct[_numberAndId[index]].numberOfRatings} оценок',
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
                              _idAndProduct[_numberAndId[index]].description,
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
                              _idAndProduct[_numberAndId[index]].from,
                              style: superSmallBlackTextStyle,
                              textAlign: TextAlign.left,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 25, 14, 25),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${_idAndProduct[_numberAndId[index]].price} Р',
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
        child: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
              SliverPadding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 40),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //childAspectRatio: (MediaQuery.of(context).size.width/MediaQuery.of(context).size.height*1.2)
                    childAspectRatio: 190 / 350,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    // стоило сделать функцию _productBuilder(BuildContext context, int index) => ... вместо products(int index), тогда бы не была нужна эта анонимка
                    (BuildContext context, int index) {
                      return products(index);
                    },
                    childCount: _numberAndId.length,
                  ),
                ),
              ),
            ]);
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: shadowColor,
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Каталог',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: header(),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            catalog(),
            Text('Фермеры'),
            Text('Агротуры'),
          ],
        ),
      ),
    );
  }

  void filter(int value) {
    print(value);

    Map _idAndProduct = <int, Product>{};
    _numberAndId = numberAndIdSet(_idAndProductUnmodifiable);

    if (value == 1) {
      _idAndProduct = _idAndProductUnmodifiable;
      _numberAndId = numberAndIdSet(_idAndProductUnmodifiable);
    }

    for (var i = 0; i < _idAndProductUnmodifiable.length; i++) {
      print(i);
      print(_idAndProductUnmodifiable[_numberAndId[i]].title);
      if (_idAndProductUnmodifiable[_numberAndId[i]].category == value) {
        _idAndProduct[_numberAndId[i]] = _idAndProductUnmodifiable[_numberAndId[i]];
      }
    }
    setState(() {
      _numberAndId = numberAndIdSet(_idAndProduct);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    subject.close();
    super.dispose();
  }

  @override
  void initState() {
    _idAndProduct = idAndProductSet();
    _idAndProductUnmodifiable = _idAndProduct;
    _numberAndId = numberAndIdSet(_idAndProduct);
    _tabController = TabController(length: 3, vsync: this);
    subject.listen((value) {
      filter(value);
    });
    super.initState();
  }
}
