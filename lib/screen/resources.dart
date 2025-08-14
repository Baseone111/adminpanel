import 'package:flutter/material.dart';
import 'package:webadminpernal/screen/resource_details.dart';

class AdminResourcesManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Safety Resources'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSectionTile(
            context,
            title: 'Emergency Contacts',
            icon: Icons.local_hospital,
            onTap: () => _navigateTo(context, 'EmergencyContacts'),
          ),
          _buildSectionTile(
            context,
            title: 'Safety Guides',
            icon: Icons.menu_book,
            onTap: () => _navigateTo(context, 'SafetyGuides'),
          ),
          _buildSectionTile(
            context,
            title: 'Helpline Numbers',
            icon: Icons.support_agent,
            onTap: () => _navigateTo(context, 'Helplines'),
          ),
          _buildSectionTile(
            context,
            title: 'Educational Content',
            icon: Icons.school,
            onTap: () => _navigateTo(context, 'EducationalContent'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTile(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _navigateTo(BuildContext context, String section) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminResourceDetailScreen(sectionName: section),
      ),
    );
  }
}
