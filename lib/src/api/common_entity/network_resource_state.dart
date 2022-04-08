import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql/client.dart';

part 'network_resource_state.freezed.dart';

@freezed
abstract class NetworkResourceState<T> with _$NetworkResourceState<T> {
  const factory NetworkResourceState(T? data) = _Data<T>;

  const factory NetworkResourceState.loading() = _Loading<T>;

  const factory NetworkResourceState.error(List<GraphQLError>? errors) =
      _ErrorDetails<T>;
}
