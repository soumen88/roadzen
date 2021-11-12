import 'package:roadzen/booking/bookingstate.dart';
import 'package:roadzen/models/familymodel.dart';

class SeatBooking{
 List<List<BookingState>> currentBookingStateList = [];
 List<List<BookingState>> get currentBookingState => currentBookingStateList;
 SeatBooking(this.currentBookingStateList);
}