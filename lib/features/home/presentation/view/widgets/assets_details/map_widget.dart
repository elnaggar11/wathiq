import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/map_error_widget.dart';
import '../../../view_model/home/home_cubit.dart';

class MapLocationWidget extends StatefulWidget {
  const MapLocationWidget({
    super.key,
  });

  @override
  State<MapLocationWidget> createState() => _MapLocationWidgetState();
}

class _MapLocationWidgetState extends State<MapLocationWidget>
    with SingleTickerProviderStateMixin {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  MapErrorType? currentError;
  String? errorMessage;
  bool isLoading = true;
  LatLng? auctionLocation;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    setState(() {
      isLoading = true;
      currentError = null;
      errorMessage = null;
      markers.clear();
    });

    try {
      // التحقق من وجود بيانات الموقع
      await _validateLocationData();

      // إعداد العلامات
      _setupMarkers();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('خطأ في تهيئة الخريطة: $e');
      setState(() {
        isLoading = false;
        currentError = MapErrorType.generalError;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _validateLocationData() async {
    HomeCubit homeCubit = context.read<HomeCubit>();

    // التحقق من وجود بيانات الأصل
    if (homeCubit.auctionOrigin == null) {
      setState(() {
        currentError = MapErrorType.noLocation;
        errorMessage = 'لا توجد بيانات للأصل';
      });
      return;
    }

    // التحقق من وجود بيانات الموقع
    if (homeCubit.auctionOrigin?.location == null) {
      setState(() {
        currentError = MapErrorType.noLocation;
        errorMessage = 'لا توجد بيانات موقع للأصل';
      });
      return;
    }

    final location = homeCubit.auctionOrigin!.location;

    // التحقق من أن الإحداثيات ضمن النطاق الصحيح
    if (location.latitude < -90 ||
        location.latitude > 90 ||
        location.longitude < -180 ||
        location.longitude > 180) {
      setState(() {
        currentError = MapErrorType.noLocation;
        errorMessage = 'إحداثيات غير صحيحة';
      });
      return;
    }

    // إنشاء موقع صحيح
    auctionLocation = LatLng(location.latitude, location.longitude);
    print('تم تحديد موقع الأصل: ${location.latitude}, ${location.longitude}');
  }

  void _setupMarkers() {
    if (auctionLocation == null) return;

    HomeCubit homeCubit = context.read<HomeCubit>();

    markers.add(
      Marker(
        markerId: MarkerId('auction_location'),
        position: auctionLocation!,
        infoWindow: InfoWindow(
          title: homeCubit.auctionOrigin?.title ?? 'موقع الاصل',
          snippet: homeCubit.auctionOrigin?.location.title ?? 'موقع الأصل',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    print('تم إضافة علامة على الخريطة');
  }

  // Future<void> _openAppSettings() async {
  //   try {
  //     await Geolocator.openAppSettings();
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content:
  //             Text('يرجى فتح إعدادات التطبيق يدوياً وتفعيل صلاحيات الموقع'),
  //         backgroundColor: Colors.orange,
  //       ),
  //     );
  //   }
  // }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        height: 510,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'الموقع',
                        textAlign: TextAlign.start,
                        style: AppStyles.styleBold22(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        homeCubit.auctionOrigin?.location.title ?? '',
                        textAlign: TextAlign.start,
                        style: AppStyles.styleMedium14(context).copyWith(
                          color: AppColors.typographySubTitle(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.separatingBorder(context),
                    width: 1,
                  ),
                ),
                child: _buildMapContent(),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMapContent() {
    // عرض حالة التحميل
    if (isLoading) {
      return Container(
        color: AppColors.backgroundPrimary(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.primary(context),
              ),
              SizedBox(height: 16),
              Text(
                'جاري تحميل الخريطة...',
                style: AppStyles.styleBold16(context).copyWith(
                  color: AppColors.typographySubTitle(context),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // عرض رسائل الخطأ
    // if (currentError != null) {
    //   return MapErrorWidget(
    //     errorType: currentError!,
    //     errorMessage: errorMessage,
    //     onRetry: _initializeMap,
    //     onOpenSettings: currentError == MapErrorType.permissionError
    //         ? _openAppSettings
    //         : null,
    //   );
    // }

    // عرض الخريطة
    if (auctionLocation != null) {
      print(
          'عرض الخريطة مع الموقع: ${auctionLocation!.latitude}, ${auctionLocation!.longitude}');
      return GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          print('تم إنشاء الخريطة بنجاح');
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(auctionLocation?.latitude ?? 24.724068,
              auctionLocation?.longitude ?? 46.774978),
          zoom: 14.0,
        ),
        markers: markers,
        zoomControlsEnabled: true,
        myLocationEnabled: false, // لا نحتاج لموقع المستخدم
        myLocationButtonEnabled: false, // لا نحتاج لزر موقع المستخدم
        mapType: MapType.normal,
        onCameraMove: (position) {
          // يمكن إضافة منطق إضافي هنا
        },
        // تفعيل التفاعل مع الخريطة

        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        rotateGesturesEnabled: true,
        compassEnabled: true,
        mapToolbarEnabled: true,
      );
    }

    // حالة افتراضية - لا يوجد موقع
    return MapErrorWidget(
      errorType: MapErrorType.noLocation,
      errorMessage: 'لم يتم العثور على موقع للأصل',
      onRetry: _initializeMap,
    );
  }
}
// class SimpleMapScreen extends StatefulWidget {
//   const SimpleMapScreen({super.key});
//   @override State<SimpleMapScreen> createState() => _SimpleMapScreenState();
// }

// class _SimpleMapScreenState extends State<SimpleMapScreen> {
//   GoogleMapController? mapController;

//   @override
//   Widget build(BuildContext context) {
//     return const GoogleMap(
//       initialCameraPosition: CameraPosition(
//         target: LatLng(24.724068, 46.774978),
//         zoom: 15,
//       ),
//     );
//   }
// }
