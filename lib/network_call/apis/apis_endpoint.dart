class ApiEndpoints {
  static String get baseUrl =>
      'https://intelligentappsolutionsdemo.com/current-project/website/NewLiveAppApi/public/api/';

  ///////////////////////////////// Auth ///////////////////////////////////

  static final String login = '${baseUrl}auth/login';
  static final String registerSendOtp = '${baseUrl}auth/registerSendOTP';
  static final String register = '${baseUrl}auth/register';
  static final String forgotPassword = '${baseUrl}auth/forgotPassword';
  static final String resetPassword = '${baseUrl}auth/resetPassword';
  static final String socialLogin = '${baseUrl}auth/socialLogin';
  static final String socialRegister = '${baseUrl}auth/socialRegister';
  static final String changePassword = '${baseUrl}changePassword';
  static final String logout = '${baseUrl}auth/logout';

  ///////////////////////////////// Profile ///////////////////////////////////

  static final String updateProfile = '${baseUrl}updateProfile';
  static final String uploadProfileImage = '${baseUrl}uploadProfileImage';
  static final String getMyProfile = '${baseUrl}getMyProfile';
  static String getFollowingList(
          {required int followerId, required int page}) =>
      '${baseUrl}getFollowingList?followerId=$followerId&page=$page';
  static String getFollowerList(
          {required int followingId, required int page}) =>
      '${baseUrl}getFollowerList?followingId=$followingId&page=$page';
  static String getFriendList({required int page}) =>
      '${baseUrl}getFriendList?$page';

  ////////////////////////////////// Mall ////////////////////////////////////

  static String getStoreGarageList({required int page}) =>
      '${baseUrl}getStoreGarageList?page=$page';
  static String getStoreFrameList({required int page}) =>
      '${baseUrl}getStoreFrameList?page=$page';
  static String getStoreLuckyIdList({required int page}) =>
      '${baseUrl}getStoreLuckyIdList?page=$page';
  static final String purchaseStoreItem = '${baseUrl}purchaseStoreItem';
  static final String activateBackpackItem = '${baseUrl}activateBackpackItem';
  static String getStoreBackpackItemList({required String storeType}) =>
      '${baseUrl}getStoreBackpackItemList?storeType=$storeType';
  ////////////////////////////////// home ////////////////////////////////////
  static String getRoomList({required String roomType, required int page}) =>
      '${baseUrl}getRoomList?roomType=$roomType&page=$page';

  //////////////////////////////// search ///////////////////////////////////

  static final String searchUser = '${baseUrl}searchUser';

  //////////////////////////////// Agency Search //////////////////////////////

  static final String searchAgency = '${baseUrl}searchAgency';
  static final String sendLivePermissionRequest = '${baseUrl}sendLivePermissionRequest';

  ///////////////////////////////// Room ///////////////////////////////////

  static final String getGiftCategoryList = '${baseUrl}getGiftCategoryList';
  static final String getThemeList = '${baseUrl}getThemeList';
  static final String startRoom = '${baseUrl}startRoom';
  static String getTotalBeansReceivedByRoomHost(
      {required int userId}) =>
      '${baseUrl}getTotalBeansReceivedByRoomHost?userId=$userId';
  static final String sendGift = '${baseUrl}sendGift';
  static final String checkUserRoomBanStatus =
      '${baseUrl}checkUserRoomBanStatus';
  static final String joinRoomAsAudience = '${baseUrl}joinRoomAsAudience';
  static final String followUser = '${baseUrl}followUser';
  static final String unfollowUser = '${baseUrl}unfollowUser';
  static String getGiftList(
          {required int categoryId, required String categoryType}) =>
      '${baseUrl}getGiftList?categoryId=$categoryId&categoryType=$categoryType';
  static String getRoomSubscriberList(
          {required int roomId,
          required String channelName,
          required String roomType,
          required String streamType}) =>
      '${baseUrl}getRoomSubscriberList?roomId=$roomId&channelName=$channelName&roomType=$roomType&streamType=$streamType';

  static final String updateRoomTheme = '${baseUrl}updateRoomTheme';
  static final String lockUnlockSeat = '${baseUrl}lockUnlockSeat';
  static final String banRoomUser = '${baseUrl}banRoomUser';
  static final String unbanRoomUser = '${baseUrl}unbanRoomUser';
  static String getRoomBannedUserList({required int roomId,required int page,required String role}) =>
      '${baseUrl}getRoomBannedUserList?roomId=$roomId&page=$page&role=$role';
  static final String updateRoomName = '${baseUrl}updateRoomName';
  static final String updateRoomSeatCount = '${baseUrl}updateRoomSeatCount';
  static final String leaveRoom = '${baseUrl}leaveRoom';
  static final String takeSeat = '${baseUrl}takeSeat';
  static final String leaveSeat = '${baseUrl}leaveSeat';
  static final String updateSeatRequestStatus =
      '${baseUrl}updateSeatRequestStatus';
  static final String rejectSeatRequest = '${baseUrl}rejectSeatRequest';
  static final String acceptSeatRequest = '${baseUrl}acceptSeatRequest';
  static final String sendSeatRequest = '${baseUrl}sendSeatRequest';
  static String getOtherUserProfileUrl({required int uniqueUserId}) =>
      '${baseUrl}getOtherUserProfile?uniqueUserId=$uniqueUserId';

  ////////////////////////////////// Leaderboard //////////////////////////////

  static String getHostLeaderboardList(
          {required String timeDuration, required String timeFrame}) =>
      '${baseUrl}getHostLeaderboardList?timeDuration=$timeDuration&timeFrame=$timeFrame';

  static String getRoomGifterLeaderboardList(
      {required String timeDuration, required String timeFrame,required int roomId }) =>
      '${baseUrl}getRoomGifterLeaderboardList?timeDuration=$timeDuration&timeFrame=$timeFrame&roomId=$roomId';

  static String getGifterLeaderboardList(
          {required String timeDuration, required String timeFrame}) =>
      '${baseUrl}getGifterLeaderboardList?timeDuration=$timeDuration&timeFrame=$timeFrame';


  ////////////////////////////////// Setting  //////////////////////////////
  static String getPolicy(
      {required String type}) =>
      '${baseUrl}getPolicy?type=$type';
  static final String getFaqList = '${baseUrl}getFaqList';
  static final String getAboutUs = '${baseUrl}getAboutUs';
  static final String getContactUs = '${baseUrl}getContactUs';
  static final String getBannerList = '${baseUrl}getBannerList';
  static String getTopUpAgencyList(
      { required int page}) =>
      '${baseUrl}getTopUpAgencyList?page=$page';

}
