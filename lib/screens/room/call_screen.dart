import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:poly_club/controllers/profile/profile_controller.dart';
import 'package:poly_club/models/room_model.dart';
import 'package:poly_club/values/colors.dart';
import 'package:poly_club/widgets/loading_indicator.dart';

class CallScreen extends StatefulWidget {
  final Room room;

  const CallScreen({Key? key, required this.room}) : super(key: key);
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final String iosAppBarRGBAColor = MyColors.primary.toString();

  var isAudioOnly = false;
  var isAudioMuted = true;
  var isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(
      JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onPictureInPictureWillEnter: _onPictureInPictureWillEnter,
        onPictureInPictureTerminated: _onPictureInPictureTerminated,
        onError: _onError,
      ),
    );

    _joinMeeting();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyLoadingIndicator.circular(),
    );
  }

  ProfileController accountController = Get.find<ProfileController>();

  void _joinMeeting() async {
    final String serverText = '';

    // channel id
    final String roomText =
        widget.room.id ?? widget.room.name?.replaceAll(' ', '') ?? '';

    final String subjectText = widget.room.name ?? '';

    final String nameText = accountController.user.value.name ?? 'Fulan';
    final String emailText = accountController.user.value.username ??
        accountController.user.value.email ??
        '';

    final String avatarURL = accountController.user.value.avatar ?? '';

    String? serverUrl = serverText.trim().isEmpty ? null : serverText;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      FeatureFlagEnum.RECORDING_ENABLED: false,
      FeatureFlagEnum.IOS_RECORDING_ENABLED: false,
      FeatureFlagEnum.PIP_ENABLED: false,
      FeatureFlagEnum.INVITE_ENABLED: false,
      FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED: false,
      FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
    };

    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }

    print('AVATARRR $avatarURL');

    // Define meetings options here
    var options = JitsiMeetingOptions(room: roomText)
      ..serverURL = serverUrl
      ..subject = subjectText
      ..userDisplayName = nameText
      ..userEmail = emailText
      ..userAvatarURL = avatarURL
      ..iosAppBarRGBAColor = iosAppBarRGBAColor
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": roomText,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin(Map<dynamic, dynamic>? message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(Map<dynamic, dynamic>? message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(Map<dynamic, dynamic>? message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
    Get.back();
  }

  void _onPictureInPictureWillEnter(Map<dynamic, dynamic> message) {
    debugPrint(
        "_onPictureInPictureWillEnter broadcasted with message: $message");
  }

  void _onPictureInPictureTerminated(Map<dynamic, dynamic> message) {
    debugPrint(
        "_onPictureInPictureTerminated broadcasted with message: $message");
  }

  void _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
