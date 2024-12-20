import 'package:flutter/material.dart';
import 'game_over_screen.dart'; // Import the GameOverScreen
import 'package:audioplayers/audioplayers.dart'; 

class Product {
  final String imageUrl;
  final bool isCertified;
  final String description;

  Product({
    required this.imageUrl,
    required this.isCertified,
    required this.description,
  });
}

class GameScreen extends StatefulWidget {
  final String playerName;
  final Function(int) onGameOver;

  // GameScreen constructor with the onGameOver parameter
  GameScreen({required this.playerName, required this.onGameOver});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int currentIndex = 0;
  int score = 0;
  bool isAnswerButtonDisabled = false;

  // Sample product data
List<Product> products = [
  Product(
    imageUrl: 'assets/lap.jpg',
    isCertified: true,
    description: 'This product adheres to specific quality standards and carries the ISI mark for assurance.',
  ),
  Product(
    imageUrl: 'assets/oven.jpg',
    isCertified: true,
    description: 'Designed to meet safety and performance benchmarks, it holds a recognized certification.',
  ),
  Product(
    imageUrl: 'assets/scanner.jpg',
    isCertified: true,
    description: 'Manufactured under stringent guidelines and labeled with the ISI mark.',
  ),
  Product(
    imageUrl: 'assets/keyboard.jpeg',
    isCertified: true,
    description: 'Certified to ensure reliability and compliance with established standards.',
  ),
  Product(
    imageUrl: 'assets/cement.jpeg',
    isCertified: true,
    description: 'Quality-tested and marked to conform to Indian standards for durability.',
  ),
  Product(
    imageUrl: 'assets/ups.jpg',
    isCertified: true,
    description: 'Built to meet safety norms and labeled with certification for dependability.',
  ),
  Product(
    imageUrl: 'assets/settop.jpeg',
    isCertified: true,
    description: 'Ensures compliance with performance standards, featuring an ISI mark.',
  ),
  Product(
    imageUrl: 'assets/smartwatch.jpeg',
    isCertified: true,
    description: 'Developed with regulated benchmarks and holds a valid certification.',
  ),
  Product(
    imageUrl: 'assets/inductionstove.jpg',
    isCertified: true,
    description: 'Meets prescribed quality and safety standards with proper labeling.',
  ),
  Product(
    imageUrl: 'assets/icecooker.jpg',
    isCertified: true,
    description: 'Certified for performance and safety, featuring an assurance mark.',
  ),
  Product(
    imageUrl: 'assets/ac.jpeg',
    isCertified: true,
    description: 'Adheres to stringent performance and safety norms with certification.',
  ),
  Product(
    imageUrl: 'assets/helmet.jpeg',
    isCertified: true,
    description: 'Designed for safety, meeting standards and labeled with the ISI mark.',
  ),
  Product(
    imageUrl: 'assets/milk (1).jpeg',
    isCertified: true,
    description: 'Packaged under specific quality norms, ensuring it meets certified standards.',
  ),
  Product(
    imageUrl: 'assets/led.jpeg',
    isCertified: true,
    description: 'Tested for energy efficiency and marked for compliance with quality standards.',
  ),
  Product(
    imageUrl: 'assets/painting.jpg',
    isCertified: false,
    description: 'A handcrafted product without specific compliance requirements.',
  ),
  Product(
    imageUrl: 'assets/pottery.jpeg',
    isCertified: false,
    description: 'A decorative item made through artisanal methods, unregulated by standards.',
  ),
  Product(
    imageUrl: 'assets/fuits.jpeg',
    isCertified: false,
    description: 'Naturally grown and sold fresh, without mandatory certifications.',
  ),
  Product(
    imageUrl: 'assets/rawspices.jpeg',
    isCertified: false,
    description: 'Typically unprocessed and sold without standardized benchmarks.',
  ),
  Product(
    imageUrl: 'assets/grains.jpeg',
    isCertified: false,
    description: 'Essential staples, usually sold in bulk without certification requirements.',
  ),
  Product(
    imageUrl: 'assets/bakery.jpg',
    isCertified: false,
    description: 'Freshly made consumables, not regulated under certification norms.',
  ),
  Product(
    imageUrl: 'assets/iron.jpeg',
    isCertified: false,
    description: 'A raw material used industrially, often unmarked by specific certifications.',
  ),
  Product(
    imageUrl: 'assets/curtain.jpg',
    isCertified: false,
    description: 'A home furnishing item, not regulated by any certification body.',
  ),
  Product(
    imageUrl: 'assets/dairy.jpg',
    isCertified: false,
    description: 'Perishable goods, sold fresh and not always under certification.',
  ),
  Product(
    imageUrl: 'assets/toys.jpg',
    isCertified: false,
    description: 'General play items, often unmarked unless for safety-critical versions.',
  ),
];






