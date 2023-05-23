import 'package:afisha_market/core/bloc/auth/authEvent.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:afisha_market/core/data/repository/auth_repository.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthState()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthState(isAuthenticating: true));
      try {
        emit(AuthState(status: AuthStatus.loading));
        final signInResponse = await _authRepository.signIn(event.signInRequest);
        signInResponse.when(
          success: (data) async {
            emit(AuthState(
                signInResponse: data,
                status: AuthStatus.success,
                isAuthenticated: true,
                isAuthenticating: false
            )
            );
            await LocalStorage.instance.setToken(data.token);
            await LocalStorage.instance.setUserId(data.user.id);
            await LocalStorage.instance.setUserName(data.user.username);
            await LocalStorage.instance.setUserPhone(data.user.phone);
          },
          failure: (failure) {
            emit(AuthState(
                status: AuthStatus.error,
                isErrorOccurred: true,
                isAuthenticating: false
            )
            );
          },
        );
      } catch (_) {
        emit(AuthState(
            status: AuthStatus.error,
            isErrorOccurred: true,
            isAuthenticating: false
        ));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthState(isAuthenticating: true));
      try {
        final signUpResponse = await _authRepository.signUp(
            event.context,
            event.signUpRequest
        );
        signUpResponse.when(
          success: (data) {
            emit(
              AuthState(
                statusAndMessageResponse: data,
                isAuthenticated: true,
                avatar: state.avatar
              ),
            );
          },
          failure: (failure) {
            emit(AuthState(
              status: AuthStatus.error,
              isErrorOccurred: true,
              isAuthenticating: false,
              avatar: state.avatar,
              networkExceptions: failure
            ));
          },
        );
      } catch (_) {
        emit(AuthState(
          status: AuthStatus.error,
          isErrorOccurred: true,
          avatar: state.avatar,
          isAuthenticating: false,
        ));
      }
    });

    on<VerifyEvent>((event, emit) async {
      emit(AuthState(isVerifying: true));
      try {
        final verifyResponse = await _authRepository.verify(event.context,event.verifyRequest);
        verifyResponse.when(
          success: (data) async {
            emit(AuthState(verifyResponse: data, isVerified: true,isVerifying: false));
            await LocalStorage.instance.setToken(data.token);
            await LocalStorage.instance.setUserId(data.user.id);
            await LocalStorage.instance.setUserName(data.user.username);
            await LocalStorage.instance.setUserPhone(data.user.phone);
          },
          failure: (failure) {
            emit(AuthState(
              status: AuthStatus.error,
              isErrorOccurred: true,
                isVerifying: false
            ));
          },
        );
      } catch (_) {
        emit(AuthState(
            status: AuthStatus.error,
            isErrorOccurred: true,
            isVerifying: false
        ));
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      emit(AuthState());
      try {
        final forgotPasswordResponse = await _authRepository.forgotPassword(event.context,event.forgotPasswordRequest);
        forgotPasswordResponse.when(
          success: (data) {
            emit(AuthState(
              statusAndMessageResponse: data,isErrorOccurred: false,isAuthenticated:true,
            ));
          },
          failure: (failure) {
            emit(AuthState(isErrorOccurred: true));
          },
        );
      } catch (_) {
        emit(AuthState(isErrorOccurred: true));
      }
    });

    on<NewPasswordEvent>((event, emit) async {
      try {
        final resetPasswordResponse =
            await _authRepository.newPassword(event.resetPasswordRequest);
        resetPasswordResponse.when(
          success: (data) {
            emit(AuthState(statusAndMessageResponse: data));
          },
          failure: (failure) {
            emit(AuthState(isErrorOccurred: true));
          },
        );
      } catch (_) {
        emit(AuthState(isErrorOccurred: true));
      }
    });

    on<ResendCodeEvent>((event, emit) async {
      try {
        final resetPasswordResponse = await _authRepository.reSendOTP(event.context,event.phone);
        resetPasswordResponse.when(
          success: (data) {
            emit(AuthState(statusAndMessageResponse: data));
          },
          failure: (failure) {
            emit(AuthState(isErrorOccurred: true));
          },
        );
      } catch (_) {
        emit(AuthState(isErrorOccurred: true));
      }
    });

    on<DeleteAccountEvent>((event, emit) async {
      try {
        final resetPasswordResponse = await _authRepository.deleteAccount(event.token);
        resetPasswordResponse.when(
          success: (data) {
            emit(AuthState(statusAndMessageResponse: data, isAuthenticated: false));
            LocalStorage.instance.deleteToken();
            LocalStorage.instance.deleteUserId();
            LocalStorage.instance.deleteUsername();
            LocalStorage.instance.deleteUserPhone();
          },
          failure: (failure) {
            emit(AuthState(isErrorOccurred: true));
          },
        );
      } catch (_) {
        emit(AuthState(isErrorOccurred: true));
      }
    });

    on<AuthImagePickedEvent>((event, emit) {
      emit(AuthState(avatar: event.avatar));
    });
  }
}
