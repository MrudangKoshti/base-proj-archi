import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';
import 'auth_params.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class Params extends Equatable {
  final AuthParams? authParams;

  Params({this.authParams});

  @override
  List<Object?> get props => [authParams];
}
