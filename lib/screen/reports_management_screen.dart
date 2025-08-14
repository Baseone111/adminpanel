import 'package:flutter/material.dart';

class ReportsManagementScreen extends StatefulWidget {
  @override
  _ReportsManagementScreenState createState() =>
      _ReportsManagementScreenState();
}

class _ReportsManagementScreenState extends State<ReportsManagementScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = [
    'All',
    'Pending',
    'In Progress',
    'Resolved',
    'Closed'
  ];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports Management',
            style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshReports,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildTableHeader(),
                      const SizedBox(height: 8),
                      Expanded(child: _buildReportsTable()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewReport,
        icon: Icon(Icons.add),
        label: Text('New Report'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Row(
      children: [
        // Search Field
        Expanded(
          flex: 3,
          child: TextField(
            controller: _searchController,
            onChanged: (value) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search reports...',
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
        const SizedBox(width: 16),

        // Filter Dropdown
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedFilter,
                items: _filters
                    .map((filter) => DropdownMenuItem(
                          value: filter,
                          child: Text(filter, style: TextStyle(fontSize: 14)),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedFilter = value!),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Export Button
        ElevatedButton.icon(
          onPressed: _exportReports,
          icon: Icon(Icons.file_download, size: 18),
          label: Text('Export', style: TextStyle(fontSize: 14)),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('ID', style: _headerTextStyle())),
          Expanded(flex: 2, child: Text('Type', style: _headerTextStyle())),
          Expanded(flex: 3, child: Text('Location', style: _headerTextStyle())),
          Expanded(flex: 2, child: Text('Status', style: _headerTextStyle())),
          Expanded(flex: 2, child: Text('Date', style: _headerTextStyle())),
          Expanded(flex: 2, child: Text('Actions', style: _headerTextStyle())),
        ],
      ),
    );
  }

  Widget _buildReportsTable() {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, index) => Divider(height: 1),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text('#RPT${100 + index}',
                      style: TextStyle(fontFamily: 'RobotoMono'))),
              Expanded(flex: 2, child: Text('Suspicious Activity')),
              Expanded(flex: 3, child: Text('Downtown Area')),
              Expanded(
                  flex: 2,
                  child: _buildStatusChip(index % 3 == 0
                      ? 'Pending'
                      : index % 3 == 1
                          ? 'In Progress'
                          : 'Resolved')),
              Expanded(flex: 2, child: Text('2024-01-${15 + index}')),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.visibility, size: 20),
                        color: Colors.blue,
                        onPressed: () => _viewReport(index)),
                    IconButton(
                        icon: Icon(Icons.edit, size: 20),
                        color: Colors.orange,
                        onPressed: () => _editReport(index)),
                    IconButton(
                        icon: Icon(Icons.more_vert, size: 20),
                        color: Colors.grey,
                        onPressed: () => _showMoreOptions(index)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    final Map<String, Color> statusColors = {
      'Pending': Colors.orange,
      'In Progress': Colors.blue,
      'Resolved': Colors.green,
      'Closed': Colors.grey,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColors[status]!.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColors[status]!),
      ),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            color: statusColors[status],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  TextStyle _headerTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey[700]);
  }

  void _refreshReports() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Reports refreshed')));
  }

  void _exportReports() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Reports'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
                value: 'csv',
                groupValue: 'csv',
                title: Text('CSV Format'),
                onChanged: (val) {}),
            RadioListTile(
                value: 'pdf',
                groupValue: 'csv',
                title: Text('PDF Format'),
                onChanged: (val) {}),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Export started')));
              },
              child: Text('Export')),
        ],
      ),
    );
  }

  void _createNewReport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Create New Report')),
          body: Center(child: Text('New Report Form')),
        ),
      ),
    );
  }

  void _viewReport(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Report Details',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem('Report ID', '#RPT${1000 + index}'),
                    _buildDetailItem('Type', 'Suspicious Activity'),
                    _buildDetailItem('Location', 'Downtown Area'),
                    _buildDetailItem('Status', 'Pending'),
                    _buildDetailItem('Date Reported', '2024-01-15 14:30'),
                    _buildDetailItem('Reporter', 'Anonymous'),
                    const SizedBox(height: 16),
                    Text('Description:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      'Observed suspicious behavior near the central market area...',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 24),
                    Text('Attachments:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, children: [
                      _buildAttachmentChip('photo_1.jpg'),
                      _buildAttachmentChip('video_1.mp4')
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'))),
                const SizedBox(width: 16),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Update Status'))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildAttachmentChip(String filename) {
    return Chip(
      avatar: Icon(filename.endsWith('.mp4') ? Icons.videocam : Icons.image,
          size: 18),
      label: Text(filename),
      backgroundColor: Colors.grey[100],
    );
  }

  void _editReport(int index) {
    // TODO: Implement editing logic
  }

  void _showMoreOptions(int index) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Report Actions'),
        children: [
          SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: Text('Assign to Team')),
          SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: Text('Add Comment')),
          SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: Text('Archive Report')),
        ],
      ),
    );
  }
}
