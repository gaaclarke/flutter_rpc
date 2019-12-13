import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: sendMessage)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // This could be auto-generated.
  func sayHello(binaryMessenger : FlutterBinaryMessenger,
                request : HelloRequest,
                completion : @escaping (HelloReply?) -> Void) {
    let channel = FlutterBasicMessageChannel(name: "say-hello", binaryMessenger: binaryMessenger)
    var requestData : Data? = nil
    do {
      requestData = try request.serializedData()
    } catch {
      print(error)
    }
    
    if let requestData = requestData {
      channel.sendMessage(FlutterStandardTypedData.init(bytes: requestData)) {(reply : Any?) in
        var result : HelloReply? = nil
        if let replyData = reply as! FlutterStandardTypedData? {
          do {
            result = try HelloReply.init(serializedData: replyData.data);
          } catch {
            print(error)
          }
        }
        completion(result)
      }
    } else {
      completion(nil)
    }
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
