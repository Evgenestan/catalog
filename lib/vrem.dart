import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Это что-то вроде экспериментальной зоны?)
void main() {
  runApp(MyApp());
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
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;

  void iconPressed() {}

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBarView() {
      Widget catalog() {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 50.0,
              actions: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          onPressed: iconPressed,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: IconButton(
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          onPressed: iconPressed,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: IconButton(
                          icon: Icon(
                            Icons.pageview,
                            color: Colors.black,
                          ),
                          onPressed: iconPressed,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Text('item $index');
                },
              ),
            ),
          ],
        );
      }

      return Expanded(
        child: TabBarView(
          controller: _tabController,
          children: [
            catalog(),
            Text('Фермеры'),
            Text('Агротуры'),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Каталог'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(5),
              //height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: TabBar(
                indicatorColor: Colors.green,
                indicator: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                controller: _tabController,
                tabs: [
                  Tab(
                    icon: Text('Продукты'),
                  ),
                  Tab(
                    icon: Text('Фермеры'),
                  ),
                  Tab(
                    icon: Text('Агротуры'),
                  ),
                ],
              ),
            ),
          ),
          tabBarView(),
        ],
      ),
    );
  }
}
