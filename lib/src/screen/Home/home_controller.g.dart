// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'HomeControllerBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$charactersAtom = Atom(
    name: 'HomeControllerBase.characters',
    context: context,
  );

  @override
  List<Character> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(List<Character> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$filteredCharactersAtom = Atom(
    name: 'HomeControllerBase.filteredCharacters',
    context: context,
  );

  @override
  List<Character> get filteredCharacters {
    _$filteredCharactersAtom.reportRead();
    return super.filteredCharacters;
  }

  @override
  set filteredCharacters(List<Character> value) {
    _$filteredCharactersAtom.reportWrite(value, super.filteredCharacters, () {
      super.filteredCharacters = value;
    });
  }

  late final _$HomeControllerBaseActionController = ActionController(
    name: 'HomeControllerBase',
    context: context,
  );

  @override
  void setCharacters(List<Character> characters) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.setCharacters',
    );
    try {
      return super.setCharacters(characters);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleLoading() {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.toggleLoading',
    );
    try {
      return super.toggleLoading();
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterCharacters(String query) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.filterCharacters',
    );
    try {
      return super.filterCharacters(query);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
characters: ${characters},
filteredCharacters: ${filteredCharacters}
    ''';
  }
}
