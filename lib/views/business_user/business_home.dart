import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_routes.dart';
import '../../core/constants.dart';
import '../../services/auth_service.dart';
import '../shared/profile_settings.dart';

class BusinessHome extends StatelessWidget {
  const BusinessHome({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business – Home'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.productList),
            icon: const Icon(Icons.list_alt),
            tooltip: 'Product List',
          ),
          const SizedBox(width: 4),
          CircleAvatar(backgroundImage: NetworkImage(AppConst.mockAvatar), radius: 16),
          IconButton(
            onPressed: () => auth.logout().then((_) =>
                Navigator.pushReplacementNamed(context, AppRoutes.login)),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),

      // Drawer for extra navigation
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Business User"),
              accountEmail: const Text("business@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(AppConst.mockAvatar),
              ),
              decoration: const BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Clients"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {},
            ),
            //_QuickAction(
            //  icon: Icons.person_outline,
            //  label: "Profile & Settings",
            //  onTap: () => Navigator.pushNamed(context, AppRoutes.profileSettings),
            //),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text("Profile & Settings"),
              onTap: () => Navigator.pushNamed(context, AppRoutes.profileSettings),
            ),

          ],
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Dashboard Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _StatCard(title: "Products", value: "24", icon: Icons.chair),
              _StatCard(title: "Requests", value: "8", icon: Icons.handshake),
              _StatCard(title: "Reviews", value: "12", icon: Icons.reviews),
            ],
          ),
          const SizedBox(height: 16),

          // Hero Cards
          const _HeroCard(
            title: 'Upload Furniture',
            subtitle: 'Add name, category, price, image, specs (coming next phase).',
            icon: Icons.cloud_upload_outlined,
          ),
          const _HeroCard(
            title: 'Your Products',
            subtitle: 'Manage the catalog visible to Clients & Designers.',
            icon: Icons.inventory_2_outlined,
          ),
          const _HeroCard(
            title: 'Requests & Matching',
            subtitle: 'View client/designer requests and respond with suitable furniture.',
            icon: Icons.handshake_outlined,
          ),
          const _HeroCard(
            title: 'Analytics',
            subtitle: 'Track sales, requests, and client activity in one place.',
            icon: Icons.analytics_outlined,
          ),
        ],
      ),

      // Quick Add Furniture button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.productList),
        icon: const Icon(Icons.add),
        label: const Text("Add Furniture"),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  const _HeroCard({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, AppRoutes.productList),
      ),
    );
  }
}

// Small card for dashboard stats
class _StatCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.blue.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Icon(icon, size: 28, color: Colors.blue),
              const SizedBox(height: 6),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              Text(title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
