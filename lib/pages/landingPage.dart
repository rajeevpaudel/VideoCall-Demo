import 'package:armanludocall/pages/room.dart';
import 'package:armanludocall/widgets/buttons.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import "../allalerts.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:livekit_client/livekit_client.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const _storeKeySimulcast = 'simulcast';
  static const _storeKeyAdaptiveStream = 'adaptive-stream';
  static const _storeKeyDynacast = 'dynacast';
  static const _storeKeyFastConnect = 'fast-connect';

  bool _simulcast = true;
  bool _adaptiveStream = true;
  bool _dynacast = true;
  bool _busy = false;
  bool _fastConnect = false;

  bool tokenstate = false;

  checkTokenState() {
    if (globals.token == "" || globals.token == null) {
      tokenstate = false;
    } else {
      tokenstate = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _readPrefs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _readPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    globals.callServerUrl = const bool.hasEnvironment('URL')
        ? const String.fromEnvironment('URL')
        : prefs.getString(globals.callServerUrl) ?? '';
    globals.token = const bool.hasEnvironment('TOKEN')
        ? const String.fromEnvironment('TOKEN')
        : prefs.getString(globals.token) ?? '';
    setState(() {
      _simulcast = prefs.getBool(_storeKeySimulcast) ?? true;
      _adaptiveStream = prefs.getBool(_storeKeyAdaptiveStream) ?? true;
      _dynacast = prefs.getBool(_storeKeyDynacast) ?? true;
      _fastConnect = prefs.getBool(_storeKeyFastConnect) ?? false;
    });
  }

  var serverURL = globals.callServerUrl;
  bool busy = false;
  bool fastconnect = false;

  Widget tokestateButton() {
    if (tokenstate == true) {
      return ElevatedButton(
        onPressed: busy ? null : () => _connect(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (busy)
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            const Text('CONNECT'),
          ],
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (busy)
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            const Text('Please Select A User'),
          ],
        ),
      );
    }
  }

  Future<void> _connect(BuildContext ctx) async {
    //
    try {
      setState(() {
        busy = true;
      });

      // Save URL and Token for convenience

      print(
          'Connecting with url: ${globals.callServerUrl} with token: ${globals.token}...');

      //create new room
      final room = Room();

      // Create a Listener before connecting
      final listener = room.createListener();

      // Try to connect to the room
      // This will throw an Exception if it fails for any reason.
      await room.connect(
        "https://rajeevwebrtc.livekit.cloud",
        globals.token,
        roomOptions: const RoomOptions(
          adaptiveStream: true,
          dynacast: true,
          defaultVideoPublishOptions: VideoPublishOptions(
            simulcast: true,
          ),
          defaultScreenShareCaptureOptions:
              ScreenShareCaptureOptions(useiOSBroadcastExtension: true),
        ),
        fastConnectOptions: fastconnect
            ? FastConnectOptions(
                microphone: const TrackOption(enabled: true),
                camera: const TrackOption(enabled: true),
              )
            : null,
      );
      await Navigator.push<void>(
        ctx,
        MaterialPageRoute(builder: (_) => RoomPage(room, listener)),
      );
    } catch (error) {
      print('Could not connect $error');
      await ctx.showErrorDialog(error);
    } finally {
      setState(() {
        busy = false;
      });
    }
  }

  check(BuildContext ctx) {
    if (globals.token == "" || globals.token == null) {
      ctx.showSelectUser(ctx);
    } else {
      _connect(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkTokenState();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Arman Ludo Audio Call Test'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Text(
                    'This is a Test app for Audio ',
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Call for Arman Ludo Game',
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              const connectButtons(),
              ElevatedButton(
                onPressed: busy ? null : () => check(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (busy)
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    const Text('CONNECT'),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
