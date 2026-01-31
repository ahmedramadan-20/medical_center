import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Remote data source for authentication operations.
///
/// Handles all Firebase Authentication and Firestore operations
/// related to user authentication and profile management.
abstract class AuthRemoteDataSource {
  /// Creates a new user account with email and password.
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs in an existing user with email and password.
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sends a password reset email to the specified address.
  Future<void> sendPasswordResetEmail({required String email});

  /// Sends email verification to the current user.
  Future<void> sendEmailVerification();

  /// Creates a user profile in Firestore.
  Future<void> createUserProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String bloodType,
    required String image,
  });

  /// Creates a blood type record in Firestore.
  Future<void> createBloodTypeRecord({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String bloodType,
  });
}

/// Implementation of [AuthRemoteDataSource] using Firebase.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  @override
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<void> createUserProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String bloodType,
    required String image,
  }) async {
    final usersCollection = _firestore.collection('users');
    await usersCollection.add({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'phone': phone,
      'gender': gender,
      'bloodType': bloodType,
      'isAdmin': false,
    });
  }

  @override
  Future<void> createBloodTypeRecord({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String bloodType,
  }) async {
    final bloodTypesCollection = _firestore.collection('bloodTypes');
    await bloodTypesCollection.add({
      'firstName': firstName,
      'lastName': lastName,
      'bloodType': bloodType,
      'phone': phone,
      'gender': gender,
      'email': email,
    });
  }
}
