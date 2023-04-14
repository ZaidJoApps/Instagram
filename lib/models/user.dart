import 'package:flutter/material.dart';

class UserData{
    final String userName;
    final String email;
    final String bio;
    final List   followers;
    final List   following;
    final String photoUrl;


    UserData({
      required this.userName,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following,
      required this.photoUrl
    });


    Map<String , dynamic> toJson() => {
      "userName" : userName,
      "email"    : email,
      "bio"      : bio,
      "followers": followers,
      "following": following,
      "photoUrl" : photoUrl
    };

}