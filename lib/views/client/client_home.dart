import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_routes.dart';
import '../../core/constants.dart';
import '../../services/auth_service.dart';

class ClientHome extends StatelessWidget {
  const ClientHome({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Client – Dashboard'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.productList),
            icon: const Icon(Icons.chair_alt),
            tooltip: 'Browse Products',
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
          /// Welcome Header
          Text(
            "Welcome back, Client 👋",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Plan your dream interior with our designers and businesses!",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),

          /// Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: "Search products, rooms, or requirements...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
          const SizedBox(height: 20),

          /// Quick Stats Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _QuickStat(icon: Icons.request_page, label: "Requests", count: 3),
              _QuickStat(icon: Icons.favorite, label: "Favorites", count: 8),
              _QuickStat(icon: Icons.update, label: "Updates", count: 2),
            ],
          ),
          const SizedBox(height: 20),

          /// Dashboard Cards
          GridView.count(
            crossAxisCount: width < 700 ? 1 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            childAspectRatio: 16 / 5,
            children: const [
              _DashCard(
                title: 'Area Details',
                subtitle: 'Enter room type, size, special needs.',
                icon: Icons.apartment_outlined,
              ),
              _DashCard(
                title: 'Send Requirements',
                subtitle: 'Share your preferences with your Interior Designer.',
                icon: Icons.send_outlined,
              ),
              _DashCard(
                title: 'Suggestions',
                subtitle: 'View furniture suggestions from your Designer & Business.',
                icon: Icons.star_outline,
              ),
              _DashCard(
                title: 'Timeline & Updates',
                subtitle: 'Track progress, images & notes. Approve with OTP.',
                icon: Icons.timeline_outlined,
              ),

            ],
          ),
        ],
      ),
    );
  }
}

/// Quick Stats Widget
class _QuickStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;

  const _QuickStat({
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, size: 28, color: Colors.blueAccent),
              const SizedBox(height: 8),
              Text(
                "$count",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dashboard Card Widget
class _DashCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  const _DashCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, size: 24, color: Colors.blue),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, AppRoutes.productList),
      ),
    );
  }
}
