import 'package:device_preview/device_preview.dart';
import 'package:e_commerce/cubits/add_to_cart_cubit/cart_cubit.dart';
import 'package:e_commerce/cubits/favourites_cubit/favourites_cubit.dart';
import 'package:e_commerce/cubits/product_cubit/product_cubit.dart';
import 'package:e_commerce/features/onboarding_feature/splash_screen.dart';
import 'package:e_commerce/services/store_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ تأكد من تسجيل الدخول كمجهول
  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(create: (_) => CartCubit()),
        BlocProvider<FavoritesCubit>(create: (_) => FavoritesCubit()),
        BlocProvider<ProductCubit>(
          create:
              (_) => ProductCubit(
                storeService: StoreService(),
                category: 'furniture',
              ),
        ),
      ],
      child: MaterialApp(
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // 👈 استخدام شاشة تحقق الدخول
      ),
    );
  }
}
