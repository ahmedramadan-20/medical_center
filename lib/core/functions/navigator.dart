import 'package:go_router/go_router.dart';

void customNavigate(context,path ,{Object? extra}) {
  GoRouter.of(context).push(path, extra: extra);

}


void navigateReplacement(context,path) {
  GoRouter.of(context).pushReplacement(path);
}

void navigatePop(context) {
  GoRouter.of(context).pop();
}