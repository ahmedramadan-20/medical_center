import 'package:go_router/go_router.dart';

void customNavigate(context,path) {
  GoRouter.of(context).push(path);
}


void navigateReplacement(context,path) {
  GoRouter.of(context).pushReplacement(path);
}