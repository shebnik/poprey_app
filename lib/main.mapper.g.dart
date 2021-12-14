// This file has been generated by the dart_json_mapper package.
// https://github.com/k-paxian/dart-json-mapper
// @dart = 2.12
import 'models/instagram_model.dart' as x0 show InstagramModel, Plan, Type, Extra;
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper, JsonMapperAdapter, typeOf;
// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.


import 'dart:core';
import 'package:dart_json_mapper/src/model/annotations.dart' as prefix0;
import 'package:poprey_app/models/bool_converter.dart' as prefix2;
import 'package:poprey_app/models/instagram_model.dart' as prefix1;

// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: implementation_imports

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{const prefix0.JsonSerializable(): r.ReflectorData(<m.TypeMirror>[r.NonGenericClassMirrorImpl(r'InstagramModel', r'.InstagramModel', 7, 0, const prefix0.JsonSerializable(), const <int>[0, 1, 2, 3, 4, 5, 21, 28], const <int>[29, 21, 30, 31, 32, 22, 23, 24, 25, 26, 27], const <int>[], -1, {}, {}, {r'': (bool b) => ({likes, followers, autoLikesPost, autoLikesSubs, views, comments}) => b ? prefix1.InstagramModel(autoLikesPost: autoLikesPost, autoLikesSubs: autoLikesSubs, comments: comments, followers: followers, likes: likes, views: views) : null}, -1, 0, const <int>[], const [prefix0.jsonSerializable], null), r.NonGenericClassMirrorImpl(r'Plan', r'.Plan', 7, 1, const prefix0.JsonSerializable(), const <int>[6, 7, 8, 9, 10, 11, 12, 33, 41], const <int>[29, 33, 30, 31, 32, 34, 35, 36, 37, 38, 39, 40], const <int>[], -1, {}, {}, {r'': (bool b) => ({count, price, type1, type2, extra1, extra2, extra3}) => b ? prefix1.Plan(extra1: extra1, extra2: extra2, extra3: extra3, count: count, price: price, type1: type1, type2: type2) : null}, -1, 1, const <int>[], const [prefix0.jsonSerializable], null), r.NonGenericClassMirrorImpl(r'Type', r'.Type', 7, 2, const prefix0.JsonSerializable(), const <int>[13, 14, 15, 16, 42, 47], const <int>[29, 42, 30, 31, 32, 43, 44, 45, 46], const <int>[], -1, {}, {}, {r'': (bool b) => ({name, price, disabled, discount}) => b ? prefix1.Type(disabled: disabled, discount: discount, name: name, price: price) : null}, -1, 2, const <int>[], const [prefix0.jsonSerializable], null), r.NonGenericClassMirrorImpl(r'Extra', r'.Extra', 7, 3, const prefix0.JsonSerializable(), const <int>[17, 18, 19, 20, 48, 53], const <int>[29, 48, 30, 31, 32, 49, 50, 51, 52], const <int>[], -1, {}, {}, {r'': (bool b) => ({name, count, price, disabled}) => b ? prefix1.Extra(count: count, disabled: disabled, name: name, price: price) : null}, -1, 3, const <int>[], const [prefix0.jsonSerializable], null)], <m.DeclarationMirror>[r.VariableMirrorImpl(r'likes', 2130949, 0, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [const prefix0.JsonProperty(name: 'Likes/plans')]), r.VariableMirrorImpl(r'followers', 2130949, 0, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [const prefix0.JsonProperty(name: 'Followers/plans')]), r.VariableMirrorImpl(r'autoLikesPost', 2130949, 0, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [const prefix0.JsonProperty(name: 'Auto-Likes/plans')]), r.VariableMirrorImpl(r'autoLikesSubs', 2130949, 0, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [const prefix0.JsonProperty(name: 'Auto-Likes Subs/plans')]), r.VariableMirrorImpl(r'views', 2130949, 0, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [const prefix0.JsonProperty(name: 'Views/plans')]), r.VariableMirrorImpl(r'comments', 2130949, 0, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [const prefix0.JsonProperty(name: 'Comments/plans')]), r.VariableMirrorImpl(r'count', 33797, 1, const prefix0.JsonSerializable(), -1, 6, 6, const <int>[], const [const prefix0.JsonProperty(name: 'count')]), r.VariableMirrorImpl(r'price', 33797, 1, const prefix0.JsonSerializable(), -1, 7, 7, const <int>[], const [const prefix0.JsonProperty(name: 'price')]), r.VariableMirrorImpl(r'type1', 33797, 1, const prefix0.JsonSerializable(), 2, 2, 2, const <int>[], const [const prefix0.JsonProperty(name: 'types/t1')]), r.VariableMirrorImpl(r'type2', 33797, 1, const prefix0.JsonSerializable(), 2, 2, 2, const <int>[], const [const prefix0.JsonProperty(name: 'types/t2')]), r.VariableMirrorImpl(r'extra1', 33797, 1, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [const prefix0.JsonProperty(name: 'extra/e1')]), r.VariableMirrorImpl(r'extra2', 33797, 1, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [const prefix0.JsonProperty(name: 'extra/e2')]), r.VariableMirrorImpl(r'extra3', 33797, 1, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [const prefix0.JsonProperty(name: 'extra/e3')]), r.VariableMirrorImpl(r'name', 33797, 2, const prefix0.JsonSerializable(), -1, 8, 8, const <int>[], const []), r.VariableMirrorImpl(r'price', 33797, 2, const prefix0.JsonSerializable(), -1, 7, 7, const <int>[], const []), r.VariableMirrorImpl(r'disabled', 33797, 2, const prefix0.JsonSerializable(), -1, 9, 9, const <int>[], const [const prefix0.JsonProperty(converter: const prefix2.CustomBoolConverter())]), r.VariableMirrorImpl(r'discount', 33797, 2, const prefix0.JsonSerializable(), -1, 9, 9, const <int>[], const [const prefix0.JsonProperty(converter: const prefix2.CustomBoolConverter())]), r.VariableMirrorImpl(r'name', 33797, 3, const prefix0.JsonSerializable(), -1, 8, 8, const <int>[], const []), r.VariableMirrorImpl(r'count', 33797, 3, const prefix0.JsonSerializable(), -1, 6, 6, const <int>[], const []), r.VariableMirrorImpl(r'price', 33797, 3, const prefix0.JsonSerializable(), -1, 7, 7, const <int>[], const []), r.VariableMirrorImpl(r'disabled', 33797, 3, const prefix0.JsonSerializable(), -1, 9, 9, const <int>[], const [const prefix0.JsonProperty(converter: const prefix2.CustomBoolConverter())]), r.MethodMirrorImpl(r'toString', 131074, 0, -1, 8, 8, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 0, 22), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 1, 23), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 2, 24), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 3, 25), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 4, 26), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 5, 27), r.MethodMirrorImpl(r'', 0, 0, -1, 0, 0, const <int>[], const <int>[0, 1, 2, 3, 4, 5], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'==', 131074, -1, -1, 9, 9, const <int>[], const <int>[6], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'noSuchMethod', 65538, -1, -1, -1, -1, const <int>[], const <int>[7], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'hashCode', 131075, -1, -1, 6, 6, const <int>[], const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'runtimeType', 131075, -1, -1, 10, 10, const <int>[], const <int>[], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toString', 131074, 1, -1, 8, 8, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 6, 34), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 7, 35), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 8, 36), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 9, 37), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 10, 38), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 11, 39), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 12, 40), r.MethodMirrorImpl(r'', 0, 1, -1, 1, 1, const <int>[], const <int>[8, 9, 10, 11, 12, 13, 14], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toString', 131074, 2, -1, 8, 8, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 13, 43), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 14, 44), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 15, 45), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 16, 46), r.MethodMirrorImpl(r'', 0, 2, -1, 2, 2, const <int>[], const <int>[15, 16, 17, 18], const prefix0.JsonSerializable(), const []), r.MethodMirrorImpl(r'toString', 131074, 3, -1, 8, 8, const <int>[], const <int>[], const prefix0.JsonSerializable(), const [override]), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 17, 49), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 18, 50), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 19, 51), r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 20, 52), r.MethodMirrorImpl(r'', 0, 3, -1, 3, 3, const <int>[], const <int>[19, 20, 21, 22], const prefix0.JsonSerializable(), const [])], <m.ParameterMirror>[r.ParameterMirrorImpl(r'likes', 2139142, 28, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [], null, #likes), r.ParameterMirrorImpl(r'followers', 2139142, 28, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [], null, #followers), r.ParameterMirrorImpl(r'autoLikesPost', 2139142, 28, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [], null, #autoLikesPost), r.ParameterMirrorImpl(r'autoLikesSubs', 2139142, 28, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [], null, #autoLikesSubs), r.ParameterMirrorImpl(r'views', 2139142, 28, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [], null, #views), r.ParameterMirrorImpl(r'comments', 2139142, 28, const prefix0.JsonSerializable(), -1, 4, 5, const <int>[1], const [], null, #comments), r.ParameterMirrorImpl(r'other', 32774, 29, const prefix0.JsonSerializable(), -1, 11, 11, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'invocation', 32774, 30, const prefix0.JsonSerializable(), -1, 12, 12, const <int>[], const [], null, null), r.ParameterMirrorImpl(r'count', 41990, 41, const prefix0.JsonSerializable(), -1, 6, 6, const <int>[], const [], null, #count), r.ParameterMirrorImpl(r'price', 41990, 41, const prefix0.JsonSerializable(), -1, 7, 7, const <int>[], const [], null, #price), r.ParameterMirrorImpl(r'type1', 41990, 41, const prefix0.JsonSerializable(), 2, 2, 2, const <int>[], const [], null, #type1), r.ParameterMirrorImpl(r'type2', 41990, 41, const prefix0.JsonSerializable(), 2, 2, 2, const <int>[], const [], null, #type2), r.ParameterMirrorImpl(r'extra1', 46086, 41, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [], null, #extra1), r.ParameterMirrorImpl(r'extra2', 46086, 41, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [], null, #extra2), r.ParameterMirrorImpl(r'extra3', 46086, 41, const prefix0.JsonSerializable(), 3, 3, 3, const <int>[], const [], null, #extra3), r.ParameterMirrorImpl(r'name', 41990, 47, const prefix0.JsonSerializable(), -1, 8, 8, const <int>[], const [], null, #name), r.ParameterMirrorImpl(r'price', 41990, 47, const prefix0.JsonSerializable(), -1, 7, 7, const <int>[], const [], null, #price), r.ParameterMirrorImpl(r'disabled', 41990, 47, const prefix0.JsonSerializable(), -1, 9, 9, const <int>[], const [], null, #disabled), r.ParameterMirrorImpl(r'discount', 41990, 47, const prefix0.JsonSerializable(), -1, 9, 9, const <int>[], const [], null, #discount), r.ParameterMirrorImpl(r'name', 41990, 53, const prefix0.JsonSerializable(), -1, 8, 8, const <int>[], const [], null, #name), r.ParameterMirrorImpl(r'count', 41990, 53, const prefix0.JsonSerializable(), -1, 6, 6, const <int>[], const [], null, #count), r.ParameterMirrorImpl(r'price', 41990, 53, const prefix0.JsonSerializable(), -1, 7, 7, const <int>[], const [], null, #price), r.ParameterMirrorImpl(r'disabled', 41990, 53, const prefix0.JsonSerializable(), -1, 9, 9, const <int>[], const [], null, #disabled)], <Type>[prefix1.InstagramModel, prefix1.Plan, prefix1.Type, prefix1.Extra, const m.TypeValue<List<prefix1.Plan>>().type, List, int, double, String, bool, Type, Object, Invocation], 4, {r'==': (dynamic instance) => (x) => instance == x, r'toString': (dynamic instance) => instance.toString, r'noSuchMethod': (dynamic instance) => instance.noSuchMethod, r'hashCode': (dynamic instance) => instance.hashCode, r'runtimeType': (dynamic instance) => instance.runtimeType, r'likes': (dynamic instance) => instance.likes, r'followers': (dynamic instance) => instance.followers, r'autoLikesPost': (dynamic instance) => instance.autoLikesPost, r'autoLikesSubs': (dynamic instance) => instance.autoLikesSubs, r'views': (dynamic instance) => instance.views, r'comments': (dynamic instance) => instance.comments, r'count': (dynamic instance) => instance.count, r'price': (dynamic instance) => instance.price, r'type1': (dynamic instance) => instance.type1, r'type2': (dynamic instance) => instance.type2, r'extra1': (dynamic instance) => instance.extra1, r'extra2': (dynamic instance) => instance.extra2, r'extra3': (dynamic instance) => instance.extra3, r'name': (dynamic instance) => instance.name, r'disabled': (dynamic instance) => instance.disabled, r'discount': (dynamic instance) => instance.discount}, {}, null, [])};


final _memberSymbolMap = null;

void _initializeReflectable(JsonMapperAdapter adapter) {
  if (!adapter.isGenerated) {
    return;
  }
  r.data = adapter.reflectableData!;
  r.memberSymbolMap = adapter.memberSymbolMap;
}

final mainGeneratedAdapter = JsonMapperAdapter(
  title: 'Main Generated Adapter',
  url: 'package:poprey_app/main.dart',
  reflectableData: _data,
  memberSymbolMap: _memberSymbolMap,
  valueDecorators: {
    typeOf<List<x0.InstagramModel>>(): (value) => value.cast<x0.InstagramModel>(),
    typeOf<Set<x0.InstagramModel>>(): (value) => value.cast<x0.InstagramModel>(),
    typeOf<List<x0.Plan>>(): (value) => value.cast<x0.Plan>(),
    typeOf<Set<x0.Plan>>(): (value) => value.cast<x0.Plan>(),
    typeOf<List<x0.Type>>(): (value) => value.cast<x0.Type>(),
    typeOf<Set<x0.Type>>(): (value) => value.cast<x0.Type>(),
    typeOf<List<x0.Extra>>(): (value) => value.cast<x0.Extra>(),
    typeOf<Set<x0.Extra>>(): (value) => value.cast<x0.Extra>()
},
  enumValues: {

});

Future<JsonMapper> initializeJsonMapperAsync({Iterable<JsonMapperAdapter> adapters = const []}) => Future(() => initializeJsonMapper(adapters: adapters));

JsonMapper initializeJsonMapper({Iterable<JsonMapperAdapter> adapters = const []}) {
  JsonMapper.enumerateAdapters([...adapters, mainGeneratedAdapter], (JsonMapperAdapter adapter) {
    _initializeReflectable(adapter);
    JsonMapper().useAdapter(adapter);
  });
  return JsonMapper();
}