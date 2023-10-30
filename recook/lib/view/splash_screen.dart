import 'package:flutter/material.dart';
import 'package:recook/view/home_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Recook',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 36.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Masak mudah tinggal recook aja!',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashScreenDelay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2), () => true), // Menunggu selama 2 detik
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Pindah ke halaman utama setelah penundaan 2 detik
          return HomePage();
        } else {
          // Menampilkan splash screen selama penundaan
          return SplashScreen();
        }
      },
    );
  }
}
