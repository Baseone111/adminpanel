import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('System Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          _buildSettingsSection('General Settings', [
            _buildSettingsTile('System Name', 'FootPrintToFreedom'),
            _buildSettingsTile('Admin Email', 'admin@footprinttofreedom.com'),
            _buildSettingsTile('Time Zone', 'UTC+3 (EAT)'),
          ]),
          SizedBox(height: 20),
          _buildSettingsSection('Notification Settings', [
            _buildSwitchTile('Email Notifications', true),
            _buildSwitchTile('SMS Alerts', false),
            _buildSwitchTile('Push Notifications', true),
          ]),
          SizedBox(height: 20),
          _buildSettingsSection('Security Settings', [
            _buildSettingsTile('Two-Factor Authentication', 'Enabled'),
            _buildSettingsTile('Session Timeout', '30 minutes'),
            _buildSettingsTile('Password Policy', 'Strong'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Text(value, style: TextStyle(color: Colors.grey[600])),
          SizedBox(width: 8),
          Icon(Icons.edit, size: 16, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Switch(
            value: value,
            onChanged: (newValue) {},
          ),
        ],
      ),
    );
  }
}
