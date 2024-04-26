import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // If you are using Firebase UI Auth components in other parts of your app, keep this
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: _currentPageIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.notifications_sharp),
            ),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('dash.png'),
            const Text('Welcome!', style: TextStyle(fontSize: 24)),
            const SignOutButton(),
            ElevatedButton(
              onPressed: () => _showAvailableAudios(context),
              child: const Text('Show Available Audios'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAvailableAudios(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AudioListDialog(onSelect: (selectedAudio) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Selected audio: $selectedAudio"))
          );
        });
      },
    );
  }
}

class AudioListDialog extends StatefulWidget {
  final Function(String) onSelect;

  const AudioListDialog({super.key, required this.onSelect});

  @override
  _AudioListDialogState createState() => _AudioListDialogState();
}

class _AudioListDialogState extends State<AudioListDialog> {
  final List<String> _audioFiles = ['audio1.mp3', 'audio2.mp3', 'audio3.mp3'];
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select an Audio File'),
      content: Container(
        width: double.minPositive,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _audioFiles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_audioFiles[index]),
              onTap: () async {
                try {
                  await _audioPlayer.play(AssetSource('audios/${_audioFiles[index]}'));
                  widget.onSelect(_audioFiles[index]);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error playing audio: $e'))
                  );
                }
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _audioPlayer.stop();
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
