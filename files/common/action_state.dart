import 'package:freezed_annotation/freezed_annotation.dart';

part 'action_state.freezed.dart';

@freezed
class ActionState with _$ActionState {
  const factory ActionState.initial() = _Initial;
  const factory ActionState.running() = _Running;
  const factory ActionState.success() = _Success;
  factory ActionState.failure(dynamic e) = _Failure;
}
