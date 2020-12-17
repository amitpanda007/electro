import 'package:electro/services/PreferenceManager.dart';
import 'package:flutter/material.dart';

class PreferenceModal {
  static void showPreferenceSheet(
      BuildContext context, PreferenceManager preferenceManager) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          body: StreamBuilder<PreferenceState>(
            stream: preferenceManager.currentPrefs,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              "User Preferences",
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SwitchListTile(
                          title: Text("Expand Search (Max 5KM)"),
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                          value: snapshot.data.isLargeSearch,
                          onChanged: (bool newValue) {
                            preferenceManager.isLargeSearchPref.add(newValue);
                          },
                        ),
                        SwitchListTile(
                          title: Text("Dark Mode"),
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                          value: snapshot.data.isDarkMode,
                          onChanged: (bool newValue) {
                            preferenceManager.isDarkModePref.add(newValue);
                          },
                        ),
                      ],
                    )
                  : Text("No Preferences Found");
            },
          ),
        );
      },
    );
  }
}
