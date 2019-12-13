#!/bin/sh
protoc --dart_out=grpc:lib/generated -Iprotos protos/messages.proto
protoc --swift_out=ios/Runner/generated/ protos/messages.proto
