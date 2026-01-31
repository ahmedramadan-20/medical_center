import 'package:dartz/dartz.dart';
import 'package:medical_center/app/repositories/lang_repository.dart';
import 'package:medical_center/core/errors/failures.dart';
import 'package:medical_center/core/usecases/usecase.dart';

/// Use case for changing the application language.
class ChangeLangUseCase implements UseCase<bool, String> {
  ChangeLangUseCase({required this.langRepository});
  final LangRepository langRepository;

  @override
  Future<Either<Failure, bool>> call(String langCode) =>
      langRepository.changeLang(langCode: langCode);
}
