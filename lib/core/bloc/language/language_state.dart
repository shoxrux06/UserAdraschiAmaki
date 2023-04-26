part of 'language_bloc.dart';

abstract class LanguageState {
  const LanguageState();

}

class LanguageInitial extends LanguageState {
  final String locale;

  LanguageInitial(this.locale);
}
class LanguageLoaded extends LanguageState {
  final Locale locale;

  LanguageLoaded(this.locale);
}