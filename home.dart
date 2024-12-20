import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'rulespage.dart';
import 'game_screen.dart'; // Import the game_screen.dart file
import 'scoreboard.dart'; // Import the scoreboard.dart file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mark It Right Game',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int finalScore = 0; // Variable to hold the current score
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playAudio(String path) async {
    await _audioPlayer.play(AssetSource(path));
  }

  void _startGame(BuildContext context) {
    _playAudio('next_button_click.mp3');
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          playerName: '',
          onGameOver: (score) {
            setState(() {
              finalScore = score;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark It Right'),
        backgroundColor:  const Color.fromARGB(255, 177, 177, 177),// Light grey color for app bar
      ),
      backgroundColor: Color(0xFF2F2F2F), // Dark grey background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animated Title Text
            SizedBox(
              height: 100,
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    'Mark It Right!',
                    textStyle: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 228, 93, 93),
                    ),
                    duration: const Duration(milliseconds: 2000),
                  ),
                  RotateAnimatedText(
                    'Ready to Play?',
                    textStyle: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                    duration: const Duration(milliseconds: 2000),
                  ),
                  TypewriterAnimatedText(
                    'Let\'s Begin!',
                    textStyle: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: true,
                pause: const Duration(milliseconds: 500),
              ),
            ),
            SizedBox(height: 40),

            // Start button
            ElevatedButton(
              onPressed: () => _startGame(context),
              child: Text('Start'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Color(0xFFD3D3D3), // Light grey button color
                textStyle: TextStyle(fontSize: 18, color: Colors.black),
                foregroundColor:  Colors.black, // Dark text color
              ),
            ),

            SizedBox(height: 20),

            // Rules button
            ElevatedButton(
              onPressed: () {
                _playAudio('next_button_click.mp3');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RulesPage()),
                );
              },
              child: Text('Rules'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Color(0xFFD3D3D3), // Light grey button color
                textStyle: TextStyle(fontSize: 18, color: Colors.black),
                foregroundColor:  Colors.black,
              ),
            ),

            SizedBox(height: 20),

            // Scoreboard button
            ElevatedButton(
              onPressed: () {
                _playAudio('next_button_click.mp3');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScoreboardScreen(score: finalScore),
                  ),
                );
              },
              child: Text('Scoreboard'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Color(0xFFD3D3D3), // Light grey button color
                textStyle: TextStyle(fontSize: 18, color: Colors.black),
                foregroundColor:  Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
