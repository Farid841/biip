import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:audioplayers/audioplayers.dart';


class SettignPage extends StatefulWidget {
  const SettignPage({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}
class _SettingsWidgetState extends State<SettignPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _shareApp() {
    final String message = "Découvrez cette incroyable application! [lien de votre application]";
    Share.share(message);
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

  void _setSystemUIOverlayStyle(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _setSystemUIOverlayStyle(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        appBar: _buildAppBar(),
        body: SafeArea(
          top: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildSectionHeader('Account'),
              _buildListItem(Icons.notifications_none, 'Alarm choice', onTap: () => _showAvailableAudios(context)),
              _buildSectionHeader('General'),
              _buildListItem(Icons.privacy_tip_rounded, 'Terms of Service'),
              _buildListItem(Icons.ios_share, 'Invite Friends', onTap: _shareApp),
              _buildListItem(Icons.star, 'Rate us'),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: _buildStyledText('Settings'),
    actions: [],
    centerTitle: false,
    elevation: 0,
  );

  Text _buildStyledText(String title) => Text(
    title,
    style: TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      color: Color(0xFF14181B),
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
  );

  Widget _buildSectionHeader(String title) => Padding(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: _buildStyledText(title),
  );

  Widget _buildListItem(IconData icon, String title, {VoidCallback? onTap}) => Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x3416202A),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(width: 8),
            Icon(icon, color: Color(0xFF57636C), size: 24),
            Expanded(child: Padding(padding: EdgeInsets.only(left: 12), child: _buildStyledText(title))),
            Icon(Icons.arrow_forward_ios, color: Color(0xFF57636C), size: 18),
            SizedBox(width: 8),
          ],
        ),
      ),
    ),
  );
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
