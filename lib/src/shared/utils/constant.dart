
import 'package:flutter/material.dart';

bool isStandalone = false;
GlobalKey<NavigatorState>? rootNavKey;

const String defaultAddress =
    'https://paul21.gescom.aurorecloudxds.com/api/local/gescom';
const String fakeToken =
    'eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMDY5ZjA2ZC1hOGQ4LTRjMGQtOGY2My0xNWNhNmU0Yzg3MGIiLCJzdWIiOiJwYXVsMjEiLCJzY29wZXMiOltdLCJpYXQiOjE3NDQ3OTMyMDAsImV4cCI6NjkyODc5MzIwMCwidGVuYW50SWQiOiJwYXVsMjEiLCJsYW5ndWUiOiJGUiIsInVzZXJOYW1lIjoicGF1bDIxIiwidXNlcklkIjoiMiIsImVtYWlsIjoiamlvemFuZ3RoZW9waGFuZXBhdWwyM0BnbWFpbC5jb20ifQ.03X-XYaL4nn0uCfS_KxhAjlbXE6eexZiw4cyiBNnBeTd_RmApMgHE3QRB4aHcoRkk2kVq4ezOhRQtSn-JuLoSw';
const String fakeTenant = 'paul21';
