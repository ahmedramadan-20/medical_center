import 'package:dartz/dartz.dart';
import 'package:medical_center/app/repositories/lang_repository.dart';
import 'package:medical_center/core/errors/failures.dart';
import 'package:medical_center/core/usecases/usecase.dart';

/// Use case for retrieving the saved language preference.
class GetSavedLangUseCase implements UseCase<String, NoParams> {
  GetSavedLangUseCase({required this.langRepository});
  final LangRepository langRepository;

  @override
  Future<Either<Failure, String>> call(NoParams params) =>
      langRepository.getSavedLang();
}
