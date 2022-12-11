// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $subjectsHash() => r'87e9058bf0f9b75dc7e1bc3c3bccc98de16fc7de';

/// A provider for subjects.
///
/// Copied from [subjects].
final subjectsProvider = AutoDisposeFutureProvider<List<Subject>>(
  subjects,
  name: r'subjectsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : $subjectsHash,
);
typedef SubjectsRef = AutoDisposeFutureProviderRef<List<Subject>>;
String $subjectHash() => r'03e1c55c8801e27ac6dd8fc7b4977ab184a7ad72';

/// A provider for subject.
///
/// Copied from [subject].
class SubjectProvider extends AutoDisposeFutureProvider<Subject> {
  SubjectProvider({
    required this.query,
  }) : super(
          (ref) => subject(
            ref,
            query: query,
          ),
          from: subjectProvider,
          name: r'subjectProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $subjectHash,
        );

  final SubjectQuery query;

  @override
  bool operator ==(Object other) {
    return other is SubjectProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef SubjectRef = AutoDisposeFutureProviderRef<Subject>;

/// A provider for subject.
///
/// Copied from [subject].
final subjectProvider = SubjectFamily();

class SubjectFamily extends Family<AsyncValue<Subject>> {
  SubjectFamily();

  SubjectProvider call({
    required SubjectQuery query,
  }) {
    return SubjectProvider(
      query: query,
    );
  }

  @override
  AutoDisposeFutureProvider<Subject> getProviderOverride(
    covariant SubjectProvider provider,
  ) {
    return call(
      query: provider.query,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'subjectProvider';
}
