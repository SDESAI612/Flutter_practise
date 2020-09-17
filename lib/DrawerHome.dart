import 'package:flutter/material.dart';
import 'package:flutter_app/Accounts.dart';
import 'package:flutter_app/GetApi.dart';
import 'package:flutter_app/Home.dart';
import 'package:flutter_app/ListViewFromApi.dart';


class DrawerHome extends StatefulWidget{
  @override
    _DrawerHome createState() => _DrawerHome();

}

class _DrawerHome extends State<DrawerHome> {

  PageController _pageController = PageController();
  List<Widget> _screens =[
    ListViewFromApi(),GetApi(), Accounts()
  ];

  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  int _selectedIndex = 0;

  void _onPageChanged(int index) {

    setState((){
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drawer')),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        // backgroundColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
            title: Text('Home', style:  TextStyle(color: _selectedIndex == 0 ? Colors.blue : Colors.grey)),

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
                  title: Text('favorite', style:  TextStyle(color: _selectedIndex == 1 ? Colors.blue : Colors.grey)),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
                title: Text('Accounts', style:  TextStyle(color: _selectedIndex == 2 ? Colors.blue : Colors.grey)),
          ),
        ],
      ),
      drawer:  Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('List of Data'),
              onTap: () {
                Navigator.pop(context);
                Route route = MaterialPageRoute(builder: (context) => GetApi());
                Navigator.push(context, route);
                },
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => Home('demo','demo'),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(0.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
