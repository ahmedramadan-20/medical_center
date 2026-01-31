import 'package:dartz/dartz.dart';
import 'package:medical_center/core/errors/failures.dart';

/// Repository interface for language management operations.
abstract class LangRepository {
  /// Retrieves the saved language code from local storage.
  Future<Either<Failure, String>> getSavedLang();

  /// Saves the selected language code to local storage.
  Future<Either<Failure, bool>> changeLang({required String langCode});
}
