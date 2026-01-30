// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_detail_cntroller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShowDetailController on ShowDetailControllerBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'ShowDetailControllerBase.isLoading',
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

  late final _$showAtom = Atom(
    name: 'ShowDetailControllerBase.show',
    context: context,
  );

  @override
  ShowModel? get show {
    _$showAtom.reportRead();
    return super.show;
  }

  @override
  set show(ShowModel? value) {
    _$showAtom.reportWrite(value, super.show, () {
      super.show = value;
    });
  }

  late final _$getShowAsyncAction = AsyncAction(
    'ShowDetailControllerBase.getShow',
    context: context,
  );

  @override
  Future<void> getShow() {
    return _$getShowAsyncAction.run(() => super.getShow());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
show: ${show}
    ''';
  }
}
