import 'package:go_router/go_router.dart';

void navigate(context,path) {
  GoRouter.of(context).push(path);
}