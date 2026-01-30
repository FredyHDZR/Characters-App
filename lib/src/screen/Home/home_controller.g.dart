// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  Computed<List<String>>? _$availableGendersComputed;

  @override
  List<String> get availableGenders =>
      (_$availableGendersComputed ??= Computed<List<String>>(
        () => super.availableGenders,
        name: 'HomeControllerBase.availableGenders',
      )).value;
  Computed<List<String>>? _$availableSpeciesComputed;

  @override
  List<String> get availableSpecies =>
      (_$availableSpeciesComputed ??= Computed<List<String>>(
        () => super.availableSpecies,
        name: 'HomeControllerBase.availableSpecies',
      )).value;
  Computed<bool>? _$hasMoreComputed;

  @override
  bool get hasMore => (_$hasMoreComputed ??= Computed<bool>(
    () => super.hasMore,
    name: 'HomeControllerBase.hasMore',
  )).value;

  late final _$selectedSeriesAtom = Atom(
    name: 'HomeControllerBase.selectedSeries',
    context: context,
  );

  @override
  String get selectedSeries {
    _$selectedSeriesAtom.reportRead();
    return super.selectedSeries;
  }

  @override
  set selectedSeries(String value) {
    _$selectedSeriesAtom.reportWrite(value, super.selectedSeries, () {
      super.selectedSeries = value;
    });
  }

  late final _$pageAtom = Atom(
    name: 'HomeControllerBase.page',
    context: context,
  );

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

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

  late final _$isLoadingMoreAtom = Atom(
    name: 'HomeControllerBase.isLoadingMore',
    context: context,
  );

  @override
  bool get isLoadingMore {
    _$isLoadingMoreAtom.reportRead();
    return super.isLoadingMore;
  }

  @override
  set isLoadingMore(bool value) {
    _$isLoadingMoreAtom.reportWrite(value, super.isLoadingMore, () {
      super.isLoadingMore = value;
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

  late final _$searchQueryAtom = Atom(
    name: 'HomeControllerBase.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
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

  late final _$selectedGenderAtom = Atom(
    name: 'HomeControllerBase.selectedGender',
    context: context,
  );

  @override
  String? get selectedGender {
    _$selectedGenderAtom.reportRead();
    return super.selectedGender;
  }

  @override
  set selectedGender(String? value) {
    _$selectedGenderAtom.reportWrite(value, super.selectedGender, () {
      super.selectedGender = value;
    });
  }

  late final _$selectedSpeciesAtom = Atom(
    name: 'HomeControllerBase.selectedSpecies',
    context: context,
  );

  @override
  String? get selectedSpecies {
    _$selectedSpeciesAtom.reportRead();
    return super.selectedSpecies;
  }

  @override
  set selectedSpecies(String? value) {
    _$selectedSpeciesAtom.reportWrite(value, super.selectedSpecies, () {
      super.selectedSpecies = value;
    });
  }

  late final _$updateHomeWidgetAsyncAction = AsyncAction(
    'HomeControllerBase.updateHomeWidget',
    context: context,
  );

  @override
  Future<void> updateHomeWidget(Character character) {
    return _$updateHomeWidgetAsyncAction.run(
      () => super.updateHomeWidget(character),
    );
  }

  late final _$getCharactersAsyncAction = AsyncAction(
    'HomeControllerBase.getCharacters',
    context: context,
  );

  @override
  Future<void> getCharacters() {
    return _$getCharactersAsyncAction.run(() => super.getCharacters());
  }

  late final _$loadMoreCharactersAsyncAction = AsyncAction(
    'HomeControllerBase.loadMoreCharacters',
    context: context,
  );

  @override
  Future<void> loadMoreCharacters() {
    return _$loadMoreCharactersAsyncAction.run(
      () => super.loadMoreCharacters(),
    );
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
  void appendCharacters(List<Character> newCharacters) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.appendCharacters',
    );
    try {
      return super.appendCharacters(newCharacters);
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
  void setSearchQuery(String value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.setSearchQuery',
    );
    try {
      return super.setSearchQuery(value);
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
  void setSelectedGender(String? value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.setSelectedGender',
    );
    try {
      return super.setSelectedGender(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedSpecies(String? value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.setSelectedSpecies',
    );
    try {
      return super.setSelectedSpecies(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFilters() {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
      name: 'HomeControllerBase.clearFilters',
    );
    try {
      return super.clearFilters();
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedSeries: ${selectedSeries},
page: ${page},
isLoading: ${isLoading},
isLoadingMore: ${isLoadingMore},
characters: ${characters},
searchQuery: ${searchQuery},
filteredCharacters: ${filteredCharacters},
selectedGender: ${selectedGender},
selectedSpecies: ${selectedSpecies},
availableGenders: ${availableGenders},
availableSpecies: ${availableSpecies},
hasMore: ${hasMore}
    ''';
  }
}
