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
  int? currentRun;

  void _playBall() {
    if (balls > 0) {
      setState(() {
        currentRun = Random().nextInt(7);
        totalRuns += currentRun!;
        balls--;
      });
    }
  }

  void _restartGame() {
    setState(() {
      balls = 6;
      totalRuns = 0;
      currentRun = null;
    });
  }

  String _getRunMessage() {
    if (currentRun == null) return '';
    if (currentRun == 0) return 'No Runs';
    if (currentRun == 1) return '1 Run';
    return '$currentRun Runs';
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
        // Main Column referencing the extracted methods
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImageRow(),          // Image -> Row(I1, I2)
            const SizedBox(height: 30),
            
            _buildLabelRow(),          // Text -> Row(T1, T2)
            const SizedBox(height: 10),
            
            _buildValueRow(),          // Value -> Row(V1, V2)
            const SizedBox(height: 30),
            
            _buildMessageText(),       // R & L -> Text()
            const SizedBox(height: 20),
            
            _buildActionButton(),      // Button -> if ter
          ],
        ),
      ),
    );
  }

  // 1. Image -> Row(I1, I2)
  Widget _buildImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildImageContainer('assets/bat.png'),
        _buildImageContainer('assets/ball.png'),
      ],
    );
  }

  // 2. Text -> Row(T1, T2)
  Widget _buildLabelRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Runs', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text('Balls', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // 3. Value -> Row(V1, V2)
  Widget _buildValueRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('$totalRuns', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
        Text('$balls', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // 4. Message -> Text()
  Widget _buildMessageText() {
    return Text(
      _getRunMessage(),
      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  // 5. Button -> if ter (Ternary logic for Bat/Restart)
  Widget _buildActionButton() {
    return balls > 0
        ? ElevatedButton(
            onPressed: _playBall,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0053A3),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text('Bat', style: TextStyle(fontSize: 18, color: Colors.white)),
          )
        : ElevatedButton(
            onPressed: _restartGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text('Restart', style: TextStyle(fontSize: 18, color: Colors.white)),
          );
  }

  // Helper widget for the image squares
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