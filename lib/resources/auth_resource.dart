import 'dart:typed_data';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:specialinstagram/models/user.dart';
import 'package:specialinstagram/resources/storage.dart';

class AuthResource {
 final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<String> signUpUser({
  required String email,
  required String password,
  required String bio,
  required String userName,
  Uint8List? file
 }) async{
     String res = "some error accured";
    try{
        if (email.isNotEmpty || password.isNotEmpty ||bio.isNotEmpty ||userName.isNotEmpty || file != null){
          
          UserCredential userCred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          print(userCred.user!.uid); // will get the userID

          String photoUrl = await StorageMethod().uploadImage('profilePics', file!, false);

           UserData user = UserData(
            userName: userName,
            email:  email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl
           );

          _firestore.collection('users').doc(userCred.user!.uid).set(user.toJson());

          // _firestore.collection('users').add({
          //   'username': userName,
          //   'email': email,
          //   'bio': bio,
          //   'followers': [],
          //   'following': []
          // });

          res = "success";
           
        }
    }catch(err){
        res = err.toString();
    }

    return res;
 }


 Future<String> signIn ({
  required String email,
  required String password
 }) async{
      String res = "Some error accured";
        try{
          if (email.isNotEmpty  && password.isNotEmpty ){
          UserCredential userCredential = await  _auth.signInWithEmailAndPassword(email: email, password: password);
              res = "success"; 
        }
        }catch(e){
             print(e.toString());
             res = "error";
        }

  return res;
 }


}