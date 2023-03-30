// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Navigation Drawer',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.purple,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var style =
        Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white);

    Widget currentPage;
    switch (_selectedIndex) {
      case 0:
        currentPage = HomeFragment();
        break;
      case 1:
        currentPage = ProfileFragment();
        break;
      case 2:
        currentPage = SettingsFragment();
        break;
      default:
        throw UnimplementedError();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter App"),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.purple),
                child: Center(
                    child: Text(
                  "Nav Header",
                  style: style,
                )),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text("Item 1"),
                onTap: () {
                  _showSnackbar(context, "Item 1 clicked");
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text("Item 2"),
                onTap: () {
                  _showSnackbar(context, "Item 2 clicked");
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text("Item 3"),
                onTap: () {
                  _showSnackbar(context, "Item 3 clicked");
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text("Item 4"),
                onTap: () {
                  _showSnackbar(context, "Item 4 clicked");
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
        body: currentPage);
  }
}

void _showSnackbar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

class HomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("You are in home"),
    );
  }
}

class ProfileFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("You are in profile"),
    );
  }
}

class SettingsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      //child: Text("You are in settings"),
      child: ElevatedButton(
          child: Text("Go to Second route"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const SecondRoute())));
          }),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Go Back"),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
