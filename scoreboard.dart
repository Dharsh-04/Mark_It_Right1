import 'package:flutter/material.dart';
import 'home.dart';
import 'package:audioplayers/audioplayers.dart';

class ScoreboardScreen extends StatefulWidget {
  final int score;

  const ScoreboardScreen({Key? key, required this.score}) : super(key: key);

  @override
  _ScoreboardScreenState createState() => _ScoreboardScreenState();
  
}
 final AudioPlayer _audioPlayer=AudioPlayer();
  // Function to play button press sound
  void _playButtonPressSound() async {
  try {
    await _audioPlayer.play(AssetSource('next_button_click.mp3'));
  } catch (e) {
    print("Error playing audio: $e");
  }
}
class _ScoreboardScreenState extends State<ScoreboardScreen> {
  static List<int> scores = []; // Static list to store all scores

  @override
  void initState() {
    super.initState();
    // Add the current score to the list only if it's greater than zero
    if (widget.score > 0) {
      scores.add(widget.score);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scoreboard'),
       backgroundColor: const Color.fromARGB(255, 177, 177, 177), 
      ),
       backgroundColor: Colors.grey[850],
      body: Column(
        children: [
          SizedBox(height: 20),
          // Image above the "Scoreboard" Title
          Image.asset(
            'assets/score.jpeg', // Replace with the path to your image
            height: 300,
            width: 400,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          // Animated Scoreboard Title
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 1),
            builder: (context, double opacity, child) {
              return Opacity(
                opacity: opacity,
                child: child,
              );
            },
            child: Text(
              'Scoreboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: scores.isEmpty
                ? Center(
                    child: Text(
                      'No scores yet!',
                      style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  )
                : ListView.builder(
                    itemCount: scores.length,
                    itemBuilder: (context, index) {
                      return TweenAnimationBuilder(
                        tween: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero),
                        duration: Duration(seconds: 1),
                        builder: (context, Offset offset, child) {
                          return SlideTransition(
                            position: AlwaysStoppedAnimation(offset), // Use AlwaysStoppedAnimation here
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                                backgroundColor: const Color.fromARGB(255, 241, 162, 87),
                              ),
                              title: Text('Score: ${scores[index]}',style: TextStyle(color: Colors.white),),
                              // Add image next to the score
                              trailing: Image.asset(
                                'assets/trophy.jpg', // Replace with your image
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _playButtonPressSound();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('Return to Home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 177, 177, 177), 
              foregroundColor: Colors.black,
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
