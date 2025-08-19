import 'package:flutter/material.dart';

class DesignersPage extends StatelessWidget {
  const DesignersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connected Interior Designers", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Intro Banner
            Container(
              height: 180,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/designers_banner.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  "Meet Our Interior Designers",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Designers List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Top Designers", style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(height: 12),
            Column(
              children: List.generate(
                4,
                    (index) => Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage("assets/images/designer_$index.jpg"),
                    ),
                    title: Text("Designer ${index + 1}"),
                    subtitle: const Text("Specialized in modern interiors & space optimization."),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Their Works Gallery
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Design Works", style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage("assets/images/work_$index.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
