import 'package:afisha_market/core/bloc/auth/authEvent.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:afisha_market/core/data/repository/auth_repository.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthEmptyState()) {
    on<AuthEmptyEvent>((event, emit) async {
      emit(AuthEmptyState());
    });

    on<SignInEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final signInResponse =
            await _authRepository.signIn(event.signInRequest);
        signInResponse.when(
          success: (data)async {
            emit(SignInState(signInResponse: data));
            emit(AuthSuccessState());
            await LocalStorage.instance.setToken(data.token);
          },
          failure: (failure) {},
        );
      } catch (_) {
        emit(AuthErrorState());
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final signUpResponse =
            await _authRepository.signUp(event.signUpRequest);
        signUpResponse.when(
          success: (data) {
            emit(SignUpState(signUpResponse: data));
            emit(AuthSuccessState());
          },
          failure: (failure) {},
        );
      } catch (_) {
        emit(AuthErrorState());
      }
    });

    on<VerifyEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final verifyResponse =
            await _authRepository.verify(event.verifyRequest);
        verifyResponse.when(
          success: (data) async{
            emit(VerifyState(verifyResponse: data));
            emit(AuthSuccessState());
            await LocalStorage.instance.setToken(data.token);
          },
          failure: (failure) {},
        );
      } catch (_) {
        emit(AuthErrorState());
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final forgotPasswordResponse =
            await _authRepository.forgotPassword(event.forgotPasswordRequest);
        forgotPasswordResponse.when(
          success: (data) {
            emit(ForgotPasswordState(
              forgotPasswordResponse: data,
            ));
            emit(
              AuthSuccessState(),
            );
          },
          failure: (failure) {},
        );
      } catch (_) {
        emit(AuthErrorState());
      }
    });

    on<NewPasswordEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final resetPasswordResponse = await _authRepository.newPassword(event.resetPasswordRequest);
        resetPasswordResponse.when(
          success: (data) {
            emit(NewPasswordState(resetPasswordResponse: data));
            emit(AuthSuccessState());
          },
          failure: (failure) {},
        );
      } catch (_) {
        emit(AuthErrorState());
      }
    });

    on<DeleteAccountEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final resetPasswordResponse = await _authRepository.deleteAccount(event.token);
        resetPasswordResponse.when(
          success: (data) {
            emit(DeleteAccountState(deleteAccountResponse: data));
            emit(AuthSuccessState());
          },
          failure: (failure) {},
        );
      } catch (_) {
        emit(AuthErrorState());
      }
    });
  }
}
