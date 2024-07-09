import 'dart:ffi';
import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:newyoutube/Short_video/content/short_video_model.dart';
import 'package:newyoutube/Short_video/upload/short_video_details.dart';
import 'package:newyoutube/cores/methods.dart';
import 'package:video_editor/video_editor.dart';

class ShortVideoScreen extends StatefulWidget {
  final File shortVideo;
  const ShortVideoScreen({super.key, required this.shortVideo});

  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> {
  late VideoEditorController editorController;
  final isExporting = ValueNotifier<bool>(false);
  final exportingProcess = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    editorController = VideoEditorController.file(
      widget.shortVideo,
      minDuration: const Duration(seconds: 3),
      maxDuration: const Duration(seconds: 60),
    );
    editorController.initialize(aspectRatio: 4 / 3.6).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    editorController.dispose();
    super.dispose();
  }

  Future<void> exportVideo() async {
    isExporting.value = true;
    final config = VideoFFmpegVideoEditorConfig(editorController);
    final execute = await config.getExecuteConfig();
    final String command = execute.command;

    // Start the export process
    await FFmpegKit.executeAsync(command, (session) async {
      final ReturnCode? code = await session.getReturnCode();
      isExporting.value = false;

      if (ReturnCode.isSuccess(code)) {
        // Navigate to the details page
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShortVideoDetails(video: widget.shortVideo),
            ),
          );
        }
      } else {
        // Show error message
        showErrorSnackBar("Video export failed", context);
        print('FFmpegKit error: ${await session.getOutput()}');
      }
    }, null, (status) {
      exportingProcess.value = config.getFFmpegProgress(status.getTime().toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: editorController.initialized
              ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CropGridViewer.preview(controller: editorController),
              const Spacer(),
              TrimSlider(controller: editorController),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextButton(
                        onPressed: exportVideo,
                        child: const Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
