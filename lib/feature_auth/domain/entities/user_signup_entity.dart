import 'package:equatable/equatable.dart';

class UserSignUpEntity extends Equatable {
  final String token;
  UserSignUpEntity({
    this.token,
  });
  @override
  List<Object> get props => [token];

  UserSignUpEntity copyWith({
    String token,
  }) {
    return UserSignUpEntity(
      token: token ?? this.token,
    );
  }

  @override
  bool get stringify => true;
}
