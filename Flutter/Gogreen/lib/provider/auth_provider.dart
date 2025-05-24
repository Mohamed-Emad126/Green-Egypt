import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

class AuthProvider with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
  TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserState _state = UserInitial();
  UserState get state => _state;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setState(UserState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    setLoading(true);

    if (usernameController.text.trim().isEmpty ||
        usernameController.text.length < 3 ||
        usernameController.text.length > 15) {
      showError(context, "Username must be between 3 and 15 characters!");
      setLoading(false);
      return;
    }

    if (emailController.text.trim().isEmpty) {
      showError(context, "Email cannot be empty!");
      setLoading(false);
      return;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      showError(context, "Password must be at least 6 characters!");
      setLoading(false);
      return;
    }

    if (passwordController.text != passwordConfirmationController.text) {
      showError(context, "Passwords do not match!");
      setLoading(false);
      return;
    }

    try {
      Response response = await Dio().post(
        "https://970b-2c0f-fc88-4011-ca12-fc12-6e46-43b7-1448.ngrok-free.app/api/auth/register",
        data: {
          "username": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.toString(),
          "passwordConfirmation": passwordConfirmationController.text.toString(),
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 201) {
        showSuccess(context, "✅ Account created successfully!");
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        showError(context, "❌ Registration failed. Please try again.");
      }
    } on DioException catch (e) {
      handleDioError(context, e);
    }

    setLoading(false);
  }

  Future<void> signin(BuildContext context) async {
    setState(SignInLoading());
    try {
      final Response response = await Dio().post(
        "https://7326-156-210-42-59.ngrok-free.app/api/auth/login",
        data: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        setState(SignInSuccess());
        showSuccess(context, "✅ Login successful!");
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(SignInFailure(errMessage: "❌ Login failed. Please try again."));
        showError(context, "❌ Login failed. Please check your credentials.");
      }
    } on DioException catch (e) {
      setState(SignInFailure(errMessage: e.message ?? "Unknown error"));
      handleDioError(context, e);
    }
    setLoading(false);
  }

  void handleDioError(BuildContext context, DioException e) {
    String errorMessage = "❌ An unexpected error occurred. Please try again.";

    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          errorMessage = "❌ Bad request. Please check your input.";
          break;
        case 401:
          errorMessage = "❌ Unauthorized. Check your credentials.";
          break;
        case 403:
          errorMessage = "❌ Access denied.";
          break;
        case 404:
          errorMessage = "❌ Server not found. Please try again later.";
          break;
        case 500:
          errorMessage = "❌ Internal server error. Please try again later.";
          break;
        default:
          errorMessage = "❌ Something went wrong. Please try again.";
      }
    } else {
      errorMessage = "❌ No internet connection. Please check your network.";
    }

    showError(context, errorMessage);
  }

  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }
}
