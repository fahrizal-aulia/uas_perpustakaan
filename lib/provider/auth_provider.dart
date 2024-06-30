import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: authProvider.isLoggedIn
            ? _buildProfile(authProvider.email)
            : _buildLoginButton(context),
      ),
    );
  }

  Widget _buildProfile(String email) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Email: $email'),
        // Tambahkan informasi lain seperti name, username, alamat jika sudah ada datanya
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
            context, '/login'); // Ganti dengan rute login yang sesuai
      },
      child: Text('Login'),
    );
  }
}
