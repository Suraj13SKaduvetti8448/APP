import 'package:flutter/material.dart';

class BusinessClientsPage extends StatelessWidget {
  const BusinessClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Business & Client Feedback", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Business Products Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Our Products", style: Theme.of(context).textTheme.headlineSmall),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                  image: DecorationImage(
                    image: AssetImage("assets/images/furniture_$index.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Previous Works Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Previous Works", style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage("assets/images/work_$index.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Client Reviews
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Client Reviews", style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(height: 12),
            Column(
              children: List.generate(
                3,
                    (index) => Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage("assets/images/user_$index.jpg"),
                    ),
                    title: Text("Client ${index + 1}"),
                    subtitle: const Text(
                      "Wonderful service! The team delivered exactly what I imagined for my home.",
                    ),
                    trailing: const Icon(Icons.star, color: Colors.amber),
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
