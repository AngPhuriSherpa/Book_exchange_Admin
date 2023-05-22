import 'package:flutter/material.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentPageIndex = 0;

  final List<Widget> _screens = [
   
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Lend',
          ),
        ],
        currentIndex: _currentPageIndex,
        onTap: _onDestinationSelected,
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _screens,
      ),
    );
  }
}
