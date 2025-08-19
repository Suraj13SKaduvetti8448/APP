import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_routes.dart';
import '../../core/constants.dart';
import '../../services/auth_service.dart';

class DesignerHome extends StatelessWidget {
  const DesignerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Designer – Dashboard'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.productList),
            icon: const Icon(Icons.inventory_2),
            tooltip: 'Product List',
          ),
          IconButton(
            //onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
            onPressed: () {
              // TODO: Implement settings navigation (backend integrated)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings will be available soon')),
              );
            },
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
          ),
          const SizedBox(width: 4),
          CircleAvatar(
            backgroundImage: NetworkImage(AppConst.mockAvatar),
            radius: 16,
          ),
          IconButton(
            onPressed: () => auth.logout().then(
                  (_) => Navigator.pushReplacementNamed(context, AppRoutes.login),
            ),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Ongoing Projects",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          const _ProjectTile(
            title: 'Living Room – Sharma Residence',
            subtitle: 'Plan layout, suggest furniture, send updates',
            progress: 0.6,
          ),
          const _ProjectTile(
            title: 'Office Bay – BlueTech',
            subtitle: 'Modular desks, ergonomic chairs, lighting',
            progress: 0.4,
          ),
          const _ProjectTile(
            title: 'Bedroom – Jain Apartment',
            subtitle: 'Wardrobe planning, bed & side tables',
            progress: 0.8,
          ),

          const SizedBox(height: 24),
          const Text(
            "Quick Actions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _QuickAction(
                icon: Icons.add_circle_outline,
                label: "New Project",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("New Project will be available soon")),
                  );
                },
              ),
              _QuickAction(
                icon: Icons.group_outlined,
                label: "Client Requests",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Client Requests will be available soon")),
                  );
                },
              ),
              _QuickAction(
                icon: Icons.dashboard_customize_outlined,
                label: "Design Tools",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Design Tools will be available soon")),
                  );
                },
              ),
              _QuickAction(
                icon: Icons.history,
                label: "Past Projects",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Past Projects will be available soon")),
                  );
                },
              ),
            ],
          ),


          const SizedBox(height: 24),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.insights, color: Colors.blue),
              title: const Text("Analytics & Reports"),
              subtitle: const Text("Track performance, projects, and approvals"),
              trailing: const Icon(Icons.chevron_right),
              //onTap: () => Navigator.pushNamed(context, AppRoutes.analytics),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Analytics will be available soon")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Project Card with progress bar
class _ProjectTile extends StatelessWidget {
  final String title, subtitle;
  final double progress;
  const _ProjectTile({
    required this.title,
    required this.subtitle,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.folder_open, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: Colors.deepPurple,
              minHeight: 6,
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        //onTap: () => Navigator.pushNamed(context, AppRoutes.projectDetails),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Project details will be available soon")),
          );
        },
      ),
    );
  }
}

/// Quick Action buttons (grid-like shortcuts)
class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue[50],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
