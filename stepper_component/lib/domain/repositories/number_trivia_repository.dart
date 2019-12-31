import 'package:stepper_component/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<NumberTrivia> getConcreteNumber(int number);
  Future<NumberTrivia> getRandomNumber();
}
