// Mocks generated by Mockito 5.4.4 from annotations
// in interactive_i18n/test/state/language_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;
import 'dart:typed_data' as _i7;
import 'dart:ui' as _i8;

import 'package:flutter/foundation.dart' as _i4;
import 'package:flutter/src/services/asset_bundle.dart' as _i6;
import 'package:flutter/src/widgets/framework.dart' as _i3;
import 'package:flutter/src/widgets/notification_listener.dart' as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFuture_0<T1> extends _i1.SmartFake implements _i2.Future<T1> {
  _FakeFuture_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWidget_1 extends _i1.SmartFake implements _i3.Widget {
  _FakeWidget_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedWidget_2 extends _i1.SmartFake
    implements _i3.InheritedWidget {
  _FakeInheritedWidget_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_3 extends _i1.SmartFake
    implements _i4.DiagnosticsNode {
  _FakeDiagnosticsNode_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({
    _i4.TextTreeConfiguration? parentConfiguration,
    _i4.DiagnosticLevel? minLevel = _i4.DiagnosticLevel.info,
  }) =>
      super.toString();
}

/// A class which mocks [SharedPreferences].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharedPreferences extends _i1.Mock implements _i5.SharedPreferences {
  MockSharedPreferences() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Set<String> getKeys() => (super.noSuchMethod(
        Invocation.method(
          #getKeys,
          [],
        ),
        returnValue: <String>{},
      ) as Set<String>);

  @override
  Object? get(String? key) => (super.noSuchMethod(Invocation.method(
        #get,
        [key],
      )) as Object?);

  @override
  bool? getBool(String? key) => (super.noSuchMethod(Invocation.method(
        #getBool,
        [key],
      )) as bool?);

  @override
  int? getInt(String? key) => (super.noSuchMethod(Invocation.method(
        #getInt,
        [key],
      )) as int?);

  @override
  double? getDouble(String? key) => (super.noSuchMethod(Invocation.method(
        #getDouble,
        [key],
      )) as double?);

  @override
  String? getString(String? key) => (super.noSuchMethod(Invocation.method(
        #getString,
        [key],
      )) as String?);

  @override
  bool containsKey(String? key) => (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [key],
        ),
        returnValue: false,
      ) as bool);

  @override
  List<String>? getStringList(String? key) =>
      (super.noSuchMethod(Invocation.method(
        #getStringList,
        [key],
      )) as List<String>?);

  @override
  _i2.Future<bool> setBool(
    String? key,
    bool? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setBool,
          [
            key,
            value,
          ],
        ),
        returnValue: _i2.Future<bool>.value(false),
      ) as _i2.Future<bool>);

  @override
  _i2.Future<bool> setInt(
    String? key,
    int? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setInt,
          [
            key,
            value,
          ],
        ),
        returnValue: _i2.Future<bool>.value(false),
      ) as _i2.Future<bool>);

  @override
  _i2.Future<bool> setDouble(
    String? key,
    double? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setDouble,
          [
            key,
            value,
          ],
        ),
        returnValue: _i2.Future<bool>.value(false),
      ) as _i2.Future<bool>);

  @override
  _i2.Future<bool> setString(
    String? key,
    String? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setString,
          [
            key,
            value,
          ],
        ),
        returnValue: _i2.Future<bool>.value(false),
      ) as _i2.Future<bool>);

  @override
  _i2.Future<bool> setStringList(
    String? key,
    List<String>? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setStringList,
          [
            key,
            value,
          ],
        ),
        returnValue: _i2.Future<bool>.value(false),
      ) as _i2.Future<bool>);

  @override
  _i2.Future<bool> remove(String? key) => (super.noSuchMethod(
        Invocation.method(
          #remove,
          [key],
        ),
        returnValue: _i2.Future<bool>.value(false),
      ) as _i2.Future<bool>);

  @override
  _i2.Future<bool> commit() => (super.noSuchMethod(
        Invocation.method(
          #commit,
          [],
        ),
        returnValue: _i2.Future<bool>.value(false),
      ) as _i2.Future<bool>);

  @override
  _i2.Future<bool> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i2.Future<bool>.value(false),
      ) as _i2.Future<bool>);

  @override
  _i2.Future<void> reload() => (super.noSuchMethod(
        Invocation.method(
          #reload,
          [],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);
}

/// A class which mocks [AssetBundle].
///
/// See the documentation for Mockito's code generation for more information.
class MockAssetBundle extends _i1.Mock implements _i6.AssetBundle {
  MockAssetBundle() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Future<_i7.ByteData> load(String? key) => (super.noSuchMethod(
        Invocation.method(
          #load,
          [key],
        ),
        returnValue: _i2.Future<_i7.ByteData>.value(_i7.ByteData(0)),
      ) as _i2.Future<_i7.ByteData>);

  @override
  _i2.Future<_i8.ImmutableBuffer> loadBuffer(String? key) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadBuffer,
          [key],
        ),
        returnValue: _i2.Future<_i8.ImmutableBuffer>.value(
            _i9.dummyValue<_i8.ImmutableBuffer>(
          this,
          Invocation.method(
            #loadBuffer,
            [key],
          ),
        )),
      ) as _i2.Future<_i8.ImmutableBuffer>);

  @override
  _i2.Future<String> loadString(
    String? key, {
    bool? cache = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadString,
          [key],
          {#cache: cache},
        ),
        returnValue: _i2.Future<String>.value(_i9.dummyValue<String>(
          this,
          Invocation.method(
            #loadString,
            [key],
            {#cache: cache},
          ),
        )),
      ) as _i2.Future<String>);

  @override
  _i2.Future<T> loadStructuredData<T>(
    String? key,
    _i2.Future<T> Function(String)? parser,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadStructuredData,
          [
            key,
            parser,
          ],
        ),
        returnValue: _i9.ifNotNull(
              _i9.dummyValueOrNull<T>(
                this,
                Invocation.method(
                  #loadStructuredData,
                  [
                    key,
                    parser,
                  ],
                ),
              ),
              (T v) => _i2.Future<T>.value(v),
            ) ??
            _FakeFuture_0<T>(
              this,
              Invocation.method(
                #loadStructuredData,
                [
                  key,
                  parser,
                ],
              ),
            ),
      ) as _i2.Future<T>);

  @override
  _i2.Future<T> loadStructuredBinaryData<T>(
    String? key,
    _i2.FutureOr<T> Function(_i7.ByteData)? parser,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadStructuredBinaryData,
          [
            key,
            parser,
          ],
        ),
        returnValue: _i9.ifNotNull(
              _i9.dummyValueOrNull<T>(
                this,
                Invocation.method(
                  #loadStructuredBinaryData,
                  [
                    key,
                    parser,
                  ],
                ),
              ),
              (T v) => _i2.Future<T>.value(v),
            ) ??
            _FakeFuture_0<T>(
              this,
              Invocation.method(
                #loadStructuredBinaryData,
                [
                  key,
                  parser,
                ],
              ),
            ),
      ) as _i2.Future<T>);

  @override
  void evict(String? key) => super.noSuchMethod(
        Invocation.method(
          #evict,
          [key],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void clear() => super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [BuildContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockLanguageBuildContext extends _i1.Mock implements _i3.BuildContext {
  MockLanguageBuildContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Widget get widget => (super.noSuchMethod(
        Invocation.getter(#widget),
        returnValue: _FakeWidget_1(
          this,
          Invocation.getter(#widget),
        ),
      ) as _i3.Widget);

  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
      ) as bool);

  @override
  bool get debugDoingBuild => (super.noSuchMethod(
        Invocation.getter(#debugDoingBuild),
        returnValue: false,
      ) as bool);

  @override
  _i3.InheritedWidget dependOnInheritedElement(
    _i3.InheritedElement? ancestor, {
    Object? aspect,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #dependOnInheritedElement,
          [ancestor],
          {#aspect: aspect},
        ),
        returnValue: _FakeInheritedWidget_2(
          this,
          Invocation.method(
            #dependOnInheritedElement,
            [ancestor],
            {#aspect: aspect},
          ),
        ),
      ) as _i3.InheritedWidget);

  @override
  void visitAncestorElements(_i3.ConditionalElementVisitor? visitor) =>
      super.noSuchMethod(
        Invocation.method(
          #visitAncestorElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void visitChildElements(_i3.ElementVisitor? visitor) => super.noSuchMethod(
        Invocation.method(
          #visitChildElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispatchNotification(_i10.Notification? notification) =>
      super.noSuchMethod(
        Invocation.method(
          #dispatchNotification,
          [notification],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.DiagnosticsNode describeElement(
    String? name, {
    _i4.DiagnosticsTreeStyle? style = _i4.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeElement,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_3(
          this,
          Invocation.method(
            #describeElement,
            [name],
            {#style: style},
          ),
        ),
      ) as _i4.DiagnosticsNode);

  @override
  _i4.DiagnosticsNode describeWidget(
    String? name, {
    _i4.DiagnosticsTreeStyle? style = _i4.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeWidget,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_3(
          this,
          Invocation.method(
            #describeWidget,
            [name],
            {#style: style},
          ),
        ),
      ) as _i4.DiagnosticsNode);

  @override
  List<_i4.DiagnosticsNode> describeMissingAncestor(
          {required Type? expectedAncestorType}) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeMissingAncestor,
          [],
          {#expectedAncestorType: expectedAncestorType},
        ),
        returnValue: <_i4.DiagnosticsNode>[],
      ) as List<_i4.DiagnosticsNode>);

  @override
  _i4.DiagnosticsNode describeOwnershipChain(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeOwnershipChain,
          [name],
        ),
        returnValue: _FakeDiagnosticsNode_3(
          this,
          Invocation.method(
            #describeOwnershipChain,
            [name],
          ),
        ),
      ) as _i4.DiagnosticsNode);
}
