import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/real_time/live_camera.dart';
import 'package:google_fonts/google_fonts.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // running the app
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue,
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Image.asset(
                "assets/logo.png",
                width: 300,
                height: 300,
              ),
              Text("Plankton Eye",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                  )),
              Spacer(),
              ButtonTheme(
                minWidth: 300,
                child: OutlinedButton(
                  child: Text(
                    "Start Detection",
                    style: GoogleFonts.openSans(
                    textStyle: TextStyle(color: Colors.white, fontSize: 30),
                  )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveFeed(cameras),
                      ),
                    );
                  },
                ),
              ),
              Spacer(flex: 2),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.check_circle, color: Colors.white),
                  onPressed: aboutDialog,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //This includes all the developer specifics and allows the viewing of all the licenses being used
  aboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: "Plankton Eye",
      applicationVersion: "1.0",
      applicationLegalese: "By Jordan Janakievski",
      children: <Widget>[
        Text(
            "Created for Bellarmine Preparatory School's Marine Chemistry program"),
      ],
    );
  }
}
