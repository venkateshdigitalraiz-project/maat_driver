import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/resend_otp_usecase.dart';
import 'features/auth/domain/usecases/send_otp_usecase.dart';
import 'features/auth/domain/usecases/verify_otp_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/home/data/datasources/driver_home_remote_data_source.dart';
import 'features/home/data/repositories/driver_home_repository_impl.dart';
import 'features/home/domain/repositories/driver_home_repository.dart';
import 'features/home/domain/usecases/driver_home_usecases.dart';
import 'features/home/presentation/bloc/driver_home_bloc.dart';
import 'features/profile/data/datasources/captain_profile_remote_data_source.dart';
import 'features/profile/data/repositories/captain_profile_repository_impl.dart';
import 'features/profile/domain/repositories/captain_profile_repository.dart';
import 'features/profile/domain/usecases/captain_profile_usecases.dart';
import 'features/profile/presentation/bloc/captain_profile_bloc.dart';

class ServiceLocator {
  // Auth
  static late final AuthRemoteDataSource authRemoteDataSource;
  static late final AuthRepository authRepository;
  static late final SendOtpUseCase sendOtpUseCase;
  static late final VerifyOtpUseCase verifyOtpUseCase;
  static late final ResendOtpUseCase resendOtpUseCase;

  // Driver Home
  static late final DriverHomeRemoteDataSource driverHomeRemoteDataSource;
  static late final DriverHomeRepository driverHomeRepository;
  static late final GetDriverHomeDataUseCase getDriverHomeDataUseCase;
  static late final ToggleOnlineStatusUseCase toggleOnlineStatusUseCase;
  static late final RespondToRideRequestUseCase respondToRideRequestUseCase;

  // Captain Profile
  static late final CaptainProfileRemoteDataSource captainProfileRemoteDataSource;
  static late final CaptainProfileRepository captainProfileRepository;
  static late final GetCaptainProfileUseCase getCaptainProfileUseCase;
  static late final ToggleCarpoolHostUseCase toggleCarpoolHostUseCase;

  static bool _isInitialized = false;

  static void init() {
    if (_isInitialized) return;
    _isInitialized = true;

    // 1. Data Sources
    authRemoteDataSource = AuthRemoteDataSourceImpl();
    driverHomeRemoteDataSource = DriverHomeRemoteDataSourceImpl();
    captainProfileRemoteDataSource = CaptainProfileRemoteDataSourceImpl();

    // 2. Repositories
    authRepository = AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
    driverHomeRepository = DriverHomeRepositoryImpl(remoteDataSource: driverHomeRemoteDataSource);
    captainProfileRepository = CaptainProfileRepositoryImpl(remoteDataSource: captainProfileRemoteDataSource);

    // 3. Use Cases
    sendOtpUseCase = SendOtpUseCase(authRepository);
    verifyOtpUseCase = VerifyOtpUseCase(authRepository);
    resendOtpUseCase = ResendOtpUseCase(authRepository);

    getDriverHomeDataUseCase = GetDriverHomeDataUseCase(driverHomeRepository);
    toggleOnlineStatusUseCase = ToggleOnlineStatusUseCase(driverHomeRepository);
    respondToRideRequestUseCase = RespondToRideRequestUseCase(driverHomeRepository);

    getCaptainProfileUseCase = GetCaptainProfileUseCase(captainProfileRepository);
    toggleCarpoolHostUseCase = ToggleCarpoolHostUseCase(captainProfileRepository);
  }

  static AuthBloc createAuthBloc() {
    return AuthBloc(
      sendOtpUseCase: sendOtpUseCase,
      verifyOtpUseCase: verifyOtpUseCase,
      resendOtpUseCase: resendOtpUseCase,
    );
  }

  static DashboardBloc createDashboardBloc() {
    return DashboardBloc();
  }

  static DriverHomeBloc createDriverHomeBloc() {
    return DriverHomeBloc(
      getDriverHomeDataUseCase: getDriverHomeDataUseCase,
      toggleOnlineStatusUseCase: toggleOnlineStatusUseCase,
      respondToRideRequestUseCase: respondToRideRequestUseCase,
    );
  }

  static CaptainProfileBloc createCaptainProfileBloc() {
    return CaptainProfileBloc(
      getCaptainProfileUseCase: getCaptainProfileUseCase,
      toggleCarpoolHostUseCase: toggleCarpoolHostUseCase,
    );
  }
}
