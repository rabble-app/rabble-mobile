import 'package:rabble/core/config/export.dart';

mixin Validators {

  static String message = "Field must not be empty";
  static String emailMessage = "Must be a valid Email";

  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {

        // if(value.isNotEmpty) {
        //   sink.add(value);
        // }
        // else {
        //   sink.addError(message);
        // }

        if(value.length >= 3) {
          sink.add(value);
        }
        else {
          sink.addError("Valid name");
        }
      }
  );

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {

        if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          sink.add(value);
        }
        else {
          sink.addError(emailMessage);
        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {

        if(value.length >=6) {
          sink.add(value);
        }
        else {
          sink.addError("Must be at least 6 characters");
        }
      }
  );

  final validatePhone = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {

        if(number.length > 9) {
          sink.add(number);
        }
        else {
          sink.addError("Please enter valid Phone no");
        }
      }
  );


  final validateOtp = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {
        print(number);
        if(number.length == 6) {
          sink.add(number);
        }
        else {
          sink.addError("Please enter valid Phone no");
        }
      }
  );

  final validateEmpty = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {

        if(value.isNotEmpty) {
          sink.add(value);
        }
        else {
          sink.addError(message);
        }
      }
  );

  final validateGroupName = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {

        if(value.isNotEmpty) {
          sink.add(value);
        }
        else {
          sink.addError(message);
        }
      }
  );

  final validateCardNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {

        if(number.length > 16) {
          sink.add(number);
        }
        else {
          print("NUMBER 1${number.length}");

          sink.addError("Please enter valid Phone no");
        }
      }
  );


  final validateCVV = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {

        if(number.length > 2) {
          sink.add(number);
        }
        else {
          print("NUMBER 2 ${number.length}");

          sink.addError("Please enter valid Phone no");
        }
      }
  );
  final validateExpiry = StreamTransformer<String, String>.fromHandlers(
      handleData: (number, sink) {

        if(number.length > 4) {
          sink.add(number);
        }
        else {
          print("NUMBER 3 ${number.length}");
          sink.addError("Please enter valid Phone no");
        }
      }
  );
}