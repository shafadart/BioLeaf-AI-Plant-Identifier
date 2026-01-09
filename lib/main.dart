import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // ক্যামেরার প্যাকেজ
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

// গ্লোবাল ভেরিয়েবল: যাতে অ্যাপের যেকোনো জায়গা থেকে ক্যামেরা পাওয়া যায়
late List<CameraDescription> cameras;

Future<void> main() async {
  // ১. অ্যাপ চালু হওয়ার আগে সব রেডি করছি
  WidgetsFlutterBinding.ensureInitialized();

  // ২. মোবাইলের ক্যামেরাগুলো খুঁজে বের করছি
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  runApp(const BioLeafApp());
}

class BioLeafApp extends StatelessWidget {
  const BioLeafApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BioLeaf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(),
    );
  }
}