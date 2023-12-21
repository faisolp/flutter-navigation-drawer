import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> routes = [
    {'route': '/home', 'title': 'Home', 'icon': 'home'},
    {'route': '/profile', 'title': 'Profile', 'icon': 'person'},
    // เพิ่ม routes อื่นๆ ที่นี่
  ];

  Widget _currentWidget = Home();

  Widget getPageWidget(String route) {
    switch (route) {
      case '/home':
        return Home();
      case '/profile':
        return Profile();
      default:
        return Home();
    }
  }

  void _changePage(String route) {
    setState(() {
      _currentWidget = getPageWidget(route);
    });
  }

  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'person':
        return Icons.person;
      // เพิ่ม icons อื่นๆ ที่นี่
      default:
        return Icons.circle; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Drawer Example'),
      ),
      body: _currentWidget,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            AppDrawerHeader(),
            AppDrawerItems(routes: routes, onChangePage: _changePage, getIcon: getIconData),
          ],
        ),
      ),
    );
  }
}

class AppDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(
        'Drawer Header',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}

class AppDrawerItems extends StatelessWidget {
  final List<Map<String, dynamic>> routes;
  final Function(String) onChangePage;
  final Function(String) getIcon;

  AppDrawerItems({required this.routes, required this.onChangePage, required this.getIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: routes.map((route) => DrawerItem(
            title: route['title'],
            iconData: getIcon(route['icon']),
            onTap: () => onChangePage(route['route']),
          )).toList(),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  DrawerItem({required this.title, required this.iconData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    );
  }
}
