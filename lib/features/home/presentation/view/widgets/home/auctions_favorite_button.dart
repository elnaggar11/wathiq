import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/params/home/add_favorite_params.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_status_timer_widget.dart';

import '../../../../data/models/auctions_model/auctions_model.dart';
import '../../../view_model/home/home_cubit.dart';
import '../mazad_details/location_and_intro_image._widgets.dart';

bool KisFromFav = false;

class AuctionsFavoriteButton extends StatefulWidget {
  const AuctionsFavoriteButton({
    super.key,
    required this.homeCubit,
    required this.auctionData,
    this.isFromDetails = false,
    this.isFromFav = false,
  });

  final HomeCubit homeCubit;
  final bool isFromDetails;
  final bool isFromFav;

  final AuctionData auctionData;

  @override
  State<AuctionsFavoriteButton> createState() => _AuctionsFavoriteButtonState();
}

class _AuctionsFavoriteButtonState extends State<AuctionsFavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.auctionData.isFavorite!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.addFavoriteRequestState != current.addFavoriteRequestState,
      listener: (context, state) {
        if (state.deleteAuctionFavoriteError == RequestState.error) {
          setState(() {
            isFavorite = true;
          });
        }
        if (state.addFavoriteError == RequestState.error) {
          print('state.addFavoriteError == RequestState.error');
          setState(() {
            isFavorite = false;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          if (isFavorite) {
            widget.homeCubit.deleteAuctionFavorite(widget.auctionData.id);
          } else {
            widget.homeCubit.addFavoriteParams = GeneralAuctionParams(
                auctionId: widget.auctionData.id,
                originId: null,
                amount: null,
                limit: 6);
            widget.homeCubit.addFavorite();
          }

          setState(() {
            isFavorite = !isFavorite;
            widget.auctionData.isFavorite = isFavorite;
            print(
                'widget.auctionData.isFavorite ${widget.auctionData.isFavorite}');
            final index = widget.homeCubit.state.auctionsModel!.data
                .indexWhere((auction) => auction.id == widget.auctionData.id);

            if (index != -1) {
              widget.homeCubit.state.auctionsModel!.data[index].isFavorite =
                  isFavorite;
            }
            if (widget.isFromDetails) {
              widget.homeCubit.refreshAuctionsForTab();
            }
            if (widget.isFromFav) {
              widget.homeCubit.refreshAuctionsForTab();
            }

            print(
                'isfav ${widget.homeCubit.state.auctionsModel!.data[index].isFavorite}');
          });
        },
        child: widget.isFromDetails
            ? AuctionDetaislIconWidget(
                image: isFavorite
                    ? AppAssets.app_imagesLikedHeart
                    : AppAssets.app_imagesFavoriteAuction,
                color: isFavorite
                    ? AppColors.danger(context)
                    : AppColors.iconsGrey(context),
              )
            : MazadIconWidget(
                image: isFavorite
                    ? AppAssets.app_imagesLikedHeart
                    : AppAssets.app_imagesFavoriteAuction,
              ),
      ),
    );
  }
}

class AssetsFavoriteButton extends StatefulWidget {
  const AssetsFavoriteButton({
    super.key,
    required this.homeCubit,
    this.isFromDetails = false,
  });

  final HomeCubit homeCubit;
  final bool isFromDetails;

  @override
  State<AssetsFavoriteButton> createState() => _AssetsFavoriteButtonState();
}

class _AssetsFavoriteButtonState extends State<AssetsFavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.homeCubit.auctionOrigin!.isFavorite!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.addFavoriteRequestState != current.addFavoriteRequestState,
      listener: (context, state) {
        if (state.deleteAuctionFavoriteError == RequestState.error) {
          setState(() {
            isFavorite = true;
          });
        }
        if (state.addFavoriteError == RequestState.error) {
          print('state.addFavoriteError == RequestState.error');
          setState(() {
            isFavorite = false;
          });
        }
      },
      child: GestureDetector(
          onTap: () {
            if (isFavorite) {
              widget.homeCubit.auctionId = widget.homeCubit.auctionData!.id;
              widget.homeCubit.originId = widget.homeCubit.auctionOrigin!.id;
              widget.homeCubit.amount = null;
              widget.homeCubit.deleteOriginFavorite();
            } else {
              widget.homeCubit.addFavoriteParams = GeneralAuctionParams(
                auctionId: widget.homeCubit.auctionData!.id,
                originId: widget.homeCubit.auctionOrigin!.id,
                amount: null,
                limit: 6,
              );
              widget.homeCubit.addFavorite();
            }

            setState(() {
              isFavorite = !isFavorite;
              widget.homeCubit.auctionOrigin!.isFavorite = isFavorite;
              print(
                  'widget.auctionData.isFavorite ${widget.homeCubit.auctionOrigin!.isFavorite}');
              final index = widget.homeCubit.auctionData!.auctionOrigins
                  .indexWhere((origins) =>
                      origins.id == widget.homeCubit.auctionOrigin!.id);

              if (index != -1) {
                widget.homeCubit.auctionData!.auctionOrigins[index].isFavorite =
                    isFavorite;
              }
              if (widget.isFromDetails) {
                widget.homeCubit.getAuctions();
              }
              print(
                  'isfav ${widget.homeCubit.state.auctionsModel!.data[index].isFavorite}');
            });
          },
          child: AuctionDetaislIconWidget(
            image: isFavorite
                ? AppAssets.app_imagesLikedHeart
                : AppAssets.app_imagesFavoriteAuction,
            color: isFavorite
                ? AppColors.danger(context)
                : AppColors.iconsGrey(context),
          )),
    );
  }
}
