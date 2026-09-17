import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MiniCricketApp());
}

class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Cricket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CricketGameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CricketGameScreen extends StatefulWidget {
  const CricketGameScreen({super.key});

  @override
  State<CricketGameScreen> createState() => _CricketGameScreenState();
}

class _CricketGameScreenState extends State<CricketGameScreen> {
  int balls = 6;
  int totalRuns = 0;
  int currentRun = 0; // Starts at 0

  void _playBall() {
    if (balls > 0) {
      setState(() {
        // 1. Generate the random run for THIS ball (0 to 6)
        currentRun = Random().nextInt(7);
        // 2. Add it to the accumulated total
        totalRuns += currentRun;
        // 3. Reduce the ball count
        balls--;
      });
    }
  }

  void _restartGame() {
    setState(() {
      balls = 6;
      totalRuns = 0;
      currentRun = 0;
    });
  }

  // Shows the accumulated total in the middle section
  String _getTotalMessage() {
    if (balls == 6 && totalRuns == 0) return ''; // Empty before first click
    return 'Total: $totalRuns Runs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0077D6),
      appBar: AppBar(
        title: const Text('Mini Cricket'),
        backgroundColor: const Color(0xFF004B93),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImageRow(),
            const SizedBox(height: 30),
            
            _buildLabelRow(),
            const SizedBox(height: 10),
            
            _buildValueRow(),
            const SizedBox(height: 40),
            
            _buildMessageText(), 
            const SizedBox(height: 15),
            
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildImageContainer('assets/bat.png'),
        _buildImageContainer('assets/ball.png'),
      ],
    );
  }

  Widget _buildLabelRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Runs', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text('Balls', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildValueRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Displays the random run for the CURRENT ball
        Text('$currentRun', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
        Text('$balls', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMessageText() {
    return SizedBox(
      height: 25,
      child: Text(
        _getTotalMessage(), // Displays the running total
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActionButton() {
    return balls > 0
        ? ElevatedButton(
            onPressed: _playBall,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0053A3),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text('Bat', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          )
        : ElevatedButton(
            onPressed: _restartGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text('Restart', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
      ),
    );
  }
}