import 'package:flutter/material.dart';
import 'package:stepper_component/domain/entities/number_trivia.dart';
import 'package:stepper_component/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<NumberTrivia> execute({@required int number}) async {
    return await repository.getConcreteNumber(number);
  }
}
