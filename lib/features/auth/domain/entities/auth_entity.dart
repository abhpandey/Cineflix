import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable{
  final String? authId;
  final String fullName;
  final String username;
  final String email;
  final String? password;
  final String? profilePicture;
  

  const AuthEntity({
    this.authId,
    required this.fullName,
    required this.email,
    required this. username,
    this.password,
    this.profilePicture,
  });

  @override
  List<Object?> get props =>[
    authId,
    fullName,
    email,
    password,
    profilePicture,
    ];
  }