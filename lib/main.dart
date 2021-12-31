import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey,
      ),
      home: const MyHomePage(title: 'Smart Home Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _features = [
    {
      'tab': 'Entrance',
      'feature': [
        {
          'function' : 'Front Door',
          'state' : false,
          'icon' : Icons.sensor_door_outlined,
        },
        {
          'function' : 'Front Window',
          'state' : false,
          'icon' : Icons.sensor_window_outlined,
        },
        {
          'function' : 'Entrance Lamp',
          'state' : false,
          'icon' : Icons.light_outlined,
        },
      ],
    },
    {
      'tab': 'Indoor',
      'feature': [
        {
          'function' : 'Indoor CCTV',
          'state' : false,
          'icon' : Icons.camera_indoor_outlined,
        },
        {
          'function' : 'Indoor Lamp',
          'state' : false,
          'icon' : Icons.light_outlined,
        },
        {
          'function' : 'Indoor Plug',
          'state' : false,
          'icon' : Icons.power_outlined,
        },
      ],
    },
    {
      'tab': 'Outdoor',
      'feature': [
        {
          'function' : 'Outdoor CCTV',
          'state' : false,
          'icon' : Icons.camera_outdoor_outlined,
        },
        {
          'function' : 'Outdoor Lamp',
          'state' : false,
          'icon' : Icons.lightbulb_outlined,
        },
        {
          'function' : 'Outdoor Plug',
          'state' : false,
          'icon' : Icons.power_outlined,
        },
      ],
    },
  ];
  
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _features.length);
  }

 @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }

  void _tapContainer(int index, int tab_index){
    setState(() {
      _features[tab_index]['feature'][index]['state'] = !_features[tab_index]['feature'][index]['state'];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: _features.map((category) => Tab(text: category['tab'])).toList(),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: _features.map((category) => Tab(text: category['tab'])).toList().map((Tab tab) {
          return Center(
            child: GridView.builder(
              primary: false,
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 175,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1
              ),
              itemCount: _features[_tabController.index]['feature'].length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _tapContainer(index, _tabController.index),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      children: <Widget>[
                        Text(_features[_tabController.index]['feature'][index]['function']),
                        Icon(_features[_tabController.index]['feature'][index]['icon'], color: _features[_tabController.index]['feature'][index]['state'] ? Colors.green : Colors.black, size: 50.0),
                        Text(_features[_tabController.index]['feature'][index]['state'] ? "On" : "Off"),
                      ],
                    ),
                  ),
                );
              },
            )
          );
        }).toList(),
      ),
    );
  }
}   