  List<Product> randomProducts = [];

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Shuffle the products list and select the first 5 items
    products.shuffle(); // Shuffle the list
    randomProducts = products.take(5).toList(); // Take the first 5 items
  }

  void checkAnswer(bool userAnswer) {
    if (isAnswerButtonDisabled) return;

    setState(() {
      isAnswerButtonDisabled = true;
    });

    if (userAnswer == randomProducts[currentIndex].isCertified) {
      setState(() {
        score += 10; // Increase score for correct answer
      });
      _playAudio('correct_answer.mp3');
      _showCorrectAnswerDialog();
    } else {
      _playAudio('incorrect_answer.mp3');
      _showIncorrectAnswerDialog();
    }
  }

  void _playAudio(String path) async {
    await _audioPlayer.play(AssetSource(path)); // Play the audio
  }

  void _showCorrectAnswerDialog() {
    if (currentIndex == randomProducts.length - 1) {
      // Navigate to GameOverScreen if it's the last product
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameOverScreen(
            playerName: widget.playerName,
            score: score,
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/correct.jpg', // Add a suitable image for correct answers
              height: 100,
              width: 100,
            ),
            SizedBox(height: 10),
            Text(
              'Correct Answer!',
              style: TextStyle(
                color: Colors.green[900],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              randomProducts[currentIndex].description,
              style: TextStyle(color: Colors.green[900]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                currentIndex++;
                isAnswerButtonDisabled = false;
              });
              Navigator.of(context).pop();
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  void _showIncorrectAnswerDialog() {
    if (currentIndex == randomProducts.length - 1) {
      // Navigate to GameOverScreen if it's the last product
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameOverScreen(
            playerName: widget.playerName,
            score: score,
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/incorrect.jpeg', // Add a suitable image for incorrect answers
              height: 100,
              width: 100,
            ),
            SizedBox(height: 10),
            Text(
              'Incorrect Answer!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              randomProducts[currentIndex].description,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _playAudio('next_button_click.mp3');
              setState(() {
                currentIndex++;
                isAnswerButtonDisabled = false;
              });
              Navigator.of(context).pop();
            },
            child: Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome !! ${widget.playerName}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Black text
        ),
        backgroundColor: const Color.fromARGB(255, 177, 177, 177), // Light grey color for AppBar
      ),
      body: Container(
        color: Colors.grey[850], // Dark grey background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display product image
            Image.asset(
              products[currentIndex].imageUrl,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 10),

            // Display product description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                randomProducts[currentIndex].description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white), // White text for description
              ),
            ),
            SizedBox(height: 20),

            // Buttons to choose Certified or Not Certified
            ElevatedButton(
              onPressed: isAnswerButtonDisabled ? null : () => checkAnswer(true),
              child: Text(
                'Certified',
                style: TextStyle(color: Colors.black), // Black text inside the button
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300], // Light grey background for the button
                minimumSize: Size(200, 50),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isAnswerButtonDisabled ? null : () => checkAnswer(false),
              child: Text(
                'Not Certified',
                style: TextStyle(color: Colors.black), // Black text inside the button
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300], // Light grey background for the button
                minimumSize: Size(200, 50),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


  