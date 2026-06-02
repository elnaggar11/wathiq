// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.getUserAuctionsRequestState = RequestState.ideal,
    this.getUserAuctionsError,
    this.getUserAuctionsModel,
    this.auctionBrochureRequestState = RequestState.ideal,
    this.auctionBrochureError,
    this.auctionBrochureMsg,
    this.getFavoriteRequestState = RequestState.ideal,
    this.getFavoriteError,
    this.getFavoriteModel,
    this.privacyPolicyRequestState = RequestState.ideal,
    this.privacyPolicyError,
    this.privacyPolicyModel,
    this.deleteOriginFavoriteRequestState = RequestState.ideal,
    this.deleteOriginFavoriteError,
    this.deleteOriginFavoriteMsg,
    this.getWalletRequestState = RequestState.ideal,
    this.getWalletError,
    this.getWalletModel,
    this.addWalletBalanceRequestState = RequestState.ideal,
    this.addWalletBalanceError,
    this.addWalletBalanceMsg,
    this.propertyPrice = 0,
    this.transactionFee = 0,
    this.commission = 0,
    this.commissionTax = 0,
    this.total = 0,
    this.topBid = 0,
    this.auctionEnrollmentRequestState = RequestState.ideal,
    this.auctionEnrollmentError,
    this.auctionEnrollmentMsg,
    this.deleteAuctionEnrollmentRequestState = RequestState.ideal,
    this.deleteAuctionEnrollmentError,
    this.deleteAuctionEnrollmentMsg,
    this.getAuctionBoardRequestState = RequestState.ideal,
    this.getAuctionBoardError,
    this.getAuctionBoardModel,
    this.addAuctionBidRequestState = RequestState.ideal,
    this.addAuctionBidError,
    this.addAuctionBidMsg,
    this.deleteAuctionFavoriteRequestState = RequestState.ideal,
    this.deleteAuctionFavoriteError,
    this.deleteAuctionFavoriteMsg,
    this.addFavoriteRequestState = RequestState.ideal,
    this.addFavoriteError,
    this.addFavoriteMsg,
    this.auctionsRequestState = RequestState.ideal,
    this.auctionsError,
    this.auctionsModel,
  });

  final RequestState auctionsRequestState;
  final Failure? auctionsError;
  final AuctionsModel? auctionsModel;
  //
  final RequestState getUserAuctionsRequestState;
  final Failure? getUserAuctionsError;
  final AuctionsModel? getUserAuctionsModel;
  //
  final RequestState getFavoriteRequestState;
  final Failure? getFavoriteError;
  final AuctionsModel? getFavoriteModel;
  //
  final RequestState addFavoriteRequestState;
  final Failure? addFavoriteError;
  final String? addFavoriteMsg;
  //
  final RequestState deleteAuctionFavoriteRequestState;
  final Failure? deleteAuctionFavoriteError;
  final String? deleteAuctionFavoriteMsg;
  //
  final RequestState deleteOriginFavoriteRequestState;
  final Failure? deleteOriginFavoriteError;
  final String? deleteOriginFavoriteMsg;
  //
  final RequestState auctionEnrollmentRequestState;
  final Failure? auctionEnrollmentError;
  final String? auctionEnrollmentMsg;
  //
  final RequestState deleteAuctionEnrollmentRequestState;
  final Failure? deleteAuctionEnrollmentError;
  final String? deleteAuctionEnrollmentMsg;
  //
  final RequestState getAuctionBoardRequestState;
  final Failure? getAuctionBoardError;
  final AuctionBoardModel? getAuctionBoardModel;
  //
  final RequestState addAuctionBidRequestState;
  final Failure? addAuctionBidError;
  final String? addAuctionBidMsg;
  //
  final RequestState getWalletRequestState;
  final Failure? getWalletError;
  final WalletModel? getWalletModel;
  //
  final RequestState privacyPolicyRequestState;
  final Failure? privacyPolicyError;
  final PrivacyModel? privacyPolicyModel;
  //
  final RequestState auctionBrochureRequestState;
  final Failure? auctionBrochureError;
  final String? auctionBrochureMsg;
  //
  final RequestState addWalletBalanceRequestState;
  final Failure? addWalletBalanceError;
  final String? addWalletBalanceMsg;
  //
  final double propertyPrice;
  final double transactionFee;
  final double commission;
  final double commissionTax;
  final double total;
  final dynamic topBid;

  @override
  List<Object?> get props => [
        getUserAuctionsRequestState,
        getUserAuctionsError,
        getUserAuctionsModel,
        auctionBrochureRequestState,
        auctionBrochureError,
        auctionBrochureMsg,
        getFavoriteRequestState,
        getFavoriteError,
        getFavoriteModel,
        privacyPolicyRequestState,
        privacyPolicyError,
        privacyPolicyModel,
        deleteOriginFavoriteRequestState,
        deleteOriginFavoriteError,
        deleteOriginFavoriteMsg,
        getWalletRequestState,
        getWalletError,
        getWalletModel,
        addWalletBalanceRequestState,
        addWalletBalanceError,
        addWalletBalanceMsg,
        topBid,
        propertyPrice,
        transactionFee,
        commission,
        commissionTax,
        total,
        deleteAuctionFavoriteError,
        deleteAuctionFavoriteMsg,
        deleteAuctionFavoriteRequestState,
        addFavoriteError,
        addFavoriteMsg,
        addFavoriteRequestState,
        auctionsRequestState,
        auctionsError,
        auctionsModel,
        auctionEnrollmentRequestState,
        auctionEnrollmentError,
        auctionEnrollmentMsg,
        deleteAuctionEnrollmentRequestState,
        deleteAuctionEnrollmentError,
        deleteAuctionEnrollmentMsg,
        getAuctionBoardRequestState,
        getAuctionBoardError,
        getAuctionBoardModel,
        addAuctionBidRequestState,
        addAuctionBidError,
        addAuctionBidMsg,
      ];

  HomeState copyWith({
    RequestState? auctionsRequestState,
    Failure? auctionsError,
    AuctionsModel? auctionsModel,
    RequestState? getUserAuctionsRequestState,
    Failure? getUserAuctionsError,
    AuctionsModel? getUserAuctionsModel,
    RequestState? getFavoriteRequestState,
    Failure? getFavoriteError,
    AuctionsModel? getFavoriteModel,
    RequestState? addFavoriteRequestState,
    Failure? addFavoriteError,
    String? addFavoriteMsg,
    RequestState? deleteAuctionFavoriteRequestState,
    Failure? deleteAuctionFavoriteError,
    String? deleteAuctionFavoriteMsg,
    RequestState? deleteOriginFavoriteRequestState,
    Failure? deleteOriginFavoriteError,
    String? deleteOriginFavoriteMsg,
    RequestState? auctionEnrollmentRequestState,
    Failure? auctionEnrollmentError,
    String? auctionEnrollmentMsg,
    RequestState? deleteAuctionEnrollmentRequestState,
    Failure? deleteAuctionEnrollmentError,
    String? deleteAuctionEnrollmentMsg,
    RequestState? getAuctionBoardRequestState,
    Failure? getAuctionBoardError,
    AuctionBoardModel? getAuctionBoardModel,
    RequestState? addAuctionBidRequestState,
    Failure? addAuctionBidError,
    String? addAuctionBidMsg,
    RequestState? getWalletRequestState,
    Failure? getWalletError,
    WalletModel? getWalletModel,
    RequestState? privacyPolicyRequestState,
    Failure? privacyPolicyError,
    PrivacyModel? privacyPolicyModel,
    RequestState? auctionBrochureRequestState,
    Failure? auctionBrochureError,
    String? auctionBrochureMsg,
    RequestState? addWalletBalanceRequestState,
    Failure? addWalletBalanceError,
    String? addWalletBalanceMsg,
    double? propertyPrice,
    double? transactionFee,
    double? commission,
    double? commissionTax,
    double? total,
    dynamic topBid,
  }) {
    return HomeState(
      auctionsRequestState: auctionsRequestState ?? this.auctionsRequestState,
      auctionsError: auctionsError ?? this.auctionsError,
      auctionsModel: auctionsModel ?? this.auctionsModel,
      getUserAuctionsRequestState:
          getUserAuctionsRequestState ?? this.getUserAuctionsRequestState,
      getUserAuctionsError: getUserAuctionsError ?? this.getUserAuctionsError,
      getUserAuctionsModel: getUserAuctionsModel ?? this.getUserAuctionsModel,
      getFavoriteRequestState:
          getFavoriteRequestState ?? this.getFavoriteRequestState,
      getFavoriteError: getFavoriteError ?? this.getFavoriteError,
      getFavoriteModel: getFavoriteModel ?? this.getFavoriteModel,
      addFavoriteRequestState:
          addFavoriteRequestState ?? this.addFavoriteRequestState,
      addFavoriteError: addFavoriteError ?? this.addFavoriteError,
      addFavoriteMsg: addFavoriteMsg ?? this.addFavoriteMsg,
      deleteAuctionFavoriteRequestState: deleteAuctionFavoriteRequestState ??
          this.deleteAuctionFavoriteRequestState,
      deleteAuctionFavoriteError:
          deleteAuctionFavoriteError ?? this.deleteAuctionFavoriteError,
      deleteAuctionFavoriteMsg:
          deleteAuctionFavoriteMsg ?? this.deleteAuctionFavoriteMsg,
      deleteOriginFavoriteRequestState: deleteOriginFavoriteRequestState ??
          this.deleteOriginFavoriteRequestState,
      deleteOriginFavoriteError:
          deleteOriginFavoriteError ?? this.deleteOriginFavoriteError,
      deleteOriginFavoriteMsg:
          deleteOriginFavoriteMsg ?? this.deleteOriginFavoriteMsg,
      auctionEnrollmentRequestState:
          auctionEnrollmentRequestState ?? this.auctionEnrollmentRequestState,
      auctionEnrollmentError:
          auctionEnrollmentError ?? this.auctionEnrollmentError,
      auctionEnrollmentMsg: auctionEnrollmentMsg ?? this.auctionEnrollmentMsg,
      deleteAuctionEnrollmentRequestState:
          deleteAuctionEnrollmentRequestState ??
              this.deleteAuctionEnrollmentRequestState,
      deleteAuctionEnrollmentError:
          deleteAuctionEnrollmentError ?? this.deleteAuctionEnrollmentError,
      deleteAuctionEnrollmentMsg:
          deleteAuctionEnrollmentMsg ?? this.deleteAuctionEnrollmentMsg,
      getAuctionBoardRequestState:
          getAuctionBoardRequestState ?? this.getAuctionBoardRequestState,
      getAuctionBoardError: getAuctionBoardError ?? this.getAuctionBoardError,
      getAuctionBoardModel: getAuctionBoardModel ?? this.getAuctionBoardModel,
      addAuctionBidRequestState:
          addAuctionBidRequestState ?? this.addAuctionBidRequestState,
      addAuctionBidError: addAuctionBidError ?? this.addAuctionBidError,
      addAuctionBidMsg: addAuctionBidMsg ?? this.addAuctionBidMsg,
      getWalletRequestState:
          getWalletRequestState ?? this.getWalletRequestState,
      getWalletError: getWalletError ?? this.getWalletError,
      getWalletModel: getWalletModel ?? this.getWalletModel,
      privacyPolicyRequestState:
          privacyPolicyRequestState ?? this.privacyPolicyRequestState,
      privacyPolicyError: privacyPolicyError ?? this.privacyPolicyError,
      privacyPolicyModel: privacyPolicyModel ?? this.privacyPolicyModel,
      auctionBrochureRequestState:
          auctionBrochureRequestState ?? this.auctionBrochureRequestState,
      auctionBrochureError: auctionBrochureError ?? this.auctionBrochureError,
      auctionBrochureMsg: auctionBrochureMsg ?? this.auctionBrochureMsg,
      addWalletBalanceRequestState:
          addWalletBalanceRequestState ?? this.addWalletBalanceRequestState,
      addWalletBalanceError:
          addWalletBalanceError ?? this.addWalletBalanceError,
      addWalletBalanceMsg: addWalletBalanceMsg ?? this.addWalletBalanceMsg,
      propertyPrice: propertyPrice ?? this.propertyPrice,
      transactionFee: transactionFee ?? this.transactionFee,
      commission: commission ?? this.commission,
      commissionTax: commissionTax ?? this.commissionTax,
      total: total ?? this.total,
      topBid: topBid ?? this.topBid,
    );
  }
}
