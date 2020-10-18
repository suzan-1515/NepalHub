import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Widget _buildImage(BuildContext context, UserEntity user) {
    return Hero(
      tag: 'profile_pic_tag',
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).cardColor,
          image: DecorationImage(
              image: (user?.avatar?.isNotEmpty ?? false)
                  ? AdvancedNetworkImage(user.avatar, useDiskCache: true)
                  : AssetImage('assets/images/user.png'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context, UserEntity user) {
    return Text(
      user.fullname,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  Widget _buildLogoutButton(BuildContext context, UserEntity user) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.repository<NavigationService>().toLoginScreen(context);
        }
      },
      child: IgnorePointer(
        ignoring: false,
        child: OutlineButton(
          padding: const EdgeInsets.all(8),
          onPressed: () => context.bloc<AuthBloc>().add(LogoutEvent()),
          child: Text('Log out'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthBloc>().currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: _buildImage(context, user),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: _buildName(context, user),
              ),
              SizedBox(height: 32),
              _buildLogoutButton(context, user),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
