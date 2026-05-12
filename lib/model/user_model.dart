class UserModel {
  final int? userId;
  final int? uniqueUserId;
  final String? name;
  final String? email;
  final String? isdCode;
  final String? phone;
  final String? userType;
  final String? profilePic;
  final int? diamondBalance;
  final String? gender;
  final String? birthday;
  final String? selfIntroduction;
  final String? countryCode;
  final String? countryName;
  final String? profileImage;
  final String? isFollowing;
  final int? totalFollowers;
  final int? totalFollowings;
  final int? totalFriends;
  final String? wealthLevel;
  final int? wealthXp;
  final String? wealthLevelAnimation  ;
  final String? charmLevel  ;
  final int? charmXp;
  final String? charmLevelAnimation  ;
  // final String? garageAnimationFile; // commented out (unused)
  // final String? garageSoundFile; // commented out (unused)
  // final String? frameAnimationFile; // commented out (unused)
  // final String? luckyId; // commented out (unused)
  final bool? isVideoOn;
  final bool? isMicOn;

  final LastLiveActivityModel? lastLiveActivity;

  const UserModel({
    this.userId,
    this.uniqueUserId,
    this.name,
    this.email,
    this.isdCode,
    this.phone,
    this.userType,
    this.profilePic,
    this.diamondBalance,
    this.gender,
    this.birthday,
    this.selfIntroduction,
    this.countryCode,
    this.countryName,
    this.profileImage,
    this.isFollowing,
    this.totalFollowers,
    this.totalFollowings,
    this.totalFriends,
    this.wealthLevel,
    this.wealthXp,
    this.wealthLevelAnimation,
    this.charmLevel,
    this.charmXp,
    this.charmLevelAnimation,
    // this.garageAnimationFile, // commented out (unused)
    // this.garageSoundFile, // commented out (unused)
    // this.frameAnimationFile, // commented out (unused)
    // this.luckyId, // commented out (unused)
    this.isVideoOn,
    this.isMicOn,
    this.lastLiveActivity,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] is int ? json['userId'] as int : null,
      uniqueUserId: json['uniqueUserId'] is String
          ? int.tryParse(json['uniqueUserId'])
          : json['uniqueUserId'],

      name: json['name'] as String?,
      email: json['email'] as String?,
      isdCode: json['isdCode'] as String?,
      phone: json['phone'] as String?,
      userType: json['userType'] as String?,
      profilePic: json['profilePic'] as String?,
      diamondBalance:
          json['diamondBalance'] is int ? json['diamondBalance'] as int : null,
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      selfIntroduction: json['selfIntroduction'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      profileImage: json['profileImage'] as String?,
      isFollowing: json['isFollowing'] as String?,
      totalFollowers: json['totalFollowers'] is int ? json['totalFollowers'] as int : null,
      totalFollowings: json['totalFollowings'] is int ? json['totalFollowings'] as int : null,
      totalFriends: json['totalFriends'] is int ? json['totalFriends'] as int : null,
      wealthLevel: json['wealthLevel'] as String?,
      wealthXp: json['wealthXp'] is int ? json['wealthXp'] as int : null,
      wealthLevelAnimation: json['wealthLevelAnimation'] as String?,
      charmLevel: json['charmLevel'] as String?,
      charmXp: json['charmXp'] is int ? json['charmXp'] as int : null,
      charmLevelAnimation: json['charmLevelAnimation'] as String?,
      // garageAnimationFile: json['garageAnimationFile'] as String?, // commented out (unused)
      // garageSoundFile: json['garageSoundFile'] as String?, // commented out (unused)
      // frameAnimationFile: json['frameAnimationFile'] as String?, // commented out (unused)
      // luckyId: json['luckyId'] as String?, // commented out (unused)
      isVideoOn: json['isVideoOn'] as bool?,
      isMicOn: json['isMicOn'] as bool?,
      lastLiveActivity: json['lastLiveActivity'] != null
          ? LastLiveActivityModel.fromJson(json['lastLiveActivity'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'uniqueUserId': uniqueUserId,
      'name': name,
      'email': email,
      'isdCode': isdCode,
      'phone': phone,
      'userType': userType,
      'profilePic': profilePic,
      'diamondBalance': diamondBalance,
      'gender': gender,
      'birthday': birthday,
      'selfIntroduction': selfIntroduction,
      'countryCode': countryCode,
      'countryName': countryName,
      'profileImage': profileImage,
      'isFollowing': isFollowing,
      'totalFollowers': totalFollowers,
      'totalFollowings': totalFollowings,
      'totalFriends': totalFriends,
      'wealthLevel': wealthLevel,
      'wealthXp': wealthXp,
      'wealthLevelAnimation': wealthLevelAnimation,
      'charmLevel': charmLevel,
      'charmXp': charmXp,
      'charmLevelAnimation': charmLevelAnimation,
      // 'garageAnimationFile': garageAnimationFile, // commented out (unused)
      // 'garageSoundFile': garageSoundFile, // commented out (unused)
      // 'frameAnimationFile': frameAnimationFile, // commented out (unused)
      // 'luckyId': luckyId, // commented out (unused)
      'isVideoOn': isVideoOn,
      'isMicOn': isMicOn,
      'lastLiveActivity': lastLiveActivity?.toJson(),
    };
  }

  UserModel copyWith({
    int? userId,
    int? uniqueUserId,
    String? name,
    String? email,
    String? isdCode,
    String? phone,
    String? userType,
    String? profilePic,
    int? diamondBalance,
    String? gender,
    String? birthday,
    String? selfIntroduction,
    String? countryCode,
    String? countryName,
    String? profileImage,
    String? isFollowing,
    int? totalFollowers,
    int? totalFollowings,
    int? totalFriends,
    String? wealthLevel,
    int? wealthXp,
    String? wealthLevelAnimation,
    String? charmLevel,
    int? charmXp,
    String? charmLevelAnimation,
    bool? isVideoOn,
    bool? isMicOn,
    LastLiveActivityModel? lastLiveActivity,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      uniqueUserId: uniqueUserId ?? this.uniqueUserId,
      name: name ?? this.name,
      email: email ?? this.email,
      isdCode: isdCode ?? this.isdCode,
      phone: phone ?? this.phone,
      userType: userType ?? this.userType,
      profilePic: profilePic ?? this.profilePic,
      diamondBalance: diamondBalance ?? this.diamondBalance,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      selfIntroduction: selfIntroduction ?? this.selfIntroduction,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      profileImage: profileImage ?? this.profileImage,
      isFollowing: isFollowing ?? this.isFollowing,
      totalFollowers: totalFollowers ?? this.totalFollowers,
      totalFollowings: totalFollowings ?? this.totalFollowings,
      totalFriends: totalFriends ?? this.totalFriends,
      wealthLevel: wealthLevel ?? this.wealthLevel,
      wealthXp: wealthXp ?? this.wealthXp,
      wealthLevelAnimation:
      wealthLevelAnimation ?? this.wealthLevelAnimation,
      charmLevel: charmLevel ?? this.charmLevel,
      charmXp: charmXp ?? this.charmXp,
      charmLevelAnimation:
      charmLevelAnimation ?? this.charmLevelAnimation,
      isVideoOn: isVideoOn ?? this.isVideoOn,
      isMicOn: isMicOn ?? this.isMicOn,
      lastLiveActivity: lastLiveActivity ?? this.lastLiveActivity,
    );
  }
}


class LastLiveActivityModel {
  String isLive;
  String lastLiveRoomActivityAt;

  LastLiveActivityModel({
    this.isLive = '0',
    this.lastLiveRoomActivityAt = '',
  });

  factory LastLiveActivityModel.fromJson(Map<String, dynamic> json) {
    return LastLiveActivityModel(
      isLive: json['isLive']?.toString() ?? '0',
      lastLiveRoomActivityAt:
      json['lastLiveRoomActivityAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'isLive': isLive,
    'lastLiveRoomActivityAt': lastLiveRoomActivityAt,
  };
}
