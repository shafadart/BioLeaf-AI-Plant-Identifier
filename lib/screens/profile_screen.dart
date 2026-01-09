import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // হালকা ছাই ব্যাকগ্রাউন্ড
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🌿 টপ হেডার সেকশন (কার্ভ ডিজাইন)
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B5E20), Color(0xFF4CAF50)], // গ্রিন গ্রেডিয়েন্ট
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                // প্রোফাইল ছবি এবং নাম
                const Positioned(
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/300?img=11'), // ফেইক ইন্টারনেট ছবি
                      // ইন্টারনেট না থাকলে আইকন দেখাবে (নিচে কমেন্ট আউট করা আছে)
                      // child: Icon(Icons.person, size: 60, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60), // ছবির জন্য ফাঁকা জায়গা

            // 👤 নাম এবং টাইটেল
            const Text(
              "Shafaur Rahman",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const Text(
              "Senior Botanist | ID: #88290",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            // 📊 স্ট্যাটাস কার্ড (Stat Row)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard("128", "Plants Scanned"),
                  _buildStatCard("45", "My Garden"),
                  _buildStatCard("Pro", "Membership"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ⚙️ মেনু লিস্ট (Menu Items)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuTile(Icons.local_florist, "My Garden Collection", true),
                  _buildMenuTile(Icons.history, "Scan History", false),
                  _buildMenuTile(Icons.notifications_active, "Notifications", false),
                  _buildMenuTile(Icons.settings, "Settings", false),
                  _buildMenuTile(Icons.help_outline, "Help & Support", false),

                  const SizedBox(height: 20),

                  // লগআউট বাটন
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text("Log Out"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 🛠️ ছোট ছোট উইজেট মেথড (কোড ক্লিন রাখার জন্য)

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10, spreadRadius: 2)
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String title, bool isHighlighted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade100, blurRadius: 5, spreadRadius: 1)
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isHighlighted ? Colors.green.shade50 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isHighlighted ? const Color(0xFF2E7D32) : Colors.grey,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}