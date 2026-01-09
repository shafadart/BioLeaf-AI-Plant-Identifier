import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // গ্যালারির জন্য এই প্যাকেজ লাগবে
import 'preview_screen.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  // ফ্ল্যাশ লাইট অন/অফ করার জন্য ভেরিয়েবল (এক্সট্রা ফিচার 😉)
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false, // শাটার সাউন্ড বন্ধ বা কমানোর জন্য
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🖼️ গ্যালারি থেকে ছবি নেওয়ার ফাংশন
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // ছবি সিলেক্ট করলে প্রিভিউ পেজে নিয়ে যাও
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(imagePath: image.path),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                // ১. ক্যামেরা প্রিভিউ
                Center(child: CameraPreview(_controller)),

                // ২. উপরের বার (ব্যাক বাটন + ফ্ল্যাশ)
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ব্যাক বাটন (গোল এবং স্বচ্ছ)
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      // ফ্ল্যাশ বাটন (বোনাস)
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: Icon(
                              _isFlashOn ? Icons.flash_on : Icons.flash_off,
                              color: _isFlashOn ? Colors.yellow : Colors.white
                          ),
                          onPressed: () {
                            setState(() {
                              _isFlashOn = !_isFlashOn;
                              _controller.setFlashMode(
                                  _isFlashOn ? FlashMode.torch : FlashMode.off
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // ৩. নিচের কন্ট্রোল প্যানেল (শাটার + গ্যালারি)
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ✨ গ্যালারি বাটন (বাম পাশে)
                      IconButton(
                        onPressed: _pickImageFromGallery,
                        icon: const Icon(Icons.photo_library, color: Colors.white, size: 30),
                        tooltip: "Pick from Gallery",
                      ),

                      // 📸 মেইন শাটার বাটন (মাঝখানে)
                      GestureDetector(
                        onTap: () async {
                          try {
                            await _initializeControllerFuture;
                            final image = await _controller.takePicture();

                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PreviewScreen(imagePath: image.path),
                              ),
                            );
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            color: Colors.transparent, // মাঝখানে ফাঁকা
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // বাটন ফিল
                            ),
                          ),
                        ),
                      ),

                      // ডান পাশে ফাঁকা স্পেস বা রোটেট বাটন রাখতে পারো (আপাতত ব্যালেন্স করার জন্য ডামি আইকন)
                      IconButton(
                        onPressed: () {}, // ফিউচারে এখানে সেলফি ক্যামেরা সুইচ দিব
                        icon: const Icon(Icons.cameraswitch, color: Colors.white, size: 30),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.green));
          }
        },
      ),
    );
  }
}