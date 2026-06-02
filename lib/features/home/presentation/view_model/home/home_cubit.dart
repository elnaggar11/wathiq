import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wathiq/core/params/home/auctions_params.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/features/home/data/models/enrolle/privacy_model.dart';
import 'package:wathiq/features/home/data/repository/home_repo.dart';

import '../../../../../app/injector.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/functions/format_number.dart';
import '../../../../../core/functions/url_luncher.dart';
import '../../../../../core/params/home/add_favorite_params.dart';
import '../../../../../core/params/home/auction_enrollment_params.dart';
import '../../../../../core/storage/i_app_local_storage.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../wallet/data/model/add_wallet_balance.dart';
import '../../../data/models/auctions_model/auctions_model.dart';
import '../../../data/models/enrolle/auction_board_model.dart';
import '../../../data/socket/auction_board_socket.dart';

part 'home_state.dart';

String KoriginId = '';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeState());

  final HomeRepository _homeRepository;

  String auctionsStatus = AppStrings.auctionsOnGoing;
  String LastHomeAuctionsStatus = AppStrings.auctionsOnGoing;
  AuctionData? auctionData;
  AuctionOrigin? auctionOrigin;
  List<AuctionOrigin> originList = [];
  GeneralAuctionParams? addFavoriteParams;
  TextEditingController originSearch = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController auctionFilterSearch = TextEditingController();

  String auctionId = '';
  String? originId = '';
  double? amount;
  int? limit = 6;
  dynamic garlicDifferencetotalAmount;
  //
  bool winner = false;
  bool loss = false;
  //
  String shareAs = AppStrings.enrollShareAsGenuine;
  String type = AppStrings.enrolltypeOnline;
  String? filterAuctiontype;
  String? filterAuctiontypeAr;
  String? agencyId;
  List<BiderAuctionData> boardAuctionData = [];
  final auctionBoardSocket = AuctionBoardSocket();
  final addBalanceKey = GlobalKey<FormState>();
  final Map<String, AuctionsModel> userAuctionsCache = {};
  final Map<String, AuctionsModel> auctionsCache = {}; // status -> data

  Future<void> getAuctions() async {
    final cachedModel = auctionsCache[auctionsStatus];

    if (cachedModel != null) {
      // 1. 🚀 Show cached data immediately without loading
      emit(state.copyWith(
        auctionsModel: cachedModel,
        auctionsRequestState: RequestState.loaded,
      ));
    } else {
      // 2. 🤔 No cache? then show loading state
      emit(state.copyWith(
        auctionsRequestState: RequestState.loading,
      ));
    }

    // 3. 🔥 Always fetch from server in background
    AuctionsParams auctionsParams = AuctionsParams(
      status: auctionsStatus,
      search: auctionFilterSearch.text,
      type: filterAuctiontype,
    );

    final result = await _homeRepository.getAuctions(auctionsParams);

    result.fold(
      (failure) {
        // Only show error if no cache existed (first time)

        emit(state.copyWith(
          auctionsRequestState: RequestState.error,
          auctionsError: failure,
        ));

        log(failure.toString());
      },
      (freshModel) {
        if (!_isAuctionsModelSame(cachedModel, freshModel)) {
          // 4. ✨ If fresh data is different, update cache and UI
          emit(state.copyWith(
            auctionsRequestState: RequestState.loading,
          ));
          auctionsCache[auctionsStatus] = freshModel;
          emit(state.copyWith(
            auctionsRequestState: RequestState.loaded,
            auctionsModel: freshModel,
          ));
        }
        // else: if fresh data is same, do nothing! 🎯
      },
    );
  }

  bool _isAuctionsModelSame(AuctionsModel? oldModel, AuctionsModel newModel) {
    if (oldModel == null) return false;
    return oldModel == newModel;
  }

  Future<void> refreshAuctionsForTab() async {
    auctionsCache.remove(auctionsStatus);
    await getAuctions();
  }

  // New method: get user auctions with cache
  Future<void> getUserAuctions() async {
    String cacheKey = '${winner}_${loss}'; // simple unique key per tab

    // Check if data is cached
    if (userAuctionsCache.containsKey(cacheKey)) {
      emit(state.copyWith(
        getUserAuctionsModel: userAuctionsCache[cacheKey],
        getUserAuctionsRequestState: RequestState.loaded,
      ));
      return;
    }

    emit(state.copyWith(getUserAuctionsRequestState: RequestState.loading));

    UserAuctionsParams userAuctionsParams = UserAuctionsParams(
      loss: loss,
      winner: winner,
    );

    final result = await _homeRepository.getUserAuctions(userAuctionsParams);

    result.fold(
      (failure) {
        emit(state.copyWith(
          getUserAuctionsRequestState: RequestState.error,
          getUserAuctionsError: failure,
        ));
        log(failure.toString());
      },
      (model) {
        userAuctionsCache[cacheKey] = model; // 🛜 Save in cache
        emit(state.copyWith(
          getUserAuctionsRequestState: RequestState.loaded,
          getUserAuctionsModel: model,
        ));
      },
    );
  }

  // Optional: force refresh if needed
  Future<void> refreshUserAuctions() async {
    String cacheKey = '${winner}_${loss}';
    userAuctionsCache.remove(cacheKey);
    await getUserAuctions();
  }

  searchAuctionOrigins(String? query) {
    emit(state.copyWith(auctionsRequestState: RequestState.loading));

    if (query == null || query.isEmpty) {
      originList = auctionData!.auctionOrigins;
      emit(
        state.copyWith(
          auctionsRequestState: RequestState.loaded,
        ),
      );
      return;
    }

    originList = auctionData!.auctionOrigins
        .where((origin) =>
            origin.title != null &&
            origin.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(
      state.copyWith(
        auctionsRequestState: RequestState.loaded,
      ),
    );
  }

  void getFavorite([bool isLoading = true]) async {
    emit(state.copyWith(getFavoriteRequestState: RequestState.loading));
    final result = await _homeRepository.getFavorite();

    result.fold(
      (failure) {
        emit(state.copyWith(
          getFavoriteRequestState: RequestState.error,
          getFavoriteError: failure,
        ));
        log(failure.toString());
      },
      (model) {
        emit(
          state.copyWith(
            getFavoriteRequestState: RequestState.loaded,
            getFavoriteModel: model,
          ),
        );
        getAuctions();
      },
    );
  }

  void addFavorite() async {
    emit(state.copyWith(addFavoriteRequestState: RequestState.loading));

    final result = await _homeRepository.addFavorite(addFavoriteParams!);

    result.fold(
      (failure) {
        print('state.addFavoriteError == RequestState.error');
        emit(state.copyWith(
          addFavoriteRequestState: RequestState.error,
          addFavoriteError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        emit(
          state.copyWith(
            addFavoriteRequestState: RequestState.loaded,
            addFavoriteMsg: right,
          ),
        );
      },
    );
  }

  void deleteAuctionFavorite(String auctionId) async {
    emit(state.copyWith(
        deleteAuctionFavoriteRequestState: RequestState.loading));

    final result = await _homeRepository.deleteAuctionFavorite(auctionId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          deleteAuctionFavoriteRequestState: RequestState.error,
          deleteAuctionFavoriteError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        emit(
          state.copyWith(
            deleteAuctionFavoriteRequestState: RequestState.loaded,
            deleteAuctionFavoriteMsg: right,
          ),
        );
      },
    );
  }

  void deleteOriginFavorite() async {
    emit(
        state.copyWith(deleteOriginFavoriteRequestState: RequestState.loading));
    GeneralAuctionParams params = GeneralAuctionParams(
        auctionId: auctionId, originId: originId, amount: amount, limit: limit);
    final result = await _homeRepository.deleteOriginFavorite(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          deleteOriginFavoriteRequestState: RequestState.error,
          deleteOriginFavoriteError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        emit(
          state.copyWith(
            deleteOriginFavoriteRequestState: RequestState.loaded,
            deleteOriginFavoriteMsg: right,
          ),
        );
      },
    );
  }

  void auctionEnrollment() async {
    emit(state.copyWith(auctionEnrollmentRequestState: RequestState.loading));
    AuctionEnrollmentParams params = AuctionEnrollmentParams(
      auction: auctionId,
      auctionOrigin: originId!,
      shareAs: shareAs,
      type: type,
      agency: agencyId,
    );

    final result = await _homeRepository.auctionEnrollment(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          auctionEnrollmentRequestState: RequestState.error,
          auctionEnrollmentError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        auctionOrigin!.isEnrolled = true;
        int index = auctionData!.auctionOrigins.indexWhere(
          (element) => element.id == auctionOrigin!.id,
        );
        auctionData!.auctionOrigins[index].isEnrolled == true;
        emit(
          state.copyWith(
            auctionEnrollmentRequestState: RequestState.loaded,
            auctionEnrollmentMsg: right,
          ),
        );
        getAuctionBoard().then((val) {
          addNewBidValue();
        });
      },
    );
  }

  void deleteAuctionEnrollment() async {
    emit(state.copyWith(
        deleteAuctionEnrollmentRequestState: RequestState.loading));
    GeneralAuctionParams params = GeneralAuctionParams(
        auctionId: auctionId, originId: originId, amount: amount, limit: limit);

    final result = await _homeRepository.deleteAuctionEnrollment(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          deleteAuctionEnrollmentRequestState: RequestState.error,
          deleteAuctionEnrollmentError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        auctionOrigin!.isEnrolled = false;
        int index = auctionData!.auctionOrigins.indexWhere(
          (element) => element.id == auctionOrigin!.id,
        );
        auctionData!.auctionOrigins[index].isEnrolled == false;
        emit(
          state.copyWith(
            deleteAuctionEnrollmentRequestState: RequestState.loaded,
            deleteAuctionEnrollmentMsg: right,
          ),
        );

        getAuctionBoard();
      },
    );
  }

  Future<void> getAuctionBoard() async {
    emit(state.copyWith(getAuctionBoardRequestState: RequestState.loading));
    GeneralAuctionParams params = GeneralAuctionParams(
        auctionId: auctionId, originId: originId, amount: amount, limit: limit);

    final result = await _homeRepository.getAuctionBoard(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          getAuctionBoardRequestState: RequestState.error,
          getAuctionBoardError: failure,
        ));
        log(failure.toString());
      },
      (right) async {
        boardAuctionData = right.data;
        if (state.topBid == 0 || state.topBid == null) {
          emit(
            state.copyWith(
              topBid: (boardAuctionData.isEmpty
                  ? auctionOrigin!.openingPrice
                  : boardAuctionData.first.bidAmount),
              getAuctionBoardRequestState: RequestState.loaded,
              getAuctionBoardModel: right,
            ),
          );
        } else {
          emit(
            state.copyWith(
              getAuctionBoardRequestState: RequestState.loaded,
              getAuctionBoardModel: right,
            ),
          );
        }

        await auctionBoardSocket.listenEvents();
        newBider();
      },
    );
  }

  void newBider() async {
    auctionBoardSocket.newBidersController.listen(
      (biders) {
        print('Received biders: ${biders.data}');
        print('Before updating, boardAuctionData: $boardAuctionData');

        if (biders.data.isNotEmpty) {
          boardAuctionData.clear();
          boardAuctionData.addAll(biders.data);
          print('After updating, boardAuctionData: $boardAuctionData');

          if (!isClosed)
            emit(state.copyWith(
              getAuctionBoardRequestState: RequestState.loaded,
              getAuctionBoardModel: biders,
            ));
        } else {
          print('Received biders is empty');
        }
      },
    );
  }

  void addAuctionBid() async {
    emit(state.copyWith(addAuctionBidRequestState: RequestState.loading));
    dynamic amount = await calculateBidAmount();
    GeneralAuctionParams params = GeneralAuctionParams(
      auctionId: auctionData!.id,
      originId: auctionOrigin!.id,
      amount: amount,
      limit: limit,
    );

    final result = await _homeRepository.addAuctionBid(params);

    result.fold(
      (failure) {
        emit(state.copyWith(
          addAuctionBidRequestState: RequestState.error,
          addAuctionBidError: failure,
        ));
        log(failure.toString());
      },
      (right) async {
        emit(
          state.copyWith(
            addAuctionBidRequestState: RequestState.loaded,
            addAuctionBidMsg: right,
          ),
        );
        await getAuctionBoard();
      },
    );
    limit = 6;
  }

  Future<dynamic> calculateBidAmount() async {
    String userId =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.userId);
    print('userId $userId');

    limit = null;
    await getAuctionBoard();
    bool isUserInList = boardAuctionData.any((bid) => bid.user.id == userId);

    if (boardAuctionData.isEmpty) {
      dynamic amount = garlicDifferencetotalAmount;
      return amount;
    } else if (!isUserInList) {
      dynamic amount =
          (boardAuctionData.first.bidAmount - auctionOrigin!.openingPrice) +
              garlicDifferencetotalAmount;
      return amount;
    } else {
      BiderAuctionData userBid =
          boardAuctionData.firstWhere((bid) => bid.user.id == userId);
      print(
          'boardAuctionData.first.bidAmount${boardAuctionData.first.bidAmount} ');
      print('userBid.bidAmount${userBid.bidAmount} ');
      print('garlicDifferencetotalAmount${garlicDifferencetotalAmount} ');
      print(
          'boardAuctionData.first.bidAmount${boardAuctionData.first.bidAmount} ');
      dynamic amount = ((boardAuctionData.first.bidAmount - userBid.bidAmount) +
          garlicDifferencetotalAmount);

      return amount;
    }
  }

  ///(506-471) + (611 -506 )

  Future<void> getWallet() async {
    emit(state.copyWith(getWalletRequestState: RequestState.loading));

    final result = await _homeRepository.getWallet();

    result.fold(
      (failure) {
        emit(state.copyWith(
          getWalletRequestState: RequestState.error,
          getWalletError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        emit(
          state.copyWith(
            getWalletRequestState: RequestState.loaded,
            getWalletModel: right,
          ),
        );
      },
    );
  }

  Future<void> privacyPolicy() async {
    emit(state.copyWith(privacyPolicyRequestState: RequestState.loading));

    final result = await _homeRepository.privacyPolicy();

    result.fold(
      (failure) {
        emit(state.copyWith(
          privacyPolicyRequestState: RequestState.error,
          privacyPolicyError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        emit(
          state.copyWith(
            privacyPolicyRequestState: RequestState.loaded,
            privacyPolicyModel: right,
          ),
        );
      },
    );
  }

  Future<void> auctionBrochure(
    BuildContext context,
  ) async {
    emit(state.copyWith(auctionBrochureRequestState: RequestState.loading));

    final result =
        await downloadFile(auctionData!.auctionBrochure ?? '', context);

    result.fold(
      (failure) {
        emit(state.copyWith(
          auctionBrochureRequestState: RequestState.error,
          auctionBrochureError: failure,
        ));
        log(failure.message.toString());
      },
      (right) {
        emit(
          state.copyWith(
            auctionBrochureRequestState: RequestState.loaded,
            auctionBrochureMsg: right,
          ),
        );
      },
    );
  }

  void addWalletBalance() async {
    if (!addBalanceKey.currentState!.validate()) return;

    emit(state.copyWith(addWalletBalanceRequestState: RequestState.loading));

    final result = await _homeRepository
        .addWalletBalance(parseFormattedNumber(balanceController.text.trim()));

    result.fold(
      (failure) {
        emit(state.copyWith(
          addWalletBalanceRequestState: RequestState.error,
          addWalletBalanceError: failure,
        ));
        log(failure.toString());
      },
      (right) async {
        await getWallet();
        emit(
          state.copyWith(
            addWalletBalanceRequestState: RequestState.loaded,
            addWalletBalanceMsg: right,
          ),
        );
      },
    );
  }

  void updatePropertyPrice(dynamic price) {
    // Calculations
    double transactionFee = price * 0.05;
    double commission = price * 0.025;
    double commissionTax = commission * 0.25;
    double total = price + transactionFee + commission + commissionTax;
    if (boardAuctionData.isNotEmpty) {
      garlicDifferencetotalAmount =
          state.topBid - boardAuctionData.first.bidAmount;
    }
    // Emit new state
    emit(state.copyWith(
      propertyPrice: price,
      transactionFee: transactionFee,
      commission: commission,
      commissionTax: commissionTax,
      total: total,
    ));
  }

  void increaseBid() {
    double newBid = state.topBid + (auctionOrigin?.garlicDifference ?? 0);
    emit(state.copyWith(topBid: newBid));
    updatePropertyPrice(newBid);
  }

  void decreaseBid() {
    double newBid = state.topBid - (auctionOrigin?.garlicDifference ?? 0);
    if (newBid >
        (boardAuctionData.isEmpty
            ? auctionOrigin!.openingPrice
            : boardAuctionData.first.bidAmount)) {
      emit(state.copyWith(topBid: newBid));

      updatePropertyPrice(newBid);
    }
  }

  addNewBidValue() {
    emit(
      state.copyWith(
        topBid: boardAuctionData.isEmpty
            ? double.tryParse(auctionOrigin!.openingPrice.toString())
            : double.tryParse(
                (boardAuctionData.first.bidAmount +
                        auctionOrigin!.garlicDifference)
                    .toString(),
              ),
      ),
    );
    updatePropertyPrice(
      boardAuctionData.isEmpty
          ? double.tryParse(auctionOrigin!.openingPrice.toString())
          : double.tryParse(
              (boardAuctionData.first.bidAmount +
                      auctionOrigin!.garlicDifference)
                  .toString(),
            ),
    );
  }
}
