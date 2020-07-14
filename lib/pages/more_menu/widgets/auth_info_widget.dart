import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/services/navigation_service.dart';
import 'package:samachar_hub/stores/stores.dart';

class AuthInfo extends StatefulWidget {
  @override
  _AuthInfoState createState() => _AuthInfoState();
}

class _AuthInfoState extends State<AuthInfo> {
  Widget _buildUserInfo(BuildContext context, AuthenticationStore authStore) {
    return InkWell(
      onTap: () {
        context.read<NavigationService>().toUserProfileScreen(context: context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).cardColor,
              image: (authStore.user?.avatar?.isNotEmpty ?? false)
                  ? DecorationImage(
                      image: CachedNetworkImageProvider(
                        authStore.user.avatar,
                        errorListener: () {},
                      ),
                      fit: BoxFit.cover)
                  : Image.asset('assets/images/user.png'),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Flexible(
            child: Text(
              authStore.user.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSigninButtons(
      BuildContext context, AuthenticationStore authStore) {
    return Observer(
      builder: (_) {
        return IgnorePointer(
          ignoring: authStore.isLoading,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  // authStore.signInWithGoogle();
                },
                color: Color(0xFF3B5999),
                textColor: Colors.white,
                child: Icon(
                  FontAwesomeIcons.facebookF,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              SizedBox(
                width: 16,
              ),
              MaterialButton(
                onPressed: () {
                  authStore.signInWithGoogle();
                },
                color: Colors.redAccent[200],
                textColor: Colors.white,
                child: Icon(
                  FontAwesomeIcons.googlePlusG,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<AuthenticationStore>(
        builder: (_, AuthenticationStore authStore, Widget child) {
          return Observer(
            builder: (_) {
              if (authStore.isLoggedIn) {
                return _buildUserInfo(context, authStore);
              }
              return _buildSigninButtons(context, authStore);
            },
          );
        },
      ),
    );
  }
}
