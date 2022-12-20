// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(code) =>
      "Bạn có chắc chắn hủy đăng ký phiếu [${code}] không?";

  static String m1(letter) =>
      "Bạn có chắc chắn muốn xóa phiếu [${letter}] không?";

  static String m2(delete) => "Bạn có chắc chắn muốn xóa [${delete}] không?";

  static String m3(card) => "Bạn có muốn khóa thẻ [${card}] không?";

  static String m4(eventName) =>
      "Bạn chắc chắn muốn tham gia sự kiện [${eventName}] không?";

  static String m5(approved) =>
      "Bạn có muốn gửi duyệt phiếu [${approved}] không?";

  static String m6(nameser) => "Chỉnh sửa đăng ký dịch vụ ${nameser}";

  static String m7(message) => "Lỗi: ${message}";

  static String m8(nameser) => "Đăng ký dịch vụ ${nameser}";

  static String m9(eName) => "Bạn đã xác nhận tham gia [${eName}] thành công";

  static String m10(service) => "Dịch vụ ${service}";

  static String m11(del) => "Xóa [${del}] thành công";

  static String m12(to) => "Chúng tôi đã gửi cho bạn mã đến: ${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "account_name": MessageLookupByLibrary.simpleMessage("Tên đăng nhập"),
        "active": MessageLookupByLibrary.simpleMessage("Hoạt động"),
        "add": MessageLookupByLibrary.simpleMessage("Thêm"),
        "add_new": MessageLookupByLibrary.simpleMessage("Thêm mới"),
        "add_package": MessageLookupByLibrary.simpleMessage("Thêm hàng hóa"),
        "add_photo": MessageLookupByLibrary.simpleMessage("Thêm hình ảnh"),
        "add_trans_card":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ mới"),
        "al_read": MessageLookupByLibrary.simpleMessage("Đã đọc"),
        "all": MessageLookupByLibrary.simpleMessage("Tất cả"),
        "apartment": MessageLookupByLibrary.simpleMessage("Căn hộ"),
        "apartment_bill":
            MessageLookupByLibrary.simpleMessage("Tiền phí chung cư"),
        "app_version": MessageLookupByLibrary.simpleMessage("App version"),
        "approved": MessageLookupByLibrary.simpleMessage("Đã duyệt"),
        "back_side": MessageLookupByLibrary.simpleMessage("Mặt sau"),
        "bill_code": MessageLookupByLibrary.simpleMessage("Mã hóa đơn"),
        "bill_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết hóa đơn"),
        "bill_name": MessageLookupByLibrary.simpleMessage("Tên hóa đơn"),
        "bills": MessageLookupByLibrary.simpleMessage("Hóa đơn"),
        "c_new_pass":
            MessageLookupByLibrary.simpleMessage("Nhập lại mật khẩu mới"),
        "camera": MessageLookupByLibrary.simpleMessage("Máy ảnh"),
        "can_not_empty":
            MessageLookupByLibrary.simpleMessage("Không được để trống"),
        "cancel": MessageLookupByLibrary.simpleMessage("Huỷ"),
        "cancel_reason": MessageLookupByLibrary.simpleMessage("Lý do hủy"),
        "cancel_reg": MessageLookupByLibrary.simpleMessage("Hủy đăng ký"),
        "cancel_register": MessageLookupByLibrary.simpleMessage("Hủy đăng ký"),
        "cancel_request": MessageLookupByLibrary.simpleMessage("Hủy đăng ký"),
        "card_num": MessageLookupByLibrary.simpleMessage("Mã thẻ"),
        "card_status": MessageLookupByLibrary.simpleMessage("Trạng thái thẻ"),
        "change_pass": MessageLookupByLibrary.simpleMessage("Đổi mật khẩu"),
        "choices": MessageLookupByLibrary.simpleMessage("Lựa chọn"),
        "choose_a_project": MessageLookupByLibrary.simpleMessage("Chọn dự án"),
        "choose_an_apartment":
            MessageLookupByLibrary.simpleMessage("Chọn căn hộ"),
        "close": MessageLookupByLibrary.simpleMessage("Đóng"),
        "code_verify": MessageLookupByLibrary.simpleMessage("Nhập mã bảo mật"),
        "coming_soon": MessageLookupByLibrary.simpleMessage("Sắp diễn ra"),
        "complain": MessageLookupByLibrary.simpleMessage("Khiếu nại"),
        "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
        "confirm_cancel_request": m0,
        "confirm_delete_letter": m1,
        "confirm_delete_service": m2,
        "confirm_lock_card": m3,
        "confirm_lock_trans_card": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn muốn khóa thẻ xe không?"),
        "confirm_par_ques_event": m4,
        "confirm_participate_event":
            MessageLookupByLibrary.simpleMessage("Xác nhận tham gia sự kiện"),
        "confirm_pass":
            MessageLookupByLibrary.simpleMessage("Nhập lại mật khẩu"),
        "confirm_send_request": m5,
        "construction": MessageLookupByLibrary.simpleMessage("Thi công"),
        "content": MessageLookupByLibrary.simpleMessage("Nội dung"),
        "covenient_service": MessageLookupByLibrary.simpleMessage("Tiện ích"),
        "create_acc": MessageLookupByLibrary.simpleMessage("Đăng ký tài khoản"),
        "create_acc_1": MessageLookupByLibrary.simpleMessage("Tạo tài khoản"),
        "current_pass":
            MessageLookupByLibrary.simpleMessage("Mật khẩu hiện tại"),
        "date": MessageLookupByLibrary.simpleMessage("Ngày"),
        "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
        "delete_letter": MessageLookupByLibrary.simpleMessage("Xóa phiếu"),
        "delivery_info":
            MessageLookupByLibrary.simpleMessage("Thông tin đồ chuyển"),
        "delivery_letter":
            MessageLookupByLibrary.simpleMessage("Phiếu đăng ký chuyển đồ"),
        "description": MessageLookupByLibrary.simpleMessage("Mô tả"),
        "detail_view": MessageLookupByLibrary.simpleMessage("Xem chi tiết"),
        "details": MessageLookupByLibrary.simpleMessage("Chi tiết"),
        "dimention": MessageLookupByLibrary.simpleMessage("Kích thước"),
        "discount": MessageLookupByLibrary.simpleMessage("Chiết khấu"),
        "done": MessageLookupByLibrary.simpleMessage("Xong"),
        "due_bill": MessageLookupByLibrary.simpleMessage("Hạn đóng"),
        "edit": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
        "edit_package": MessageLookupByLibrary.simpleMessage("Sửa hàng hóa"),
        "edit_reg_deliver":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa đăng ký chuyển đồ"),
        "edit_res_card":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa thẻ cư dân"),
        "edit_service_a": m6,
        "edit_trans_card":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa thẻ phương tiện"),
        "elcetric_bill": MessageLookupByLibrary.simpleMessage("Tiền điện"),
        "electricity": MessageLookupByLibrary.simpleMessage("Điện"),
        "elevator_card": MessageLookupByLibrary.simpleMessage("Thẻ thang máy"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "en": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
        "end_date_after_now": MessageLookupByLibrary.simpleMessage(
            "Ngày kết thúc không được nhỏ hơn ngày hiện tại"),
        "end_date_after_start_date": MessageLookupByLibrary.simpleMessage(
            "Ngày kết thúc không được nhỏ hơn ngày bắt đầu "),
        "end_date_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ngày kết thúc không được để trống"),
        "end_time": MessageLookupByLibrary.simpleMessage("Thời gian kết thúc"),
        "end_time_reg":
            MessageLookupByLibrary.simpleMessage("Thời gian kết thúc đăng ký"),
        "enter": MessageLookupByLibrary.simpleMessage("Nhập"),
        "enter_email":
            MessageLookupByLibrary.simpleMessage("Nhập địa chỉ email"),
        "enter_email_phone":
            MessageLookupByLibrary.simpleMessage("Nhập SDT/Email "),
        "enter_name": MessageLookupByLibrary.simpleMessage("Nhập họ và tên"),
        "enter_num": MessageLookupByLibrary.simpleMessage("Nhập số"),
        "enter_pas": MessageLookupByLibrary.simpleMessage("Nhập mật khẩu"),
        "enter_payment_pass":
            MessageLookupByLibrary.simpleMessage("Nhập mật khẩu thanh toán"),
        "enter_phone":
            MessageLookupByLibrary.simpleMessage("Nhập số điện thoại"),
        "enter_phone_email": MessageLookupByLibrary.simpleMessage(
            "Nhập số điện thoại hoặc email"),
        "enter_username":
            MessageLookupByLibrary.simpleMessage("Nhập tên tài khoản"),
        "err_conn": MessageLookupByLibrary.simpleMessage("Lỗi kết nối "),
        "err_internet": MessageLookupByLibrary.simpleMessage(
            "Không kết nối được với máy chủ"),
        "err_unknown":
            MessageLookupByLibrary.simpleMessage("Lỗi Không xác định"),
        "err_x": m7,
        "event": MessageLookupByLibrary.simpleMessage("Sự kiện"),
        "event_msg": MessageLookupByLibrary.simpleMessage(
            "Theo dõi các sự kiện từng ngày/ tháng"),
        "expired": MessageLookupByLibrary.simpleMessage("Hết hạn"),
        "expired_date": MessageLookupByLibrary.simpleMessage("Ngày hết hạn"),
        "extend": MessageLookupByLibrary.simpleMessage("Gia hạn"),
        "failure": MessageLookupByLibrary.simpleMessage("Thất bại"),
        "feedback": MessageLookupByLibrary.simpleMessage("Góp ý"),
        "female": MessageLookupByLibrary.simpleMessage("Nữ"),
        "file_selection": MessageLookupByLibrary.simpleMessage("Chọn file"),
        "finish": MessageLookupByLibrary.simpleMessage("Kết thúc"),
        "follow_ser": MessageLookupByLibrary.simpleMessage("Theo dõi dịch vụ"),
        "forgot_pass": MessageLookupByLibrary.simpleMessage("Quên mật khẩu?"),
        "forum": MessageLookupByLibrary.simpleMessage("Diễn đàn"),
        "free_service":
            MessageLookupByLibrary.simpleMessage("Dịch vụ không tính phí"),
        "front_side": MessageLookupByLibrary.simpleMessage("Mặt trước"),
        "full_name": MessageLookupByLibrary.simpleMessage("Họ và Tên"),
        "gallery": MessageLookupByLibrary.simpleMessage("Thư viện"),
        "gym_card": MessageLookupByLibrary.simpleMessage("Dịch vụ Gym"),
        "happened": MessageLookupByLibrary.simpleMessage("Đã diễn ra"),
        "happening": MessageLookupByLibrary.simpleMessage("Đang diễn ra"),
        "happening_location":
            MessageLookupByLibrary.simpleMessage("Địa điểm diễn ra"),
        "have_acc":
            MessageLookupByLibrary.simpleMessage("Bạn đã có tài khoản?"),
        "height": MessageLookupByLibrary.simpleMessage("cao"),
        "hello": MessageLookupByLibrary.simpleMessage("Xin chào"),
        "his_reg_service":
            MessageLookupByLibrary.simpleMessage("Lịch sử đăng ký dịch vụ"),
        "history": MessageLookupByLibrary.simpleMessage("Lịch sử"),
        "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
        "hour": MessageLookupByLibrary.simpleMessage("Giờ"),
        "housework": MessageLookupByLibrary.simpleMessage("Giúp việc"),
        "identity_back_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh CMND/CCCD/Hộ chiếu mặt sau không được để trống"),
        "identity_front_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh CMND/CCCD/Hộ chiếu mặt trước không được để trống"),
        "identity_photo":
            MessageLookupByLibrary.simpleMessage("Ảnh CMND/ CCCD/ Hộ chiếu"),
        "inactive": MessageLookupByLibrary.simpleMessage("Dừng hoạt động"),
        "incorrect_usn_pass": MessageLookupByLibrary.simpleMessage(
            "Số điện thoại/Email hoặc mật khẩu không chính xác."),
        "info": MessageLookupByLibrary.simpleMessage("Thông tin"),
        "info_reception":
            MessageLookupByLibrary.simpleMessage("Tiếp nhận thông tin"),
        "internet": MessageLookupByLibrary.simpleMessage("Internet"),
        "item_list_not_empty": MessageLookupByLibrary.simpleMessage(
            "Danh sách chuyển đồ không được để trống"),
        "l_new": MessageLookupByLibrary.simpleMessage("Mới"),
        "l_w_e": MessageLookupByLibrary.simpleMessage("Dài x rộng x cao"),
        "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
        "letter_num": MessageLookupByLibrary.simpleMessage("Mã phiếu"),
        "letter_status":
            MessageLookupByLibrary.simpleMessage("Trạng thái phiếu"),
        "licene_plate": MessageLookupByLibrary.simpleMessage("Biển số xe"),
        "lock": MessageLookupByLibrary.simpleMessage("Khóa"),
        "lock_card": MessageLookupByLibrary.simpleMessage("Khóa thẻ"),
        "long": MessageLookupByLibrary.simpleMessage("Dài"),
        "male": MessageLookupByLibrary.simpleMessage("Nam"),
        "max_day_pay":
            MessageLookupByLibrary.simpleMessage("Số ngày thanh toán tối đa"),
        "max_pay_day_not_empty": MessageLookupByLibrary.simpleMessage(
            "Số ngày đăng ký tối đa không được để trống"),
        "message": MessageLookupByLibrary.simpleMessage("Tin nhắn"),
        "missing_obj": MessageLookupByLibrary.simpleMessage("Đồ thất lạc"),
        "missing_report": MessageLookupByLibrary.simpleMessage("Báo mất"),
        "month": MessageLookupByLibrary.simpleMessage("Tháng"),
        "need_choose_cylce_regdate": MessageLookupByLibrary.simpleMessage(
            "Bạn cần chọn chu kỳ thanh toán và ngày đăng ký trước"),
        "need_support":
            MessageLookupByLibrary.simpleMessage("Cần bảo vệ hỗ trợ"),
        "new_pass": MessageLookupByLibrary.simpleMessage("Mật khẩu mới"),
        "news": MessageLookupByLibrary.simpleMessage("Tin tức"),
        "next": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
        "no_acc":
            MessageLookupByLibrary.simpleMessage("Bạn chưa có tài khoản?"),
        "no_bill": MessageLookupByLibrary.simpleMessage("Không có hóa đơn nào"),
        "no_card": MessageLookupByLibrary.simpleMessage("Không có thẻ nào"),
        "no_comment":
            MessageLookupByLibrary.simpleMessage("Chưa có bình luận nào"),
        "no_delivery": MessageLookupByLibrary.simpleMessage(
            "Không có đăng ký chuyển đố nào"),
        "no_event":
            MessageLookupByLibrary.simpleMessage("Không có sự kiện nào"),
        "no_letter": MessageLookupByLibrary.simpleMessage("Không có phiếu nào"),
        "no_news": MessageLookupByLibrary.simpleMessage("Không có tin tức nào"),
        "no_service_regitration": MessageLookupByLibrary.simpleMessage(
            "Không có đăng ký dịch vụ vào"),
        "no_trans_card":
            MessageLookupByLibrary.simpleMessage("Không có thẻ xe nào"),
        "no_trans_letter":
            MessageLookupByLibrary.simpleMessage("Không có phiếu đăng ký nào"),
        "not_blank":
            MessageLookupByLibrary.simpleMessage("Không được để trống"),
        "not_dimention":
            MessageLookupByLibrary.simpleMessage("Kích thước không đúng"),
        "not_email":
            MessageLookupByLibrary.simpleMessage("Không phải là email."),
        "not_empty_back": MessageLookupByLibrary.simpleMessage(
            "Không để trống hình ảnh mặt sau"),
        "not_empty_front": MessageLookupByLibrary.simpleMessage(
            "Không để trống hình ảnh mặt trước"),
        "not_empty_vehicle_type": MessageLookupByLibrary.simpleMessage(
            "Loại phương tiện không được để trống"),
        "not_found_account": MessageLookupByLibrary.simpleMessage(
            "Không tìm thấy thông tin tài khoản"),
        "not_get_otp":
            MessageLookupByLibrary.simpleMessage("Không nhận được OTP?"),
        "not_read": MessageLookupByLibrary.simpleMessage("Chưa đọc"),
        "not_special_char":
            MessageLookupByLibrary.simpleMessage("Không nhập ký tự đặc biệt"),
        "not_upload_15mb": MessageLookupByLibrary.simpleMessage(
            "Không upload được file lớn hơn 15MB"),
        "not_vietnamese": MessageLookupByLibrary.simpleMessage(
            "Không nhập ký tự tiếng Việt có dấu"),
        "not_zero":
            MessageLookupByLibrary.simpleMessage("Không được nhập toàn số 0"),
        "note": MessageLookupByLibrary.simpleMessage("Ghi chú"),
        "other_bill": MessageLookupByLibrary.simpleMessage("Tiền khác"),
        "other_gender": MessageLookupByLibrary.simpleMessage("Giới tính khác"),
        "otp_invalid":
            MessageLookupByLibrary.simpleMessage("Mã OTP không hợp lệ"),
        "otp_msg": MessageLookupByLibrary.simpleMessage(
            "Vui lòng kiểm tra điện thoại hoặc email để xem tin nhắn văn bản có mã. Mã của bạn có 6 ký tự."),
        "otp_verify": MessageLookupByLibrary.simpleMessage("Xác thực OTP"),
        "package": MessageLookupByLibrary.simpleMessage("Hàng hóa"),
        "package_info":
            MessageLookupByLibrary.simpleMessage("Thông tin hàng hóa"),
        "package_items_not_empty": MessageLookupByLibrary.simpleMessage(
            "Thông tin hàng hóa không được để trống"),
        "package_name": MessageLookupByLibrary.simpleMessage("Tên hàng hóa"),
        "paid": MessageLookupByLibrary.simpleMessage("Chưa thanh toán"),
        "parcel": MessageLookupByLibrary.simpleMessage("Bưu phẩm"),
        "parking_bill": MessageLookupByLibrary.simpleMessage("Tiền gửi xe"),
        "parking_card": MessageLookupByLibrary.simpleMessage("Thẻ phương tiện"),
        "participate": MessageLookupByLibrary.simpleMessage("Tham gia"),
        "pass_min_length": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu không ít hơn 8 ký tự"),
        "pass_special": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu phải gồm 1 ký tự đặc biệt"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "pay": MessageLookupByLibrary.simpleMessage("Thanh toán"),
        "pay_date": MessageLookupByLibrary.simpleMessage("Ngày đóng"),
        "payment_circle":
            MessageLookupByLibrary.simpleMessage("Thời hạn sử dụng"),
        "payment_cycle_not_empty": MessageLookupByLibrary.simpleMessage(
            "Chu kỳ thanh toán không được để trống"),
        "payment_method":
            MessageLookupByLibrary.simpleMessage("Phương thức thanh toán"),
        "permission_denied":
            MessageLookupByLibrary.simpleMessage("Từ chối truy cập"),
        "permission_denied_msg":
            MessageLookupByLibrary.simpleMessage("Bạn chưa cấp quyền ứng dụng"),
        "personal_info":
            MessageLookupByLibrary.simpleMessage("Thông tin cá nhân"),
        "pet": MessageLookupByLibrary.simpleMessage("Vật nuôi"),
        "phone_email":
            MessageLookupByLibrary.simpleMessage("Số điện thoại/ Email"),
        "phone_num": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
        "photo_back_side": MessageLookupByLibrary.simpleMessage("Ảnh mặt sau"),
        "photo_front_side":
            MessageLookupByLibrary.simpleMessage("Ảnh mặt trước"),
        "photos": MessageLookupByLibrary.simpleMessage("Hình ảnh"),
        "pool": MessageLookupByLibrary.simpleMessage("Bể bơi"),
        "prev": MessageLookupByLibrary.simpleMessage("Trở lại"),
        "project": MessageLookupByLibrary.simpleMessage("Dự án"),
        "re_sign_in": MessageLookupByLibrary.simpleMessage("Hãy đăng nhập lại"),
        "reflection": MessageLookupByLibrary.simpleMessage("Góc phản ánh"),
        "reg_code": MessageLookupByLibrary.simpleMessage("Mã đăng ký"),
        "reg_const": MessageLookupByLibrary.simpleMessage("Đăng ký thi công"),
        "reg_date": MessageLookupByLibrary.simpleMessage("Ngày đăng ký"),
        "reg_date_not_after_now": MessageLookupByLibrary.simpleMessage(
            "Ngày đăng ký không hợp lệ. Vui lòng chọn lại."),
        "reg_day_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ngày đăng ký không được để trống"),
        "reg_deliver":
            MessageLookupByLibrary.simpleMessage("Đăng ký chuyển đồ"),
        "reg_num": MessageLookupByLibrary.simpleMessage("Số đăng ký"),
        "reg_service": MessageLookupByLibrary.simpleMessage("Đăng ký dịch vụ"),
        "reg_service_a": m8,
        "reg_time": MessageLookupByLibrary.simpleMessage("Thời gian đăng ký"),
        "reg_trans_photos":
            MessageLookupByLibrary.simpleMessage("Đăng ký xe (2 mặt)"),
        "register_code": MessageLookupByLibrary.simpleMessage("Mã đăng ký"),
        "register_res_card":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ cư dân"),
        "register_trans_card":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ phương tiện"),
        "reject_card": MessageLookupByLibrary.simpleMessage("Hủy thẻ"),
        "reject_reason": MessageLookupByLibrary.simpleMessage("Lý do hủy"),
        "related_doc_photo":
            MessageLookupByLibrary.simpleMessage("Ảnh giấy tờ liên quan"),
        "related_image_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh tài liệu liên quan không được để trống"),
        "related_photo":
            MessageLookupByLibrary.simpleMessage("Ảnh giấy tờ liên quan"),
        "remember_acc": MessageLookupByLibrary.simpleMessage("Lưu tài khoản"),
        "res_card": MessageLookupByLibrary.simpleMessage("Thẻ cư dân"),
        "res_card_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết thẻ cư dân"),
        "res_card_register":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ cư dân"),
        "res_image_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh cư dân không được để trống"),
        "res_photo": MessageLookupByLibrary.simpleMessage("Ảnh cư dân"),
        "resend": MessageLookupByLibrary.simpleMessage("Gửi lại"),
        "reset_pass": MessageLookupByLibrary.simpleMessage("Đặt lại mật khẩu"),
        "reset_pass_success": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu đã được cập nhật thành công"),
        "resgiter_vehicle_back_image_not_empty":
            MessageLookupByLibrary.simpleMessage(
                "Ảnh đăng ký xe mặt sau không được để trống"),
        "resgiter_vehicle_front_image_not_empty":
            MessageLookupByLibrary.simpleMessage(
                "Ảnh đăng ký xe mặt trước không được để trống"),
        "residence_news":
            MessageLookupByLibrary.simpleMessage("Bảng tin cư dân"),
        "resident_info":
            MessageLookupByLibrary.simpleMessage("Thông tin cư dân"),
        "retry": MessageLookupByLibrary.simpleMessage("Vui lòng kiểm tra lại."),
        "rgstr_code_0": MessageLookupByLibrary.simpleMessage(
            "Đăng ký thành công, vui lòng đăng nhập"),
        "rgstr_code_1": MessageLookupByLibrary.simpleMessage(
            "Thiếu trường thông tin bắt buộc"),
        "rgstr_code_2":
            MessageLookupByLibrary.simpleMessage("Mật khẩu không khớp"),
        "rgstr_code_3": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu phải có ít nhất 8 kí tự. Trong đó phải có ít nhất 1 chữ hoa, 1 chữ thường, 1 số và 1 ký tự đặc biệt"),
        "rgstr_code_4": MessageLookupByLibrary.simpleMessage(
            "Tài khoản đã tồn tại, vui lòng đăng nhập"),
        "rgstr_code_5": MessageLookupByLibrary.simpleMessage(
            "Thông tin người dùng không có sẵn trên hệ thống, vui lòng liên hệ với Admin."),
        "rgstr_code_7":
            MessageLookupByLibrary.simpleMessage("Mã xác thực không hợp lệ"),
        "rgstr_code_8": MessageLookupByLibrary.simpleMessage("Lỗi hệ thống"),
        "rgstr_code_9": MessageLookupByLibrary.simpleMessage(
            "Tài khoản chưa được kích hoạt"),
        "save": MessageLookupByLibrary.simpleMessage("Lưu"),
        "scuccess_participation": m9,
        "search": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
        "search_aparment":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm căn hộ"),
        "search_project":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm dự án"),
        "select": MessageLookupByLibrary.simpleMessage("Chọn"),
        "send_otp_to": MessageLookupByLibrary.simpleMessage(
            "Gửi mã để đặt lại mật khẩu về"),
        "send_request": MessageLookupByLibrary.simpleMessage("Gửi duyệt"),
        "send_to_email":
            MessageLookupByLibrary.simpleMessage("Gửi mã về email"),
        "send_to_phone": MessageLookupByLibrary.simpleMessage("Gửi mã về SDT"),
        "send_verify": MessageLookupByLibrary.simpleMessage("Gửi xác thực"),
        "service_bill":
            MessageLookupByLibrary.simpleMessage("Tiền đăng ký dịch vụ"),
        "service_name": m10,
        "services": MessageLookupByLibrary.simpleMessage("Dịch vụ"),
        "setting": MessageLookupByLibrary.simpleMessage("Cài đặt"),
        "shopping_online":
            MessageLookupByLibrary.simpleMessage("Mua sắm online"),
        "shopping_represent": MessageLookupByLibrary.simpleMessage("Đi chợ hộ"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "sign_out": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "sign_out_msg": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn đăng xuất không ?"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "start": MessageLookupByLibrary.simpleMessage("Bắt đầu"),
        "start_date_after_now": MessageLookupByLibrary.simpleMessage(
            "Ngày bắt đầu không được nhỏ hơn ngày hiện tại"),
        "start_date_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ngày bắt đầu không được để trống"),
        "start_time": MessageLookupByLibrary.simpleMessage("Thời gian bắt đầu"),
        "status": MessageLookupByLibrary.simpleMessage("Trạng thái"),
        "success": MessageLookupByLibrary.simpleMessage("Thành công"),
        "success_can_req": MessageLookupByLibrary.simpleMessage(
            "Hủy đăng ký phiếu thành công"),
        "success_cr_new":
            MessageLookupByLibrary.simpleMessage("Thêm mới thành công"),
        "success_edit":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa thành công"),
        "success_lock_card":
            MessageLookupByLibrary.simpleMessage("Khóa thẻ thành công"),
        "success_opt":
            MessageLookupByLibrary.simpleMessage("Gửi mã OTP thành công"),
        "success_payment": MessageLookupByLibrary.simpleMessage(
            "Bạn đã thanh toán thành công"),
        "success_remove": m11,
        "success_send_req":
            MessageLookupByLibrary.simpleMessage("Gửi duyệt thành công"),
        "success_sign_up":
            MessageLookupByLibrary.simpleMessage("Đăng ký thành công"),
        "take_place_time":
            MessageLookupByLibrary.simpleMessage("Thời gian diễn ra"),
        "terms_services":
            MessageLookupByLibrary.simpleMessage("Điều khoản & dịch vụ"),
        "terms_services_msg": MessageLookupByLibrary.simpleMessage(
            "Đăng ký tài khoản cư dân đồng nghĩa với việc đồng thuận với "),
        "this_trans_letter":
            MessageLookupByLibrary.simpleMessage("Phiếu đăng ký xe này"),
        "time_event_happening":
            MessageLookupByLibrary.simpleMessage("Thời gian diễn ra sự kiện"),
        "time_happening":
            MessageLookupByLibrary.simpleMessage("Thời gian diễn ra"),
        "title": MessageLookupByLibrary.simpleMessage("Tiêu đề"),
        "to_money": MessageLookupByLibrary.simpleMessage("Thành tiền"),
        "total": MessageLookupByLibrary.simpleMessage("Tổng cộng"),
        "tranfer_in": MessageLookupByLibrary.simpleMessage("Chuyển đồ vào"),
        "tranfer_in_reg":
            MessageLookupByLibrary.simpleMessage("Đăng ký chuyển đồ vào"),
        "tranfer_out": MessageLookupByLibrary.simpleMessage("Chuyển đồ ra"),
        "tranfer_out_reg":
            MessageLookupByLibrary.simpleMessage("Đăng ký chuyển đồ ra"),
        "trans_card": MessageLookupByLibrary.simpleMessage("Thẻ xe"),
        "trans_card_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết thẻ phương tiện"),
        "trans_cer": MessageLookupByLibrary.simpleMessage("Đăng ký xe"),
        "trans_info":
            MessageLookupByLibrary.simpleMessage("Thông tin phương tiện"),
        "trans_letter":
            MessageLookupByLibrary.simpleMessage("Phiếu đăng ký xe"),
        "trans_type": MessageLookupByLibrary.simpleMessage("Loại phương tiện"),
        "transfer_list":
            MessageLookupByLibrary.simpleMessage("Danh sách chuyển đồ"),
        "transfer_type": MessageLookupByLibrary.simpleMessage("Loại chuyển"),
        "transportation": MessageLookupByLibrary.simpleMessage("Phương tiện"),
        "type": MessageLookupByLibrary.simpleMessage("Loại"),
        "unpaid": MessageLookupByLibrary.simpleMessage("Đã thanh toán"),
        "update": MessageLookupByLibrary.simpleMessage("Cập nhật"),
        "username": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "vat": MessageLookupByLibrary.simpleMessage("VAT"),
        "verify": MessageLookupByLibrary.simpleMessage("Xác thực"),
        "vi": MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
        "w":
            MessageLookupByLibrary.simpleMessage("Home Community Smart Living"),
        "wait_approve": MessageLookupByLibrary.simpleMessage("Chờ duyệt"),
        "water": MessageLookupByLibrary.simpleMessage("Nước"),
        "water_bill": MessageLookupByLibrary.simpleMessage("Tiền nước"),
        "way_send_otp": MessageLookupByLibrary.simpleMessage(
            "Bạn muốn nhận mã để đặt lại mật khẩu bằng cách nào?"),
        "we_send_to": m12,
        "weight": MessageLookupByLibrary.simpleMessage("Trọng lượng"),
        "wellcome_back":
            MessageLookupByLibrary.simpleMessage("Chào mừng trở lại"),
        "width": MessageLookupByLibrary.simpleMessage("Rộng"),
        "year": MessageLookupByLibrary.simpleMessage("Năm")
      };
}
