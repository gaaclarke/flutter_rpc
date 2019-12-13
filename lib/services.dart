// This file should be auto-generated.  Currently it is handmade.

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_rpc/generated/messages.pb.dart';

typedef SayHelloFunction = HelloReply Function(HelloRequest);
void setupSayHello(SayHelloFunction func) {
  BasicMessageChannel channel = BasicMessageChannel("say-hello", const StandardMessageCodec());
  channel.setMessageHandler((data) async {
    return func(HelloRequest.fromBuffer(data)).writeToBuffer();
  });
}

Future<HelloReply> sayGoodbye(HelloRequest request) async {
  BasicMessageChannel channel = BasicMessageChannel("say-goodbye", const StandardMessageCodec());
  Uint8List serializedRequest = request.writeToBuffer();
  Uint8List serializedResponse = await channel.send(serializedRequest);
  return HelloReply.fromBuffer(serializedResponse);
}
