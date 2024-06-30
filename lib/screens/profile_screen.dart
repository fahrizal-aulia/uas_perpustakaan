import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';
// import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          if (authProvider.isLoggedIn)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                authProvider.logout();
              },
            ),
        ],
      ),
      body: Center(
        child: authProvider.isLoggedIn
            ? _buildProfile(authProvider)
            : _buildLoginButton(context),
      ),
    );
  }

  Widget _buildProfile(AuthProvider authProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Name: ${authProvider.name}'),
        Text('Username: ${authProvider.username}'),
        Text('Email: ${authProvider.email}'),
        Text('Alamat: ${authProvider.alamat}'),
        if (authProvider.emailVerifiedAt != null)
          Text(
              'Email Verified At: ${authProvider.emailVerifiedAt!.toString()}'),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Text('Login'),
    );
  }
}
