import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: "day.flutter/dev", binaryMessenger: controller)

    methodChannel.setMethodCallHandler({
      (call: FlutterMethodChannel, result: FlutterResult) -> Void in 

      guard call.method == "open" else {
        result(FlutterMethodNotImplemented)
        return
      }

      result(10)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}