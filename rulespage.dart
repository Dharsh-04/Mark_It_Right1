import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class RulesPage extends StatefulWidget {
  @override
  _RulesPageState createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Function to play button press sound
  void _playButtonPressSound() async {
    try {
      await _audioPlayer.play(AssetSource('next_button_click.mp3'));
    } catch (e) {
      print("Error playing audio: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error playing sound")),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();  // Clean up the audio player when the screen is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Game Rules',
          style: TextStyle(
            color: Colors.black, // Black color for text
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 177, 177, 177), // Light grey background for AppBar
      ),
      backgroundColor: Colors.grey[850], // Dark grey background for the page
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/rules.jpg', // Replace with the path to your image
              height: 200,
              width: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Gameplay:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White color for the text
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• You’ll see a product Image with Description. Decide if it’s Certified (BIS certified) or Not Certified.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // White color for the text
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Scoring:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White color for the text
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Correct answer = 10 points.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // White color for the text
              ),
            ),
            Text(
              '• Incorrect answer = No points',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // White color for the text
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _playButtonPressSound();
                Navigator.pop(context); // Go back to the home screen
              },
              child: Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300], // Light grey background for button
                foregroundColor: Colors.black, // Black color for text inside button
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
