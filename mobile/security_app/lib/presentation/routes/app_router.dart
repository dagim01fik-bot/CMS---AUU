import 'package:go_router/go_router.dart';

import '../screens/id_verification_screen.dart';
import '../screens/security_history_screen.dart';
import '../screens/security_login_screen.dart';
import '../screens/verification_detail_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const SecurityLoginScreen(),
      ),
      GoRoute(
        path: '/verify',
        builder: (context, state) => const IdVerificationScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const SecurityHistoryScreen(),
      ),
      GoRoute(
        path: '/verify/detail',
        builder: (context, state) {
          final args = state.extra;
          if (args is! VerificationDetailRouteArgs) {
            return const IdVerificationScreen();
          }

          return VerificationDetailScreen(args: args);
        },
      ),
    ],
  );
}
