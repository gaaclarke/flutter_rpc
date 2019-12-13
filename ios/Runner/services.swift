// This file should be auto-generated.  Currently it is handmade.

import Foundation
import Flutter

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
