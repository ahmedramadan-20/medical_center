import 'package:dartz/dartz.dart';

import 'package:medical_center/core/errors/failures.dart';

import '../../../../app/repositories/lang_repository.dart';
import '../../../../core/errors/exceptions.dart';
import '../datasource/lang_local_data_source.dart';

class LangRepositoryImpl implements LangRepository {
  final LangLocaleDataSource langLocaleDataSource;

  LangRepositoryImpl({required this.langLocaleDataSource});

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    {
      try {
        final langIsChanged =await langLocaleDataSource.changeLang(langCode: langCode);
        return Right(langIsChanged);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await langLocaleDataSource.getSavedLang();
      return Right(langCode!);
    } on CacheException {
    return Left(CacheFailure());
    }
  }
}
