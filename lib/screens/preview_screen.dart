import 'dart:io';
import 'package:flutter/material.dart';
import '../services/plant_service.dart'; // সার্ভিস ইম্পোর্ট
import 'result_screen.dart';             // রেজাল্ট পেজ ইম্পোর্ট

class PreviewScreen extends StatefulWidget {
  final String imagePath;

  const PreviewScreen({super.key, required this.imagePath});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final PlantService _plantService = PlantService(); // AI সার্ভিস রেডি
  bool _isLoading = false; // লোডিং হচ্ছে কিনা বোঝার জন্য

  // ✨ ম্যাজিক ফাংশন: AI কে কল করা
  Future<void> _identifyPlant() async {
    setState(() {
      _isLoading = true; // লোডিং শুরু
    });

    // AI কে ছবি পাঠাচ্ছি...
    final result = await _plantService.identifyPlant(widget.imagePath);

    setState(() {
      _isLoading = false; // লোডিং শেষ
    });

    // রেজাল্ট পেজে চলে যাও
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          imagePath: widget.imagePath,
          result: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ১. ব্যাকগ্রাউন্ড ছবি
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.file(
              File(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),

          // ২. লোডিং ইফেক্ট (যদি লোডিং চলে)
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.green),
                    SizedBox(height: 20),
                    Text(
                      "Thinking... 🧠",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

          // ৩. নিচের বাটন (যদি লোডিং না চলে)
          if (!_isLoading)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: _identifyPlant, // বাটন চাপলে ফাংশন কল হবে
                      icon: const Icon(Icons.auto_awesome, color: Colors.white),
                      label: const Text(
                        "Identify Plant",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Retake Photo", style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),

          // ৪. ব্যাক বাটন
          if (!_isLoading)
            Positioned(
              top: 50,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}