import 'package:dartz/dartz.dart';
import 'package:medical_center/app/repositories/lang_repository.dart';
import 'package:medical_center/core/errors/exceptions.dart';
import 'package:medical_center/core/errors/failures.dart';
import 'package:medical_center/features/splash/data/datasource/lang_local_data_source.dart';

class LangRepositoryImpl implements LangRepository {
  LangRepositoryImpl({required this.langLocaleDataSource});
  final LangLocaleDataSource langLocaleDataSource;

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final langIsChanged =
          await langLocaleDataSource.changeLang(langCode: langCode);
      return Right(langIsChanged);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await langLocaleDataSource.getSavedLang();
      if (langCode == null) {
        return const Left(CacheFailure(message: 'No saved language found'));
      }
      return Right(langCode);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
