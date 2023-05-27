import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_validation/screens/sign_in/bloc/signin_event.dart';
import 'package:signup_validation/screens/sign_in/bloc/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInnitalState()) {
    on<SignInTextChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignInErrorState("Please Enter a Valid Email Addess"));
      } else if (event.passwordValues.length < 8) {
        emit(SignInErrorState("Password Should be 8 Character"));
      } else {
        emit(SignInValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadState());
    });
  }
}
