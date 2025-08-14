import 'package:flutter/material.dart';

class UsersManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Users Management',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 18 : 22,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshUsers(context),
            tooltip: 'Refresh',
          ),
          if (!isMobile)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _buildAddUserButton(context),
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(context, isMobile),
            const SizedBox(height: 20),
            _buildSearchFilterRow(context, isMobile),
            const SizedBox(height: 16),
            Expanded(
              child: isMobile
                  ? _buildMobileUserList(context)
                  : _buildDesktopUserTable(context),
            ),
          ],
        ),
      ),
      floatingActionButton: isMobile
          ? FloatingActionButton(
              onPressed: () => _showAddUserDialog(context),
              child: Icon(Icons.person_add),
              backgroundColor: theme.primaryColor,
            )
          : null,
    );
  }

  Widget _buildHeaderSection(BuildContext context, bool isMobile) {
    return Row(
      children: [
        Text(
          'Total Users: 1,234',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 16 : 18,
              ),
        ),
        const Spacer(),
        if (!isMobile) _buildAddUserButton(context),
      ],
    );
  }

  Widget _buildAddUserButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _showAddUserDialog(context),
      icon: Icon(Icons.person_add, size: 18),
      label: Text('Add User'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildSearchFilterRow(BuildContext context, bool isMobile) {
    return Row(
      children: [
        Expanded(
          flex: isMobile ? 3 : 4,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search users...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: isMobile ? 2 : 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: 'All',
                items: ['All', 'Active', 'Inactive', 'Admin', 'Standard']
                    .map((filter) => DropdownMenuItem(
                          value: filter,
                          child: Text(filter),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopUserTable(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 24,
            headingRowColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor.withOpacity(0.05),
            ),
            columns: const [
              DataColumn(label: Text('User ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: List.generate(15, (index) {
              return DataRow(cells: [
                DataCell(Text('USR${1000 + index}')),
                DataCell(Text('User ${index + 1}')),
                DataCell(Text('user${index + 1}@example.com')),
                DataCell(Text(index % 3 == 0 ? 'Admin' : 'Standard')),
                DataCell(
                    _buildStatusChip(index % 2 == 0 ? 'Active' : 'Inactive')),
                DataCell(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      color: Colors.blue,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, size: 20),
                      onPressed: () {},
                    ),
                  ],
                )),
              ]);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileUserList(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      separatorBuilder: (context, index) => Divider(height: 1),
      itemBuilder: (context, index) => ListTile(
        title: Text('User ${index + 1}'),
        subtitle: Text('user${index + 1}@example.com'),
        trailing: _buildStatusChip(index % 2 == 0 ? 'Active' : 'Inactive'),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final isActive = status == 'Active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? Colors.green : Colors.red),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isActive ? Colors.green : Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _refreshUsers(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Users list refreshed')),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New User'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User added successfully')),
              );
            },
            child: const Text('Add User'),
          ),
        ],
      ),
    );
  }
}
