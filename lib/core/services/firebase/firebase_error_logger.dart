import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:uuid/uuid.dart';

class FirestoreErrorLogService {
  static FirebaseApp get secondaryApp => Firebase.app('Mentra-firebase');

  // static final FirebaseDatabase _database = FirebaseDatabase.instanceFor(
  //     app: secondaryApp,
  //     databaseURL: "https://mentra-firebase-default-rtdb.firebaseio.com/");

  static final FirebaseDatabase _database = FirebaseDatabase.instance;
  static final String _errorsReference = 'errors'; // Customize if needed

  static Future<void> logError(ErrorModel error) async {
    try {
      final errorData = {
        // 'code': error.code.toString(),
        'message': error.message,
        'timestamp': DateTime.now().toIso8601String(), // Use ISO 8601 timestamp
        if (error.stackTrace != null) 'stackTrace': error.stackTrace.toString(),
        if (error.hint != null) 'hint': error.hint,
        if (error.additionalData != null)
          'additionalData': error.additionalData,
      };
      logger.w(errorData);

      final reference = _database.ref("/${const Uuid().v4()}");
      await reference.set(errorData);
      // await ref2
      logger.w(errorData);

      logger.e('Error logged to Realtime Database: ${error.message}');
    } catch (error, stack) {
      logger.e(
          'Error logging error to Realtime Database: ${error.toString()} ${stack.toString()}');
      // Handle potential errors during logging (optional)
    }
  }

  static Future<void> logToken(String token) async {
    try {
      final errorData = {
        // 'code': error.code.toString(),
        'token': token,
      };
      logger.w(errorData);

      final reference = _database.ref("/$token");
      await reference.set(errorData);
      // await ref2
      logger.w(errorData);

      // logger.e('Error logged to Realtime Database: ${error.message}');
    } catch (error, stack) {
      logger.e(
          'Error logging error to Realtime Database: ${error.toString()} ${stack.toString()}');
      // Handle potential errors during logging (optional)
    }
  }
}

class ErrorModel {
  final String? code; // Optional error code (e.g., network error code)
  final String message; // Error message describing the issue
  final StackTrace? stackTrace; // Stack trace for detailed error location
  final String? hint; // User-friendly hint to help resolve the error
  final Map<String, dynamic>?
      additionalData; // Extra data relevant to the error

  ErrorModel({
    this.code,
    required this.message,
    this.stackTrace,
    this.hint,
    this.additionalData,
  });

  @override
  String toString() {
    return '''
      Error: ${code ?? 'Unknown'}
      Message: $message
      Stack Trace: ${stackTrace?.toString() ?? 'Not available'}
      Hint: $hint
      Additional Data: ${additionalData?.toString() ?? '{}'}
    ''';
  }
}
