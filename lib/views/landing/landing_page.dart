import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 AppBar as Navbar
      appBar: AppBar(
        title: const Text("FurniTracker", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 3,
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, "/explore"),
            child: const Text("Explore", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, "/business_feedback"),
            child: const Text("Works", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, "/interior_designers"),
            child: const Text("Designers", style: TextStyle(color: Colors.black)),
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            tooltip: "Login",
            onPressed: () => Navigator.pushNamed(context, "/login"),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Hero Section
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/landing_bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                ),
                Positioned(
                  left: 20,
                  bottom: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "FurniTracker",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Find the perfect furniture for your space\nwith expert designer support.",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      PrimaryButton(
                        text: "Start Exploring",
                        onPressed: () => Navigator.pushNamed(context, "/explore"),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 🔹 Featured Section (short preview)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Designer Works",
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
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

            const SizedBox(height: 30),

            // 🔹 Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.black87,
              child: Column(
                children: const [
                  Text("© 2025 FurniTracker",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 6),
                  Text("All rights reserved.",
                      style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
