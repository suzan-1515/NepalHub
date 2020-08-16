import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/services/navigation_service.dart';
import 'package:samachar_hub/stores/auth/auth_store.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Widget _buildImage(BuildContext context, AuthenticationStore store) {
    return Hero(
      tag: 'profile_pic_tag',
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).cardColor,
          image: DecorationImage(
              image: (store.user?.avatar?.isNotEmpty ?? false)
                  ? AdvancedNetworkImage(store.user.avatar, useDiskCache: true)
                  : AssetImage('assets/images/user.png'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context, AuthenticationStore store) {
    return Text(
      store.user.fullName,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthenticationStore store) {
    return IgnorePointer(
      ignoring: false,
      child: OutlineButton(
        padding: const EdgeInsets.all(8),
        onPressed: () => store.logOut().whenComplete(
            () => context.read<NavigationService>().toLoginScreen(context)),
        child: Text('Log out'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Consumer<AuthenticationStore>(
          builder: (context, store, child) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: _buildImage(context, store)),
                SizedBox(height: 16),
                Align(
                    alignment: Alignment.center,
                    child: _buildName(context, store)),
                SizedBox(height: 32),
                _buildLogoutButton(context, store),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
