import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/functions/format_number.dart';
import '../../../../../core/functions/pick_images_and_files.dart';
import '../../../../../core/params/wallet/psot_withdraw_params.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../home/data/models/enrolle/privacy_model.dart';
import '../../../data/model/add_wallet_balance.dart';
import '../../../data/model/held_model.dart';
import '../../../data/model/invoice_model.dart';
import '../../../data/model/withdraw_model.dart';
import '../../../data/repository/wallet_repo.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this._walletRepository) : super(WalletState());
  final WalletRepository _walletRepository;
  final contactNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final ibanNumberController = TextEditingController();
  final withdrawAmountController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  //
  bool winner = false;
  bool loss = false;
  //
  final withdrawFormKey = GlobalKey<FormState>();
  final beneficiaryNameController = TextEditingController();
  final addBalanceKey = GlobalKey<FormState>();
  WithdrawRequest? withdrawRequest;
  Invoice? invoiceRequest;
  AuctionDataHeld? heldFunds;
  File? ibanAttachment;
  Future<void> pickIbanAttachment() async {
    ibanAttachment = await pickFile();
  }

  Future<void> getWallet() async {
    emit(state.copyWith(getWalletRequestState: RequestState.loading));

    final result = await _walletRepository.getWallet();

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

  Future<void> getHeldFunds() async {
    emit(state.copyWith(getHeldFundsRequestState: RequestState.loading));

    final result = await _walletRepository.getHeldFunds();

    result.fold(
      (failure) {
        emit(state.copyWith(
          getHeldFundsRequestState: RequestState.error,
          getHeldFundsError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        emit(
          state.copyWith(
            getHeldFundsRequestState: RequestState.loaded,
            getHeldFundsModel: right,
          ),
        );
      },
    );
  }

  Future<void> getWithdraw() async {
    emit(state.copyWith(getWithdrawRequestState: RequestState.loading));

    final result = await _walletRepository.getWithdraw();

    result.fold(
      (failure) {
        emit(state.copyWith(
          getWithdrawRequestState: RequestState.error,
          getWithdrawError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        emit(
          state.copyWith(
            getWithdrawRequestState: RequestState.loaded,
            getWithdrawModel: right,
          ),
        );
      },
    );
  }

  Future<void> getUserInvoices() async {
    emit(state.copyWith(getHeldFundsRequestState: RequestState.loading));

    final result = await _walletRepository.getUserInvoices();

    result.fold(
      (failure) {
        emit(state.copyWith(
          getUserInvoicesRequestState: RequestState.error,
          getUserInvoicesError: failure,
        ));
        log(failure.toString());
      },
      (right) {
        emit(
          state.copyWith(
            getUserInvoicesRequestState: RequestState.loaded,
            getUserInvoicesModel: right,
          ),
        );
      },
    );
  }

  void addWalletBalance() async {
    if (!addBalanceKey.currentState!.validate()) return;

    emit(state.copyWith(addWalletBalanceRequestState: RequestState.loading));

    final result = await _walletRepository
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

  Future<void> submitWithdrawRequest() async {
    emit(state.copyWith(submitWithdrawRequestState: RequestState.loading));

    final result = await _walletRepository.submitWithdrawRequest(
      PsotWithdrawParams(
        name: beneficiaryNameController.text,
        phoneNumber: contactNumberController.text,
        bankName: bankNameController.text,
        iban: ibanNumberController.text,
        amount: parseFormattedNumber(withdrawAmountController.text.trim())
            .toString(),
        ibanCertificate: ibanAttachment,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          submitWithdrawRequestState: RequestState.error,
          submitWithdrawError: failure,
        ));
      },
      (msg) {
        ibanAttachment = null;
        beneficiaryNameController.clear();
        contactNumberController.clear();
        bankNameController.clear();
        ibanNumberController.clear();
        withdrawAmountController.clear();
        emit(state.copyWith(
          submitWithdrawRequestState: RequestState.loaded,
          submitWithdrawMsg: msg,
        ));
      },
    );
  }
}
