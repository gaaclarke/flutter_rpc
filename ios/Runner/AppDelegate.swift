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

  // This could be auto-generated.
  func setupSayGoodbye(binaryMessenger: FlutterBinaryMessenger,
                       function: @escaping (HelloRequest) -> HelloReply) {
    let channel = FlutterBasicMessageChannel(name: "say-goodbye", binaryMessenger: binaryMessenger)
    channel.setMessageHandler { (message, callback) in
      var callbackData : Any? = nil
      if let data = message as! FlutterStandardTypedData? {
        do {
          let request = try HelloRequest.init(serializedData: data.data)
          let reply = function(request)
          let serializedReply = try reply.serializedData()
          callbackData = FlutterStandardTypedData.init(bytes: serializedReply)
        } catch {
          print(error)
        }
      }
      callback(callbackData)
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
