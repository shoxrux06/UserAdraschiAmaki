import 'dart:ui';
import 'package:afisha_market/core/data/models/language_model.dart';
import 'package:bloc/bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial('en')) {
    on<ToggleLanguageEvent>((event, emit) {
      emit(LanguageLoaded(Locale(event.language.code)));
    });
  }
}
