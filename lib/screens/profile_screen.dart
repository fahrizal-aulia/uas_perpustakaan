import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart'; // Sesuaikan dengan lokasi AuthProvider Anda

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          authProvider.isLoggedIn
              ? IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    authProvider.logout();
                  },
                )
              : Container(),
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
        Text(
            'Name: ${authProvider.name}'), // Ganti dengan nama field yang sesuai
        Text(
            'Username: ${authProvider.username}'), // Ganti dengan nama field yang sesuai
        Text('Email: ${authProvider.email}'),
        Text(
            'Alamat: ${authProvider.alamat}'), // Ganti dengan nama field yang sesuai
        if (authProvider.emailVerifiedAt != null)
          Text(
              'Email Verified At: ${authProvider.emailVerifiedAt!.toString()}'),
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
