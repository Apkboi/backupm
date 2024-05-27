import UIKit
import CallKit
import AVFAudio
import PushKit
import Flutter
import flutter_callkit_incoming

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
              let mainQueue = DispatchQueue.main
               let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
               voipRegistry.delegate = self
               voipRegistry.desiredPushTypes = [PKPushType.voIP]
                RTCAudioSession.sharedInstance().useManualAudio = true
                RTCAudioSession.sharedInstance().isAudioEnabled = false
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

}



