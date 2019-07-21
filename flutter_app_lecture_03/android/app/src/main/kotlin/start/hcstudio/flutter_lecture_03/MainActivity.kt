package start.hcstudio.flutter_lecture_03

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  private val CHANNEL = "day.flutter/dev"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result -> 
      if (call.method == "open") {
        val open = 10  
        result.success(open)
      } else {
        result.notImplemented()
      }
    }

  }
}
