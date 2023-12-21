import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  static final  routes = [
    {"path": "/home", "title": "Home" ,"icon":"home"},
    {"path": "/profile", "title": "Profile","icon":"profile"},
  ];
  Widget getPageWidget(String path, String title) {
      switch (path) {
        case '/home':
          return Home(title: title);
        case '/profile':
          return Profile(title: title);
        // Add more cases for new pages
        default:
          return Home(title: 'Default'); // Default or error page
      }
  }
  static List<dynamic> getAppRoutesList() {
    
    return routes;
  }
  Map<String, WidgetBuilder> getAppRoutesPageWidget() {
    Map<String, WidgetBuilder> _routes = {};

    for (var item in routes) {
      final path = item['path']??"";
      final title = item['title']??"";
      _routes[path] = (context) => getPageWidget(path, title);
    }
    return _routes;
  }

 
  

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: getAppRoutesPageWidget(),
    );
  }
}

abstract class AppLayout extends StatelessWidget {
  Widget content();

  final String title;
  //AppLayout({required this.child});
  AppLayout({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer Navigation'),
      ),
      drawer: AppDrawer(appRoutes: MyApp.getAppRoutesList()),
      body: content(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final List<dynamic> appRoutes;

  AppDrawer({required this.appRoutes});

  @override
  Widget build(BuildContext context) {
    var _routes = appRoutes
        .map((item) => _buildDrawerItem(context, item["path"], item["title"]))
        .toList();
   // print("_routes:" + _routes.toString());
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
           ..._routes,
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String route, String title) {
    bool isSelected = ModalRoute.of(context)?.settings.name == route;
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : null,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop(); // Close the drawer
        if (!isSelected) {
          Navigator.of(context).pushNamed(route);
        }
      },
    );
  }
}

class Home extends AppLayout {
  Home({required String title}) : super(title: title);
  @override
  Widget content() {
    return Center(
      child: Text("Home Screen"),
    );
  }
}

class Profile extends AppLayout {
  Profile({required String title}) : super(title: title);
  @override
  Widget content() {
    return Center(
      child: Text("Profile Screen"),
    );
  }
}
