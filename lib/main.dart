import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypaws/core/DI/auth_controller.dart';
import 'package:mypaws/core/DI/di.dart';
import 'package:mypaws/core/config/routes.dart';
import 'package:mypaws/core/theme/theme.dart';
import 'package:mypaws/core/widget/bottom_nav_bar.dart';
import 'package:mypaws/firebase_options.dart';
import 'package:mypaws/providers/chat_provider.dart';
import 'package:mypaws/src/pages/chat/chat_page.dart';
import 'package:mypaws/src/pages/feed/new_feed_page.dart';
import 'package:mypaws/src/pages/search/search_page.dart';
import 'core/theme/light_color.dart';
import 'core/widget/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  initGetX();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp().then(
  //   (value) => Get.put(
  //     AuthController(),
  //   ),
  // );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthController()));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  MyApp({required this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
          builder: (context, child) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.lightTheme.copyWith(
                textTheme: GoogleFonts.mulishTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              // home: const MyHomePage(title: 'Flutter Demo Home Page'),
              getPages: Routes.getPageRoute(),
              initialRoute: Routes.mainPage,
            );
          },
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _currentIndex = 0;
  // List<Widget> pages = [
  //   const NewFeedPage(),
  //   const SearchPage(),
  //   const ChatPage(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // children: <Widget>[
        // const CustomAppBar(title: 'MainPage AppBar'),
        // _title(),
        // Expanded(child: MainContent()),
        // ],
      )),
    );
  }

  Widget _title() {
    return Center(
      // padding: const EdgeInsets.all(16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MyPaws",
              style: GoogleFonts.mulish().copyWith(
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                  color: LightColor.lightGrey),
            ),
            Text(
              "Search",
              style: GoogleFonts.mulish().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: LightColor.lightGrey),
            ),
          ]),
    );
  }
}
