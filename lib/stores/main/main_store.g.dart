// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainStore on _MainStore, Store {
  final _$messageAtom = Atom(name: '_MainStore.message');

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  final _$selectedPageAtom = Atom(name: '_MainStore.selectedPage');

  @override
  int get selectedPage {
    _$selectedPageAtom.reportRead();
    return super.selectedPage;
  }

  @override
  set selectedPage(int value) {
    _$selectedPageAtom.reportWrite(value, super.selectedPage, () {
      super.selectedPage = value;
    });
  }

  final _$lastSelectedPageAtom = Atom(name: '_MainStore.lastSelectedPage');

  @override
  int get lastSelectedPage {
    _$lastSelectedPageAtom.reportRead();
    return super.lastSelectedPage;
  }

  @override
  set lastSelectedPage(int value) {
    _$lastSelectedPageAtom.reportWrite(value, super.lastSelectedPage, () {
      super.lastSelectedPage = value;
    });
  }

  final _$_MainStoreActionController = ActionController(name: '_MainStore');

  @override
  dynamic setPage(int pageIndex) {
    final _$actionInfo =
        _$_MainStoreActionController.startAction(name: '_MainStore.setPage');
    try {
      return super.setPage(pageIndex);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message},
selectedPage: ${selectedPage},
lastSelectedPage: ${lastSelectedPage}
    ''';
  }
}
