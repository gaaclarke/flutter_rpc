import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    setupFlutterRpc()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: sendMessage)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func setupFlutterRpc() {
    let vc = self.window.rootViewController as! FlutterViewController
    let binaryMessenger = vc.engine!.binaryMessenger
    setupSayGoodbye(binaryMessenger: binaryMessenger, function: sayGoodbye)
  }

  func sayGoodbye(request: HelloRequest) -> HelloReply {
    print("Goodbye from " + request.name)
    var reply = HelloReply()
    reply.message = "Message received from swift!"
    return reply
  }

  func sendMessage() {
    print("Send message")
    let vc = self.window.rootViewController as! FlutterViewController
    let binaryMessenger = vc.engine!.binaryMessenger

    var request = HelloRequest()
    request.name = "IosHost"
    sayHello(binaryMessenger: binaryMessenger, request: request) { (helloReply) in
      if let helloReply = helloReply {
        print(helloReply.message)
      }
    }
  }
}
