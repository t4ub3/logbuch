import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';
import 'package:logbuch_server/src/pricing/pricing_data.dart';

class PricingEndpoint extends AppEndpoint {
  /// What the booking costs by the rates and fees as they are now, see
  /// `calculatePrice`. Nothing is stored.
  Future<BookingPrice> calculate(Session session, int bookingId) async {
    final data = await PricingData.load(session, bookingId);
    if (data == null) {
      throw ValidationException(reason: ValidationError.notFound);
    }
    return data.price;
  }
}
