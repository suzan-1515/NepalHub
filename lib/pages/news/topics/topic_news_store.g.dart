// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TopicNewsStore on _TopicNewsStore, Store {
  final _$selectedTopicAtom = Atom(name: '_TopicNewsStore.selectedTopic');

  @override
  String get selectedTopic {
    _$selectedTopicAtom.context.enforceReadPolicy(_$selectedTopicAtom);
    _$selectedTopicAtom.reportObserved();
    return super.selectedTopic;
  }

  @override
  set selectedTopic(String value) {
    _$selectedTopicAtom.context.conditionallyRunInAction(() {
      super.selectedTopic = value;
      _$selectedTopicAtom.reportChanged();
    }, _$selectedTopicAtom, name: '${_$selectedTopicAtom.name}_set');
  }

  final _$apiErrorAtom = Atom(name: '_TopicNewsStore.apiError');

  @override
  APIException get apiError {
    _$apiErrorAtom.context.enforceReadPolicy(_$apiErrorAtom);
    _$apiErrorAtom.reportObserved();
    return super.apiError;
  }

  @override
  set apiError(APIException value) {
    _$apiErrorAtom.context.conditionallyRunInAction(() {
      super.apiError = value;
      _$apiErrorAtom.reportChanged();
    }, _$apiErrorAtom, name: '${_$apiErrorAtom.name}_set');
  }

  final _$errorAtom = Atom(name: '_TopicNewsStore.error');

  @override
  String get error {
    _$errorAtom.context.enforceReadPolicy(_$errorAtom);
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.context.conditionallyRunInAction(() {
      super.error = value;
      _$errorAtom.reportChanged();
    }, _$errorAtom, name: '${_$errorAtom.name}_set');
  }

  final _$_TopicNewsStoreActionController =
      ActionController(name: '_TopicNewsStore');

  @override
  dynamic setSelectedTopic(String topic) {
    final _$actionInfo = _$_TopicNewsStoreActionController.startAction();
    try {
      return super.setSelectedTopic(topic);
    } finally {
      _$_TopicNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadTopics() {
    final _$actionInfo = _$_TopicNewsStoreActionController.startAction();
    try {
      return super.loadTopics();
    } finally {
      _$_TopicNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadTopicNews() {
    final _$actionInfo = _$_TopicNewsStoreActionController.startAction();
    try {
      return super.loadTopicNews();
    } finally {
      _$_TopicNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retryTopics() {
    final _$actionInfo = _$_TopicNewsStoreActionController.startAction();
    try {
      return super.retryTopics();
    } finally {
      _$_TopicNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retryTopicNews() {
    final _$actionInfo = _$_TopicNewsStoreActionController.startAction();
    try {
      return super.retryTopicNews();
    } finally {
      _$_TopicNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'selectedTopic: ${selectedTopic.toString()},apiError: ${apiError.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
