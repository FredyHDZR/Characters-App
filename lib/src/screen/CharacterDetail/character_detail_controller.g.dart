// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharacterDetailController on CharacterDetailControllerBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'CharacterDetailControllerBase.isLoading',
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

  late final _$episodesAtom = Atom(
    name: 'CharacterDetailControllerBase.episodes',
    context: context,
  );

  @override
  List<Episode> get episodes {
    _$episodesAtom.reportRead();
    return super.episodes;
  }

  @override
  set episodes(List<Episode> value) {
    _$episodesAtom.reportWrite(value, super.episodes, () {
      super.episodes = value;
    });
  }

  late final _$getCharacterEpisodesAsyncAction = AsyncAction(
    'CharacterDetailControllerBase.getCharacterEpisodes',
    context: context,
  );

  @override
  Future<void> getCharacterEpisodes() {
    return _$getCharacterEpisodesAsyncAction.run(
      () => super.getCharacterEpisodes(),
    );
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
episodes: ${episodes}
    ''';
  }
}
