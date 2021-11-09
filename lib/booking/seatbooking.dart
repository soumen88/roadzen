import 'package:roadzen/booking/bookingstate.dart';
import 'package:roadzen/models/familymodel.dart';

class SeatBooking{
 FamilyModel? family;
 List<List<BookingState>> currentBookingStateList = [];
 List<List<BookingState>> get currentBookingState => currentBookingStateList;
 SeatBooking(this.family, this.currentBookingStateList);
}