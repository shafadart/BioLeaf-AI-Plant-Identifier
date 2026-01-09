import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

class PlantService {
  // 👇 পোর্টফোলিওর জন্য এটা 'true' রাখো
  static const bool _useDemoMode = true;
  static const String _apiKey = "YOUR_REAL_API_KEY_HERE";

  Future<String> identifyPlant(String imagePath) async {
    if (_useDemoMode) {
      return await _getDemoResponse();
    }
    return await _getRealAIResponse(imagePath);
  }

  // 🎭 বিস্তারিত ডেমো বা ফেইক রেসপন্স
  Future<String> _getDemoResponse() async {
    await Future.delayed(const Duration(seconds: 2)); // ২ সেকেন্ড লোডিং

    final List<String> fakeResults = [
      // 🌱 রেজাল্ট ১: অ্যালোভেরা
      """
🌿 **Name:** Aloe Vera (Aloe barbadensis miller)

🚑 **Benefits:**
• Known as the 'Plant of Immortality'.
• Gel is excellent for treating sunburns, acne, and dry skin.
• Juice improves digestion and boosts immunity.

🏡 **Vastu:**
• Best placed in the **North or East** direction.
• Believed to ward off negative energy and bring positivity.

💧 **Care:**
• **Water:** Low. Water only when soil is dry (every 2-3 weeks).
• **Light:** Bright, indirect sunlight.

⚠️ **Warning:**
• Safe for humans but **mildly toxic to cats and dogs** if ingested.
      """,

      // 🌱 রেজাল্ট ২: তুলসী
      """
🌿 **Name:** Holy Basil (Ocimum tenuiflorum) - 'Tulsi'

🚑 **Benefits:**
• Queen of herbs in Ayurveda.
• Leaves cure cold, cough, and sore throat.
• Reduces stress and boosts respiratory health.

🏡 **Vastu:**
• Must be placed in the **North, North-East, or East**.
• Considered the most sacred plant, brings prosperity and health.

💧 **Care:**
• **Water:** Daily watering is needed (keep soil moist).
• **Light:** Needs full sunlight (4-6 hours).

⚠️ **Warning:**
• **100% Safe** and edible for everyone.
      """,

      // 🌱 রেজাল্ট ৩: স্নেক প্ল্যান্ট
      """
🌿 **Name:** Snake Plant (Dracaena trifasciata)

🚑 **Benefits:**
• One of the best **Air Purifying Plants** (NASA approved).
• Releases oxygen at night, great for bedrooms.
• Filters out toxins like formaldehyde and benzene.

🏡 **Vastu:**
• Best placed in **South or East** corners.
• Keeps negative vibes away and reduces stress.

💧 **Care:**
• **Water:** Very low. Can survive weeks without water.
• **Light:** Thrives in both low light and bright light.

⚠️ **Warning:**
• **Toxic to pets** (causes nausea if eaten). Keep away from dogs/cats.
      """
    ];

    // যেকোনো একটা র‍্যান্ডমলি রিটার্ন করবে
    return fakeResults[Random().nextInt(fakeResults.length)];
  }

  // 🧠 আসল AI রেসপন্স (API Key থাকলে এটা কাজ করবে)
  Future<String> _getRealAIResponse(String imagePath) async {
    try {
      final imageFile = File(imagePath);
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      // আমরা 1.5-flash ব্যবহার করছি (ফ্রি এবং ফাস্ট)
      final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey');

      final body = jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": "Identify this plant clearly. Act as a Botanist, Ayurveda Doctor, and Vastu Expert.\n\n"
                    "Provide output in this format (Use Emoji):\n"
                    "🌿 **Name:** [Name] ([Scientific Name])\n"
                    "🚑 **Benefits:** [List medicinal benefits]\n"
                    "🏡 **Vastu:** [Placement & Beliefs]\n"
                    "💧 **Care:** [Water/Light needs]\n"
                    "⚠️ **Warning:** [Toxic/Safe]"
              },
              {
                "inline_data": {
                  "mime_type": "image/jpeg",
                  "data": base64Image
                }
              }
            ]
          }
        ]
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['candidates'] != null && jsonResponse['candidates'].isNotEmpty) {
          return jsonResponse['candidates'][0]['content']['parts'][0]['text'];
        }
        return "AI gave empty response.";
      }
      return "Error: ${response.statusCode}";
    } catch (e) {
      return "Connection Error: $e";
    }
  }
}