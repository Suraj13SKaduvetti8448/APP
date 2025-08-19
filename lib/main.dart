import 'package:flutter/material.dart';
import 'package:furnitracker/views/landing/landing_page.dart';
import 'package:furnitracker/views/shared/profile_settings.dart';
import 'package:provider/provider.dart';
import 'core/app_routes.dart';
import 'core/app_theme.dart';
import 'core/constants.dart';
import 'services/auth_service.dart';
import 'views/auth/login_page.dart';
import 'views/auth/register_page.dart';
import 'views/business_user/business_home.dart';
import 'views/client/client_home.dart';
import 'views/designer/designer_home.dart';
import 'views/shared/product_list_page.dart';
import 'views/shared/profile_settings.dart';

// 🔹 Import the new pages
import 'views/landing/explore.dart';
import 'views/landing/designers.dart';
import 'views/landing/business_clients.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FurniTrackerApp());
}

class FurniTrackerApp extends StatelessWidget {
  const FurniTrackerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService()..bootstrap(),
      child: MaterialApp(
        title: AppConst.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        initialRoute: AppRoutes.landing,
        routes: {
          AppRoutes.landing: (_) => const LandingPage(),
          AppRoutes.login: (_) => const LoginPage(),
          AppRoutes.register: (_) => const RegisterPage(),
          AppRoutes.businessHome: (_) => const BusinessHome(),
          AppRoutes.clientHome: (_) => const ClientHome(),
          AppRoutes.designerHome: (_) => const DesignerHome(),
          AppRoutes.productList: (_) => const ProductListPage(),
          AppRoutes.profileSettings: (context) => const ProfileSettingsPage(),

          // 🔹 New Routes
          AppRoutes.explore: (_) => const ExplorePage(),
          AppRoutes.interiorDesigners: (_) => const DesignersPage(),
          AppRoutes.businessFeedback: (_) => const BusinessClientsPage(),
        },
      ),
    );
  }
}

class _SplashGate extends StatelessWidget {
  const _SplashGate();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (_, auth, __) {
        if (auth.current == null) {
          // Not logged in → go to login after first frame
          Future.microtask(() => Navigator.pushReplacementNamed(context, AppRoutes.login));
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        switch (auth.current!.role) {
          case AppConst.roleBusiness:
            Future.microtask(() => Navigator.pushReplacementNamed(context, AppRoutes.businessHome));
            break;
          case AppConst.roleDesigner:
            Future.microtask(() => Navigator.pushReplacementNamed(context, AppRoutes.designerHome));
            break;
          default:
            Future.microtask(() => Navigator.pushReplacementNamed(context, AppRoutes.clientHome));
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

