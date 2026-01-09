import 'dart:io';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String imagePath;
  final String result; // AI এর উত্তর এখানে আসবে

  const ResultScreen({super.key, required this.imagePath, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ১. উপরের দিকে বড় করে ছবিটা দেখাবে
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Plant Details",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black, blurRadius: 10)])
              ),
              background: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ২. নিচের দিকে AI এর লেখাগুলো দেখাবে
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        "AI Analysis",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10),

                  // AI এর পুরো টেক্সটটা এখানে প্রিন্ট হবে
                  Text(
                    result,
                    style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
                  ),

                  const SizedBox(height: 30),

                  // হোম বাটন
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // একদম প্রথম পেজে ফিরে যাবে
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Scan Another Plant"),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}