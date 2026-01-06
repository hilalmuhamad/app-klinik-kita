// screens/splash_screen.dart
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed to white background like in the image
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Container - Updated to match the stethoscope design
            // Show logo.png as icon above the stethoscope
            Image.asset(
              'assets/images/logo.png',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10),
            
            // Subtitle - Removed as it's not in the image
            // Text(
            //   'Solusi Kesehatan Digital',
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.white.withOpacity(0.8),
            //   ),
            // ),
            SizedBox(height: 80),
            
            // Start Button - Updated styling
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 63, 0, 117), // Purple background
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
              ),
              child: Text(
                'Mulai',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Login Link - Updated color
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Sudah punya akun? Login',
                style: TextStyle(
                  color: Color.fromARGB(255, 19, 15, 22), // Purple color
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for stethoscope icon to match the design
class StethoscopePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFF6C5CE7) // Blue color for stethoscope
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint fillPaint = Paint()
      ..color = Color(0xFF6C5CE7)
      ..style = PaintingStyle.fill;

    // Draw stethoscope earpieces
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 4, fillPaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 4, fillPaint);

    // Draw stethoscope tubes
    Path leftTube = Path();
    leftTube.moveTo(size.width * 0.2, size.height * 0.2);
    leftTube.quadraticBezierTo(
      size.width * 0.3, size.height * 0.4,
      size.width * 0.5, size.height * 0.6
    );
    canvas.drawPath(leftTube, paint);

    Path rightTube = Path();
    rightTube.moveTo(size.width * 0.8, size.height * 0.2);
    rightTube.quadraticBezierTo(
      size.width * 0.7, size.height * 0.4,
      size.width * 0.5, size.height * 0.6
    );
    canvas.drawPath(rightTube, paint);

    // Draw chest piece
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.75), 8, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.75), 5, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}