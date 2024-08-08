import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              'Nombre: Cesia Matos',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Apellido: Matos',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Matrícula: 2020-10571',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Reflexión: La seguridad es nuestra prioridad y nuestro compromiso con la comunidad.',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
