import 'package:rememory/components/colors.dart';
import 'package:rememory/services/constants.dart';
import 'package:rememory/services/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'analytics/analytics.dart';
import 'contacts/contacts.dart';
import 'dashboard/dashboard.dart';

class Home extends StatefulWidget {
  final int index;
  Home(this.index,);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentindex;
  bool contact;

  final tabs = [
    Dashboard(),
    Analytics(),
    Contacts(),
  ];

  @override void initState() {
    getUserInfo();
    super.initState();
    setState(() {
      _currentindex = widget.index;
    });
  }

  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentindex],

      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(1),
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                height: 100,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentindex,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  elevation: 0,
                  unselectedItemColor: secondaryText.withOpacity(0.7),
                  selectedItemColor: Color(0xff46457d),
                  items: [
                    BottomNavigationBarItem(
                      icon: Container(
                          child: Icon(MdiIcons.viewDashboardOutline, size: 30,)
                      ),
                      label: 'Dashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                          child: Icon(MdiIcons.googleAnalytics, size: 30,)
                      ),
                      label: 'Analytics',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                          child: Icon(Icons.account_circle, size: 30,)
                      ),
                      label: 'Contacts',
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      _currentindex = index;
                    });
                  },
                ),
              ),
            ],
          )
      ),
    );
  }
}