package com.example.loveisblue

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val channel2 = "stream";

   override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
       GeneratedPluginRegistrant.registerWith(flutterEngine)
       EventChannel(flutterEngine.dartExecutor.binaryMessenger, channel2).setStreamHandler(BleHandler())
   }
}