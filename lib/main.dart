import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(analytics: analytics,),
    );
  }
}

class MyHomePage extends StatefulWidget {
final FirebaseAnalytics analytics;

  MyHomePage({required this.analytics});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  final FirebaseInAppMessaging fiam=FirebaseInAppMessaging.instance;

void logEvent(String eventName) async {
    await widget.analytics.logEvent(
      name: eventName,
      parameters: {
        'source': 'FIAM',
      },
    );
    print('Logged event: $eventName');
  }

  void getInstallationId() async {
    String? installationId = await widget.analytics.appInstanceId;
    print('Firebase Installation ID: $installationId');
  }

 @override
  void initState(){
    super.initState();
        fiam.setAutomaticDataCollectionEnabled(true);

        logEvent('page_view');

    // Retrieve and print Firebase Installation ID (FID)
    getInstallationId();
        
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Hello"),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Hello")
            
          ],
        ),
      ),
    );
  }
}
