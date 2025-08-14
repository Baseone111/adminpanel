import 'package:flutter/material.dart';
import 'package:webadminpernal/models/navigation_modal.dart';
import 'package:webadminpernal/screen/alerts_management_screen.dart';
import 'package:webadminpernal/screen/analytic_screen.dart';
import 'package:webadminpernal/screen/dashbord_screen.dart';
import 'package:webadminpernal/screen/missingperson_screen.dart';
import 'package:webadminpernal/screen/reports_management_screen.dart';
import 'package:webadminpernal/screen/settings_page.dart';
import 'package:webadminpernal/screen/user_management_screen.dart';

class AdminMainScreen extends StatefulWidget {
  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0;
  bool _isCollapsed = false;

  final List<Widget> _screens = [
    DashboardScreen(),
    ReportsManagementScreen(),
    AlertsManagementScreen(),
    UsersManagementScreen(),
    MissingPersonsManagementScreen(),
    AnalyticsScreen(),
    SettingsScreen(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(Icons.dashboard, 'Dashboard'),
    NavigationItem(Icons.report, 'Reports'),
    NavigationItem(Icons.notification_important, 'Alerts'),
    NavigationItem(Icons.people, 'Users'),
    NavigationItem(Icons.person_search, 'Missing Persons'),
    NavigationItem(Icons.analytics, 'Analytics'),
    NavigationItem(Icons.settings, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        return Scaffold(
          drawer: isMobile ? Drawer(child: _buildSidebar(true)) : null,
          body: Row(
            children: [
              if (!isMobile)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _isCollapsed ? 70 : 240,
                  child: _buildSidebar(false),
                ),
              Expanded(
                child: Column(
                  children: [
                    _buildTopBar(isMobile),
                    Divider(height: 1),
                    Expanded(
                      child: Container(
                        color: Colors.grey[100],
                        child: _screens[_selectedIndex],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSidebar(bool isDrawer) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E3A8A),
        boxShadow: isDrawer
            ? []
            : [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 0),
                ),
              ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.admin_panel_settings,
                      color: Colors.white, size: 28),
                  if (!_isCollapsed || isDrawer) ...[
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Admin Panel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                  if (!isDrawer)
                    IconButton(
                      icon: Icon(
                        _isCollapsed ? Icons.menu : Icons.menu_open,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          setState(() => _isCollapsed = !_isCollapsed),
                    ),
                ],
              ),
            ),
            Divider(color: Colors.white24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _navigationItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    NavigationItem item = entry.value;
                    bool isSelected = _selectedIndex == index;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: Icon(
                          item.icon,
                          color: isSelected ? Colors.white : Colors.white70,
                        ),
                        title: !_isCollapsed || isDrawer
                            ? Text(
                                item.title,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white70,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              )
                            : null,
                        tileColor: isSelected ? Colors.white24 : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          setState(() => _selectedIndex = index);
                          if (isDrawer) Navigator.pop(context);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (!_isCollapsed || isDrawer)
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Admin User',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'admin@footprinttofreedom.com',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(bool isMobile) {
    return Container(
      height: 60,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          Expanded(
            child: Text(
              _navigationItems[_selectedIndex].title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
