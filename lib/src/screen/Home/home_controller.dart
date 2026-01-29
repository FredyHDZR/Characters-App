import 'package:flutter_character_app/src/models/character_model.dart';
import 'package:flutter_character_app/src/services/home_service.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @observable
  int page = 1;

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingMore = false;

  @observable
  List<Character> characters = [];

  @observable
  String searchQuery = '';

  @observable
  List<Character> filteredCharacters = [];

  @observable
  String? selectedGender;

  @observable
  String? selectedSpecies;

  @computed
  List<String> get availableGenders {
    final values = characters
        .map((item) => item.gender.trim())
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    return values;
  }

  @computed
  List<String> get availableSpecies {
    final values = characters
        .map((item) => item.species.trim())
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    return values;
  }

  @computed
  bool get hasMore => page != 0;

  List<Character> _applyFilters() {
    final query = searchQuery.trim().toLowerCase();
    return characters.where((c) {
      if (query.isNotEmpty && !c.name.toLowerCase().contains(query)) return false;
      if (selectedGender != null && c.gender != selectedGender) return false;
      if (selectedSpecies != null && c.species != selectedSpecies) return false;
      return true;
    }).toList();
  }

  @action
  void setCharacters(List<Character> characters) {
    this.characters = characters;
    filteredCharacters = _applyFilters();
  }

  @action
  void appendCharacters(List<Character> newCharacters) {
    characters.addAll(newCharacters);
    filteredCharacters = _applyFilters();
  }

  @action
  void toggleLoading() {
    isLoading = !isLoading;
  }

  @action
  void setSearchQuery(String value) {
    searchQuery = value;
    filteredCharacters = _applyFilters();
  }

  @action
  void filterCharacters(String query) {
    setSearchQuery(query);
  }

  @action
  void setSelectedGender(String? value) {
    selectedGender = value;
    filteredCharacters = _applyFilters();
  }

  @action
  void setSelectedSpecies(String? value) {
    selectedSpecies = value;
    filteredCharacters = _applyFilters();
  }

  @action
  void clearFilters() {
    selectedGender = null;
    selectedSpecies = null;
    filteredCharacters = _applyFilters();
  }

  @action
  Future<void> getCharacters() async {
    toggleLoading();
    final response = await HomeService.getCharacters(page: page);
    page = response['nextPage'];
    if (response['error'] != null) {
      //TODO: showSnackBar(response['error']);
      toggleLoading();
      return;
    }
    final characters = response['items'] as List<Character>;
    setCharacters(characters);
    toggleLoading();
  }

  @action
  Future<void> loadMoreCharacters() async {
    if (isLoadingMore || !hasMore) return;
    
    isLoadingMore = true;
    final currentPage = page;
    final response = await HomeService.getCharacters(page: currentPage);
    page = response['nextPage'];
    if (response['error'] != null) {
      isLoadingMore = false;
      return;
    }
    final newCharacters = response['items'] as List<Character>;
    appendCharacters(newCharacters);
    isLoadingMore = false;
  }
}