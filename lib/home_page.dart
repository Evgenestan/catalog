import 'package:catalog/catalog.dart';
import 'package:catalog/global_variable.dart';
import 'package:catalog/product.dart';
import 'package:catalog/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;

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
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              /*
              В целом стоит выносить константы куда-то в отдельный файл для переиспользования,
              например сделать этот цвет константой const Color lightColor = Color(0xFFf2f3f3);
              И использовать тут lightColor (название условное) - так ты сможешь не искать в коде
              все использования этого цвета, если он изменится в дизайне, чтобы изменить его в приложении,
              и намного удобнее иметь все в одном месте, перед глазами
              */
              color: lightColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: TabBar(
              labelColor: labelColor,
              unselectedLabelColor: Colors.black,
              indicator: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 3,
                    offset: Offset(1, 1),
                    spreadRadius: 1,
                  )
                ],
                color: tabBarColor,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              controller: _tabController,
              tabs: const [
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: shadowColor,
        backgroundColor: Colors.white,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
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
            CatalogPage(),
            const Text('Фермеры'),
            const Text('Агротуры'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    idAndProduct = idAndProductSet();
    idAndProductUnmodifiable = idAndProduct;
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }
}
