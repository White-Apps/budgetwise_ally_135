import 'package:apphud/apphud.dart';
import 'package:budgetwise_ally_135/calculator/logic/cubits/get_calculator_cubit/get_calculator_cubit.dart';
import 'package:budgetwise_ally_135/calculator/logic/models/calculator_model.dart';
import 'package:budgetwise_ally_135/calculator/logic/repositories/calculator_repo.dart';
import 'package:budgetwise_ally_135/core/ba_colors.dart';
import 'package:budgetwise_ally_135/core/urls.dart';
import 'package:budgetwise_ally_135/splash/splash_screen.dart';
import 'package:budgetwise_ally_135/wiseally/wisaally_hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CalculatorHiveModelAdapter());
  Hive.registerAdapter(WisaallyHiveAdapter());
  OneSignal.initialize('f1bf1a3f-42ab-4ac3-bd03-045a31fb4545');
  await OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
  await Apphud.start(apiKey: DocFF.vsbsda);
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCalculatorCubit(CalculatorRepoImpl()),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BudgetWise Ally',
          home: child,
          theme: ThemeData(
            fontFamily: 'SFProDisplay',
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            scaffoldBackgroundColor: BaColors.black101010,
            appBarTheme: const AppBarTheme(
              backgroundColor: BaColors.black101010,
            ),
          ),
        ),
        child: const SplashScreen(),
      ),
    );
  }
}
