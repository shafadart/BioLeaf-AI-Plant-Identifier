import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // ক্যামেরা প্যাকেজ
import '../main.dart';               // main.dart থেকে cameras ভেরিয়েবল পাওয়ার জন্য
import 'camera_screen.dart';         // CameraScreen পেজ চেনার জন্য
import 'profile_screen.dart'; // এটা ফাইলের একদম উপরে দাও

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ডামি ডাটা (গাছের লিস্ট)
  final List<Map<String, String>> trendingPlants = [
    {
      "name": "Aloe Vera",
      "subtitle": "Healer",
      "image": "https://images.pexels.com/photos/1671650/pexels-photo-1671650.jpeg?auto=compress&cs=tinysrgb&w=200"
    },
    {
      "name": "Snake Plant",
      "subtitle": "Purifier",
      "image": "https://images.pexels.com/photos/2123482/pexels-photo-2123482.jpeg?auto=compress&cs=tinysrgb&w=200"
    },
    {
      "name": "Monstera",
      "subtitle": "Indoor King",
      "image": "https://images.pexels.com/photos/3097770/pexels-photo-3097770.jpeg?auto=compress&cs=tinysrgb&w=200"
    },
    {
      "name": "Fiddle Leaf",
      "subtitle": "Decor Love",
      "image": "https://images.pexels.com/photos/6208087/pexels-photo-6208087.jpeg?auto=compress&cs=tinysrgb&w=200"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9), // হালকা সবুজ ব্যাকগ্রাউন্ড

      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning! ☀️",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              "Discover Plants",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black87),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                // 🚀 এখানে ক্লিক করলে প্রোফাইলে নিয়ে যাবে
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                // আপাতত একটা আইকন দিচ্ছি, পরে চাইলে ইউজারের ছবি দিতে পারো
                child: Icon(Icons.person, color: Colors.green),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // বডি ব্যানার
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFDCEDC8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: const Text("Daily Tips", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green)),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Water your Cactus only when soil is dry.",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.local_florist, size: 60, color: Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 25),
            const Text(
              "Explore Collection 🔥",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 15),

            // Grid View
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: trendingPlants.length,
                itemBuilder: (context, index) {
                  final plant = trendingPlants[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              plant["image"]!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey.shade200, child: const Icon(Icons.image)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plant["name"]!,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                plant["subtitle"]!,
                                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ফ্লোটিং স্ক্যান বাটন (Fixed Logic)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 65,
        width: 180,
        child: FloatingActionButton.extended(
          onPressed: () {
            // ✅ ফিক্সড লজিক: ক্যামেরা চেক করে ওপেন করবে
            if (cameras.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(camera: cameras.first),
                ),
              );
            } else {
              print("No camera found!");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No camera found!")),
              );
            }
          },
          backgroundColor: const Color(0xFF2E7D32),
          icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
          label: const Text("Scan Plant", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}