import 'package:go_router/go_router.dart';
import '../screens/screens.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/activation',
    routes: [
      GoRoute(
        path: '/activation',
        name: 'activation',
        builder: (context, state) => const ActivationScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/clubs',
        name: 'clubs',
        builder: (context, state) => const ClubsScreen(),
      ),
      GoRoute(
        path: '/announcements',
        name: 'announcements',
        builder: (context, state) => const AnnouncementsScreen(),
      ),
      GoRoute(
        path: '/attendance',
        name: 'attendance',
        builder: (context, state) => const AttendanceScreen(),
      ),
      GoRoute(
        path: '/attendance-history',
        name: 'attendance-history',
        builder: (context, state) => const AttendanceHistoryScreen(),
      ),
      GoRoute(
        path: '/curriculum',
        name: 'curriculum',
        builder: (context, state) => const CurriculumScreen(),
      ),
      GoRoute(
        path: '/directory',
        name: 'directory',
        builder: (context, state) => const DirectoryScreen(),
      ),
      GoRoute(
        path: '/digital-library',
        name: 'digital-library',
        builder: (context, state) => const DigitalLibraryScreen(),
      ),
      GoRoute(
        path: '/documents',
        name: 'documents',
        builder: (context, state) => const DocumentsScreen(),
      ),
      GoRoute(
        path: '/feedback',
        name: 'feedback',
        builder: (context, state) => const FeedbackScreen(),
      ),
      GoRoute(
        path: '/grades',
        name: 'grades',
        builder: (context, state) => const GradesScreen(),
      ),
      GoRoute(
        path: '/graduation',
        name: 'graduation',
        builder: (context, state) => const GraduationScreen(),
      ),
      GoRoute(
        path: '/helpdesk',
        name: 'helpdesk',
        builder: (context, state) => const HelpDeskScreen(),
      ),
      GoRoute(
        path: '/payments',
        name: 'payments',
        builder: (context, state) => const PaymentsScreen(),
      ),
      GoRoute(
        path: '/realtime-results',
        name: 'realtime-results',
        builder: (context, state) => const RealtimeResultsScreen(),
      ),
      GoRoute(
        path: '/roll-room',
        name: 'roll-room',
        builder: (context, state) => const RollRoomScreen(),
      ),
      GoRoute(
        path: '/schedule',
        name: 'schedule',
        builder: (context, state) => const ScheduleScreen(),
      ),
      GoRoute(
        path: '/school-activities',
        name: 'school-activities',
        builder: (context, state) => const SchoolActivitiesScreen(),
      ),
      GoRoute(
        path: '/self-test',
        name: 'self-test',
        builder: (context, state) => const SelfTestScreen(),
      ),
      GoRoute(
        path: '/test-review',
        name: 'test-review',
        builder: (context, state) => const TestReviewScreen(),
      ),
      GoRoute(
        path: '/timeline',
        name: 'timeline',
        builder: (context, state) => const TimelineScreen(),
      ),
    ],
  );
}
