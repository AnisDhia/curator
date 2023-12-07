import 'package:flutter/material.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          PopupMenuButton(
            tooltip: '',
            padding: const EdgeInsets.all(0),
            offset: const Offset(0, 30),
            child: const TextButton(
              onPressed: null,
              child: Text("file"),
            ),
            itemBuilder: (itemBuilder) {
              return [
                PopupMenuItem(
                    onTap: () async {
                      // final jsonData = await _openFile();
                      // if (jsonData != null) {
                      //   value.loadFromJSON(jsonData);
                      // }
                    },
                    height: 30,
                    child: const Text("open")),
                PopupMenuItem(
                    onTap: () async {
                      // await _saveFile(value);
                      // _showFlushBar(
                      //     'Saved',
                      //     'Engine saved into JSON file',
                      //     Colors.blue,
                      //     CupertinoIcons.checkmark_circle);
                    },
                    height: 30,
                    child: const Text("save")),
                PopupMenuItem(
                  onTap: () {
                    // exit(0);
                  },
                  height: 30,
                  child: const Text("exit"),
                ),
              ];
            },
          ),
          PopupMenuButton(
            tooltip: '',
            padding: const EdgeInsets.all(0),
            offset: const Offset(0, 30),
            child: const TextButton(
              onPressed: null,
              child: Text("help"),
            ),
            itemBuilder: (itemBuilder) {
              return [
                PopupMenuItem(
                    onTap: () async {}, height: 30, child: const Text("guide")),
                PopupMenuItem(
                    onTap: () async {}, height: 30, child: const Text("about")),
              ];
            },
          ),
        ],
      ),
    );
  }
}
