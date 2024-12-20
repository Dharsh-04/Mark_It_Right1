import 'package:flutter/material.dart';
import 'scoreboard.dart';  // Import the ScoreboardScreen
import 'home.dart';

class GameOverScreen extends StatelessWidget {
  final String playerName;
  final int score;

  GameOverScreen({required this.playerName, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Over'),
       backgroundColor: const Color.fromARGB(255, 177, 177, 177),
      ),
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Your Score: $score',
              style: TextStyle(fontSize: 24,color: Colors.white),
              textAlign: TextAlign.center,
              
            ),
            SizedBox(height: 40),
            if (score >= 30) ...[
              Text(
                'You Won!',
                style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to ScoreboardScreen with the current score
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScoreboardScreen(score: score),
                    ),
                  );
                },
                child: Text('View Scoreboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ] else ...[
              Text(
                'You Lost! Try Again.',
                style: TextStyle(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
