import 'dart:async';
import '../models/captain_profile_model.dart';

abstract class CaptainProfileRemoteDataSource {
  Future<CaptainProfileModel> getCaptainProfile();
  Future<bool> toggleCarpoolHost(bool isActive);
}

class CaptainProfileRemoteDataSourceImpl implements CaptainProfileRemoteDataSource {
  bool _carpoolHostActive = true;

  @override
  Future<CaptainProfileModel> getCaptainProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return CaptainProfileModel(
      id: 'cap_99812',
      name: 'Rajesh Kumar',
      captainId: 'CP-44910',
      phoneNumber: '9876543210',
      vehicleName: 'Honda Activa 6G / Hero Splendor',
      vehicleNumber: 'KA-05-EV-4421',
      vehicleType: 'Two Wheeler (Bike)',
      rating: 4.96,
      totalRatings: 1480,
      totalTrips: 1840,
      acceptanceRate: 97.4,
      completionRate: 98.8,
      walletBalance: 3840.00,
      documentsStatus: 'All Verified & Approved',
      carpoolHostActive: _carpoolHostActive,
    );
  }

  @override
  Future<bool> toggleCarpoolHost(bool isActive) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _carpoolHostActive = isActive;
    return true;
  }
}
