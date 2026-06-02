// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  const WalletState({
    this.getWalletRequestState = RequestState.ideal,
    this.getWalletError,
    this.getWalletModel,
    this.getHeldFundsRequestState = RequestState.ideal,
    this.getHeldFundsError,
    this.getHeldFundsModel,
    this.privacyPolicyRequestState = RequestState.ideal,
    this.privacyPolicyError,
    this.privacyPolicyModel,
    this.auctionBrochureRequestState = RequestState.ideal,
    this.auctionBrochureError,
    this.auctionBrochureMsg,
    this.addWalletBalanceRequestState = RequestState.ideal,
    this.addWalletBalanceError,
    this.addWalletBalanceMsg,
    this.submitWithdrawRequestState = RequestState.ideal,
    this.submitWithdrawError,
    this.submitWithdrawMsg,
    this.getWithdrawRequestState = RequestState.ideal,
    this.getWithdrawError,
    this.getWithdrawModel,
    this.getUserInvoicesRequestState = RequestState.ideal,
    this.getUserInvoicesError,
    this.getUserInvoicesModel,
  });
  //
  final RequestState getWalletRequestState;
  final Failure? getWalletError;
  final WalletModel? getWalletModel;
  //
  final RequestState getHeldFundsRequestState;
  final Failure? getHeldFundsError;
  final HeldModel? getHeldFundsModel;
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
  final RequestState submitWithdrawRequestState;
  final Failure? submitWithdrawError;
  final String? submitWithdrawMsg;
  //
  final RequestState getWithdrawRequestState;
  final Failure? getWithdrawError;
  final WithdrawModel? getWithdrawModel;
  //
  final RequestState getUserInvoicesRequestState;
  final Failure? getUserInvoicesError;
  final InvoiceModel? getUserInvoicesModel;
  @override
  List<Object?> get props => [
        this.getWalletRequestState,
        this.getWalletError,
        this.getWalletModel,
        this.getHeldFundsRequestState,
        this.getHeldFundsError,
        this.getHeldFundsModel,
        this.privacyPolicyRequestState,
        this.privacyPolicyError,
        this.privacyPolicyModel,
        this.auctionBrochureRequestState,
        this.auctionBrochureError,
        this.auctionBrochureMsg,
        this.addWalletBalanceRequestState,
        this.addWalletBalanceError,
        this.addWalletBalanceMsg,
        this.submitWithdrawRequestState,
        this.submitWithdrawError,
        this.submitWithdrawMsg,
        this.getWithdrawRequestState,
        this.getWithdrawError,
        this.getWithdrawModel,
        this.getUserInvoicesRequestState,
        this.getUserInvoicesError,
        this.getUserInvoicesModel,
      ];

  WalletState copyWith({
    RequestState? getWalletRequestState,
    Failure? getWalletError,
    WalletModel? getWalletModel,
    RequestState? getHeldFundsRequestState,
    Failure? getHeldFundsError,
    HeldModel? getHeldFundsModel,
    RequestState? privacyPolicyRequestState,
    Failure? privacyPolicyError,
    PrivacyModel? privacyPolicyModel,
    RequestState? auctionBrochureRequestState,
    Failure? auctionBrochureError,
    String? auctionBrochureMsg,
    RequestState? addWalletBalanceRequestState,
    Failure? addWalletBalanceError,
    String? addWalletBalanceMsg,
    RequestState? submitWithdrawRequestState,
    Failure? submitWithdrawError,
    String? submitWithdrawMsg,
    RequestState? getWithdrawRequestState,
    Failure? getWithdrawError,
    WithdrawModel? getWithdrawModel,
    RequestState? getUserInvoicesRequestState,
    Failure? getUserInvoicesError,
    InvoiceModel? getUserInvoicesModel,
  }) {
    return WalletState(
      getWalletRequestState:
          getWalletRequestState ?? this.getWalletRequestState,
      getWalletError: getWalletError ?? this.getWalletError,
      getWalletModel: getWalletModel ?? this.getWalletModel,
      getHeldFundsRequestState:
          getHeldFundsRequestState ?? this.getHeldFundsRequestState,
      getHeldFundsError: getHeldFundsError ?? this.getHeldFundsError,
      getHeldFundsModel: getHeldFundsModel ?? this.getHeldFundsModel,
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
      submitWithdrawRequestState:
          submitWithdrawRequestState ?? this.submitWithdrawRequestState,
      submitWithdrawError: submitWithdrawError ?? this.submitWithdrawError,
      submitWithdrawMsg: submitWithdrawMsg ?? this.submitWithdrawMsg,
      getWithdrawRequestState:
          getWithdrawRequestState ?? this.getWithdrawRequestState,
      getWithdrawError: getWithdrawError ?? this.getWithdrawError,
      getWithdrawModel: getWithdrawModel ?? this.getWithdrawModel,
      getUserInvoicesRequestState:
          getUserInvoicesRequestState ?? this.getUserInvoicesRequestState,
      getUserInvoicesError: getUserInvoicesError ?? this.getUserInvoicesError,
      getUserInvoicesModel: getUserInvoicesModel ?? this.getUserInvoicesModel,
    );
  }
}
