import 'package:flutter/material.dart';
import 'package:music_player_app/services/audio_player_service.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  String? _filePath;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
      await _audioPlayerService.play(_filePath!);
    }
  }

  Future<void> _pausePlayback() async {
    await _audioPlayerService.pause();
  }

  Future<void> _stopPlayback() async {
    await _audioPlayerService.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_note,
              size: 100.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 20.0),
            _filePath != null
                ? Text(
                    'Playing: ${_filePath!.split('/').last}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16.0),
                  )
                : const Text('No file selected',
                    style: TextStyle(fontSize: 16.0)),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Pick and Play Music'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _pausePlayback,
              child: const Text('Pause'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _stopPlayback,
              child: const Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}