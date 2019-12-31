import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stepper_component/domain/entities/number_trivia.dart';
import 'package:stepper_component/domain/repositories/number_trivia_repository.dart';
import 'package:stepper_component/domain/usercases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = new MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = new NumberTrivia(number: 1, text: 'test');
  test('Should get trivia for the number from the repository', () async {
    //arrange
    when(mockNumberTriviaRepository.getConcreteNumber(any)).thenAnswer((_) async => tNumberTrivia);

    // act
    final result = await usecase.execute(number: tNumber);

    //assert
    expect(result, tNumberTrivia);
    verify(mockNumberTriviaRepository.getConcreteNumber(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
