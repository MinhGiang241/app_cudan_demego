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

  static String m0(f, t) => "Kỳ hóa đơn từ ${f} đến ${t}";

  static String m1(a) => " Bạn đã hoàn thành nhận bàn giao cho căn hộ [${a}]";

  static String m2(code) =>
      "Bạn có chắc chắn muốn xác nhận phiếu [${code}] không?";

  static String m3(rCode) => "Bạn chắc chắn muốn hủy phản ánh ${rCode}";

  static String m4(name) =>
      "Bạn chắc chắn muốn huỷ lịch bàn giao cho căn hộ [${name}] ?";

  static String m5(code) =>
      "Bạn có chắc chắn hủy đăng ký phiếu [${code}] không?";

  static String m6(plate) =>
      "Bạn có chắc chắn hủy phương tiện [${plate}] không?";

  static String m7(name) =>
      "Bạn chắc chắn muốn đổi lịch hẹn bàn giao, lịch hẹn trước đó cho căn hộ [${name}] sẽ bị hủy?";

  static String m8(letter) =>
      "Bạn có chắc chắn muốn xóa phiếu [${letter}] không?";

  static String m9(delete) => "Bạn có chắc chắn muốn xóa [${delete}] không?";

  static String m10(card) => "Bạn có muốn khóa thẻ [${card}] không?";

  static String m11(code) =>
      "Bạn có chắc chắn muốn báo mất thẻ xe ${code} không?";

  static String m12(code) =>
      "Bạn có chắc chắn muốn báo mất thẻ cư dân ${code} không?";

  static String m13(eventName) =>
      "Bạn chắc chắn muốn tham gia sự kiện [${eventName}] không?";

  static String m14(code) =>
      "Bạn có chắc chắn muốn từ chối phiếu [${code}] không?";

  static String m15(approved) =>
      "Bạn có muốn gửi duyệt phiếu [${approved}] không?";

  static String m16(c) =>
      "Danh sách bàn giao có ${c} danh mục không đạt Bạn chắc chắn muốn xác nhận nhận bàn giao.";

  static String m17(nameser) => "Chỉnh sửa đăng ký dịch vụ ${nameser}";

  static String m18(message) => "Lỗi: ${message}";

  static String m19(s) => "Giá trị không lớn hơn ${s}";

  static String m20(numAsset) =>
      "Danh sách bàn giao có ${numAsset} tài sản không đạt";

  static String m21(nameser) => "Đăng ký dịch vụ ${nameser}";

  static String m22(eName) => "Bạn đã xác nhận tham gia [${eName}] thành công";

  static String m23(service) => "Dịch vụ ${service}";

  static String m24(person, build) =>
      "bạn đã thêm ${person} vào căn hộ ${build}. Vui lòng chờ BQL phê duyệt";

  static String m25(name) =>
      "Bạn đã đặt lịch thành công cho căn hộ [${name}] . Vui lòng chờ BQL phê duyệt.";

  static String m26(name) =>
      "Bạn đã hủy lịch bàn giao thành công cho căn hộ [${name}]";

  static String m27(ap) => "Bạn đã bàn giao thành công cho căn hộ ${ap}";

  static String m28(p) => "Bạn đã thanh toán cho ${p} thành công ";

  static String m29(month, year) =>
      "Tổng lượng nước thiêu thụ tháng ${month}/${year}";

  static String m30(to) => "Chúng tôi đã gửi cho bạn mã đến: ${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "abrv": MessageLookupByLibrary.simpleMessage("Ký hiệu"),
        "accept_hand_over":
            MessageLookupByLibrary.simpleMessage("Nhận bàn giao"),
        "account": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "account_name": MessageLookupByLibrary.simpleMessage("Tên đăng nhập"),
        "account_type": MessageLookupByLibrary.simpleMessage("Loại tài khoản"),
        "active": MessageLookupByLibrary.simpleMessage("Hoạt động"),
        "add": MessageLookupByLibrary.simpleMessage("Thêm"),
        "add_dependent_person":
            MessageLookupByLibrary.simpleMessage("Người phụ thuộc "),
        "add_dependent_person_to_apartment":
            MessageLookupByLibrary.simpleMessage("Thêm người vào căn hộ"),
        "add_email": MessageLookupByLibrary.simpleMessage("Thêm email"),
        "add_extend_request_successfull": MessageLookupByLibrary.simpleMessage(
            "Thêm mới đề xuất gia hạn thành công"),
        "add_file": MessageLookupByLibrary.simpleMessage("Thêm file"),
        "add_new": MessageLookupByLibrary.simpleMessage("Thêm mới"),
        "add_new_transport":
            MessageLookupByLibrary.simpleMessage("Thêm mới phương tiện"),
        "add_package": MessageLookupByLibrary.simpleMessage("Thêm hàng hóa"),
        "add_package_need_transfer": MessageLookupByLibrary.simpleMessage(
            "Thêm hàng hóa cần vận chuyển"),
        "add_photo": MessageLookupByLibrary.simpleMessage("Thêm hình ảnh"),
        "add_reflection":
            MessageLookupByLibrary.simpleMessage("Thêm mới phản ánh"),
        "add_trans_card":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ mới"),
        "add_transport":
            MessageLookupByLibrary.simpleMessage("Thêm phương tiện"),
        "additional_file":
            MessageLookupByLibrary.simpleMessage("File/ Ảnh bổ sung"),
        "address": MessageLookupByLibrary.simpleMessage("Địa chỉ"),
        "al_read": MessageLookupByLibrary.simpleMessage("Đã đọc"),
        "all": MessageLookupByLibrary.simpleMessage("Tất cả"),
        "already_delete_acc": MessageLookupByLibrary.simpleMessage(
            "Bạn đã xóa tài khoản thành công"),
        "amount": MessageLookupByLibrary.simpleMessage("Số lượng"),
        "apartment": MessageLookupByLibrary.simpleMessage("Căn hộ"),
        "apartment_add_resident":
            MessageLookupByLibrary.simpleMessage("Căn hộ thêm cư dân"),
        "apartment_bill":
            MessageLookupByLibrary.simpleMessage("Tiền phí chung cư"),
        "apartment_not_empty":
            MessageLookupByLibrary.simpleMessage("Căn hộ không được để trống"),
        "app_version": MessageLookupByLibrary.simpleMessage("App version"),
        "appoved_status":
            MessageLookupByLibrary.simpleMessage("Tình trạng duyệt"),
        "approve_1": MessageLookupByLibrary.simpleMessage("Duyệt lần 1"),
        "approve_2": MessageLookupByLibrary.simpleMessage("Duyệt lần 2"),
        "approve_3": MessageLookupByLibrary.simpleMessage("Duyệt lần 3"),
        "approved": MessageLookupByLibrary.simpleMessage("Đã duyệt"),
        "approved_date": MessageLookupByLibrary.simpleMessage("Ngày phê duyệt"),
        "area": MessageLookupByLibrary.simpleMessage("Diện tích"),
        "arrived_date": MessageLookupByLibrary.simpleMessage("Ngày đến"),
        "asset": MessageLookupByLibrary.simpleMessage("Tài sản"),
        "asset_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết danh mục tài sản"),
        "asset_list":
            MessageLookupByLibrary.simpleMessage("Danh sách danh mục tài sản"),
        "asset_name": MessageLookupByLibrary.simpleMessage("Tên tài sản"),
        "attachment_file":
            MessageLookupByLibrary.simpleMessage("Tài liệu đính kèm"),
        "back_side": MessageLookupByLibrary.simpleMessage("Mặt sau"),
        "base_info": MessageLookupByLibrary.simpleMessage("Thông tin cơ bản"),
        "bill": MessageLookupByLibrary.simpleMessage("Phiếu thu"),
        "bill_code": MessageLookupByLibrary.simpleMessage("Mã hóa đơn"),
        "bill_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết hóa đơn"),
        "bill_from_to": m0,
        "bill_history": MessageLookupByLibrary.simpleMessage("Lịch sử hóa đơn"),
        "bill_name": MessageLookupByLibrary.simpleMessage("Tên hóa đơn"),
        "bills": MessageLookupByLibrary.simpleMessage("Hóa đơn"),
        "birthday_congratulaion":
            MessageLookupByLibrary.simpleMessage("Chúc mừng sinh nhật"),
        "block": MessageLookupByLibrary.simpleMessage("Phường /xã"),
        "booking": MessageLookupByLibrary.simpleMessage("Đặt lịch"),
        "booking_hand_over":
            MessageLookupByLibrary.simpleMessage("Lịch đặt nhận bàn giao"),
        "booking_hand_over_0":
            MessageLookupByLibrary.simpleMessage("Đặt lịch nhận bàn giao"),
        "booking_his": MessageLookupByLibrary.simpleMessage("Lịch sử bàn giao"),
        "brand": MessageLookupByLibrary.simpleMessage("Thương hiệu"),
        "building": MessageLookupByLibrary.simpleMessage("Tòa"),
        "building_regulation":
            MessageLookupByLibrary.simpleMessage("Quy định của tòa nhà"),
        "building_regulation_trans": MessageLookupByLibrary.simpleMessage(
            "Quy định vể gửi xe của tòa nhà"),
        "buyer": MessageLookupByLibrary.simpleMessage("Chủ sở hữu"),
        "c_new_pass":
            MessageLookupByLibrary.simpleMessage("Nhập lại mật khẩu mới"),
        "camera": MessageLookupByLibrary.simpleMessage("Máy ảnh"),
        "can_not_empty":
            MessageLookupByLibrary.simpleMessage("Không được để trống"),
        "can_schedule": MessageLookupByLibrary.simpleMessage("Hủy lịch"),
        "can_schedule_hand_over":
            MessageLookupByLibrary.simpleMessage("Huỷ lịch bàn giao"),
        "can_trans": MessageLookupByLibrary.simpleMessage("Hủy thẻ xe"),
        "can_trans_res": MessageLookupByLibrary.simpleMessage("Hủy thẻ cư dân"),
        "cancel": MessageLookupByLibrary.simpleMessage("Huỷ"),
        "cancel_card": MessageLookupByLibrary.simpleMessage("Hủy thẻ"),
        "cancel_letter": MessageLookupByLibrary.simpleMessage("Hủy phiếu"),
        "cancel_reason": MessageLookupByLibrary.simpleMessage("Lý do hủy"),
        "cancel_reflection":
            MessageLookupByLibrary.simpleMessage("Hủy phản ánh"),
        "cancel_reg": MessageLookupByLibrary.simpleMessage("Hủy đăng ký"),
        "cancel_register": MessageLookupByLibrary.simpleMessage("Hủy đăng ký"),
        "cancel_request": MessageLookupByLibrary.simpleMessage("Hủy đăng ký"),
        "cancel_transport":
            MessageLookupByLibrary.simpleMessage("Hủy phương tiện"),
        "card_list": MessageLookupByLibrary.simpleMessage("Danh sách thẻ"),
        "card_num": MessageLookupByLibrary.simpleMessage("Mã thẻ"),
        "card_status": MessageLookupByLibrary.simpleMessage("Trạng thái thẻ"),
        "card_unit": MessageLookupByLibrary.simpleMessage("Thẻ"),
        "card_unit2": MessageLookupByLibrary.simpleMessage("Cái"),
        "cat": MessageLookupByLibrary.simpleMessage("Mèo"),
        "category": MessageLookupByLibrary.simpleMessage("Danh mục"),
        "category_name": MessageLookupByLibrary.simpleMessage("Tên danh mục"),
        "cer_vacxin_doc": MessageLookupByLibrary.simpleMessage(
            "Giấy chứng nhận tiêm phòng dại"),
        "certificate_not_empty": MessageLookupByLibrary.simpleMessage(
            "Giấy chứng nhận tiêm phòng dại không được để trống"),
        "change": MessageLookupByLibrary.simpleMessage("Đổi"),
        "change_email": MessageLookupByLibrary.simpleMessage("Đổi email"),
        "change_pass": MessageLookupByLibrary.simpleMessage("Đổi mật khẩu"),
        "change_schedule": MessageLookupByLibrary.simpleMessage("Đổi lịch hẹn"),
        "chart": MessageLookupByLibrary.simpleMessage("Biểu đồ"),
        "choices": MessageLookupByLibrary.simpleMessage("Lựa chọn"),
        "choose_a_project": MessageLookupByLibrary.simpleMessage("Chọn dự án"),
        "choose_an_apartment":
            MessageLookupByLibrary.simpleMessage("Chọn căn hộ"),
        "choose_subject": MessageLookupByLibrary.simpleMessage(
            "Để tham khảo các lựa chọn, vui lòng chọn bên dưới:"),
        "click_here": MessageLookupByLibrary.simpleMessage("vào đây"),
        "close": MessageLookupByLibrary.simpleMessage("Đóng"),
        "cmnd": MessageLookupByLibrary.simpleMessage("CMND/ CCCD/ Hộ chiếu"),
        "cmnd_images": MessageLookupByLibrary.simpleMessage(
            "Ảnh CMND/CCCD (ảnh chụp 2 mặt)"),
        "cmnd_images_not_less_2": MessageLookupByLibrary.simpleMessage(
            "Ảnh CMND/CCCD phải ít nhất 2 ảnh"),
        "cmnd_length_9":
            MessageLookupByLibrary.simpleMessage("Không được ít hơn 9 ký tự"),
        "cmnd_photos":
            MessageLookupByLibrary.simpleMessage("Ảnh CMND / CCCD / Hộ chiếu"),
        "code_file": MessageLookupByLibrary.simpleMessage("Mã hồ sơ"),
        "code_verify": MessageLookupByLibrary.simpleMessage("Nhập mã bảo mật"),
        "college_degree": MessageLookupByLibrary.simpleMessage("Bằng cao đẳng"),
        "color": MessageLookupByLibrary.simpleMessage("Màu sắc"),
        "coming_soon": MessageLookupByLibrary.simpleMessage("Sắp diễn ra"),
        "complain": MessageLookupByLibrary.simpleMessage("Khiếu nại"),
        "complain_reason":
            MessageLookupByLibrary.simpleMessage("Lý do khiếu nại"),
        "complete": MessageLookupByLibrary.simpleMessage("Hoàn thành"),
        "complete_handover": m1,
        "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
        "confirm_accept_letter": m2,
        "confirm_can_reflection": m3,
        "confirm_can_schedule": m4,
        "confirm_can_trans_card": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn hủy thẻ xe không?"),
        "confirm_can_trans_card_res": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn hủy thẻ cư dân không?"),
        "confirm_cancel_request": m5,
        "confirm_cancel_trans": m6,
        "confirm_change_schedule": m7,
        "confirm_delete_account": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn xóa tài khoản không"),
        "confirm_delete_letter": m8,
        "confirm_delete_service": m9,
        "confirm_end_chat": MessageLookupByLibrary.simpleMessage(
            "Bạn chắc chắn muốn kết thúc cuộc trò chuyện."),
        "confirm_hand_over": MessageLookupByLibrary.simpleMessage(
            "Bạn chắc chắn muốn xác nhận bàn giao."),
        "confirm_lock_card": m10,
        "confirm_lock_trans_card": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc chắn muốn khóa thẻ xe không?"),
        "confirm_missing_report": m11,
        "confirm_missing_report_res": m12,
        "confirm_obey_regulation": MessageLookupByLibrary.simpleMessage(
            "Xác nhận tuân thủ quy định của tòa nhà:"),
        "confirm_par_ques_event": m13,
        "confirm_participate_event":
            MessageLookupByLibrary.simpleMessage("Xác nhận tham gia sự kiện"),
        "confirm_pass":
            MessageLookupByLibrary.simpleMessage("Nhập lại mật khẩu"),
        "confirm_refuse_letter": m14,
        "confirm_send_request": m15,
        "confirmed": MessageLookupByLibrary.simpleMessage("Đã xác nhận"),
        "confirmed_by_manager_resident": MessageLookupByLibrary.simpleMessage(
            "Cư dân đã được xác nhận bởi BQL"),
        "confirmed_card":
            MessageLookupByLibrary.simpleMessage("Thẻ được xác nhận bởi BQL"),
        "cons_agree": MessageLookupByLibrary.simpleMessage(
            "Bạn cần đồng ý tuân thủ quy định về đăng ký thi công"),
        "cons_code": MessageLookupByLibrary.simpleMessage("Mã thi công"),
        "cons_day": MessageLookupByLibrary.simpleMessage("Số ngày thi công"),
        "cons_drawing": MessageLookupByLibrary.simpleMessage("Bản vẽ thi công"),
        "cons_fee": MessageLookupByLibrary.simpleMessage("Phí thi công"),
        "cons_file": MessageLookupByLibrary.simpleMessage("Hồ sơ thi công"),
        "cons_file_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết hồ sơ thi công"),
        "cons_info": MessageLookupByLibrary.simpleMessage("Thông tin thi công"),
        "cons_list": MessageLookupByLibrary.simpleMessage("Danh sách thi công"),
        "cons_reg": MessageLookupByLibrary.simpleMessage("Đăng ký thi công"),
        "cons_reg_detail":
            MessageLookupByLibrary.simpleMessage("Chi tiết đăng ký thi công"),
        "cons_reg_letter":
            MessageLookupByLibrary.simpleMessage("Phiếu đăng ký thi công"),
        "cons_regulation":
            MessageLookupByLibrary.simpleMessage("Quy định thi công"),
        "cons_type": MessageLookupByLibrary.simpleMessage("Loại thi công"),
        "cons_unit": MessageLookupByLibrary.simpleMessage("Đơn vị thi công"),
        "cons_unit_info":
            MessageLookupByLibrary.simpleMessage("Thông tin đơn vị thi công"),
        "construction": MessageLookupByLibrary.simpleMessage("Thi công"),
        "construction_extend":
            MessageLookupByLibrary.simpleMessage("Gia hạn thi công"),
        "consume_elec":
            MessageLookupByLibrary.simpleMessage("Điện năng tiêu thụ"),
        "consumed_elec_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết điện năng tiêu thụ"),
        "consumed_water":
            MessageLookupByLibrary.simpleMessage("Lượng nước tiêu thụ"),
        "consumed_water_detail": MessageLookupByLibrary.simpleMessage(
            "Chi tiết lượng nước tiêu thụ"),
        "consumed_water_detail1":
            MessageLookupByLibrary.simpleMessage("Chi tiết lượng nước sử dụng"),
        "content": MessageLookupByLibrary.simpleMessage("Nội dung"),
        "continue_construction":
            MessageLookupByLibrary.simpleMessage("Mở khóa thi công"),
        "count_err_handover": m16,
        "covenient_service": MessageLookupByLibrary.simpleMessage("Tiện ích"),
        "create_acc": MessageLookupByLibrary.simpleMessage("Đăng ký tài khoản"),
        "create_acc_1": MessageLookupByLibrary.simpleMessage("Tạo tài khoản"),
        "create_new": MessageLookupByLibrary.simpleMessage("Tạo mới"),
        "create_reg_proj":
            MessageLookupByLibrary.simpleMessage("Tạo đăng ký mới"),
        "created_date": MessageLookupByLibrary.simpleMessage("Ngày tạo"),
        "current_pass":
            MessageLookupByLibrary.simpleMessage("Mật khẩu hiện tại"),
        "customer_care":
            MessageLookupByLibrary.simpleMessage("Chăm sóc khách hàng"),
        "date": MessageLookupByLibrary.simpleMessage("Ngày"),
        "date_send": MessageLookupByLibrary.simpleMessage("Ngày gửi"),
        "debt": MessageLookupByLibrary.simpleMessage("Thu tiền, nhắc nợ"),
        "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
        "delete_account": MessageLookupByLibrary.simpleMessage("Xóa tài khoản"),
        "delete_letter": MessageLookupByLibrary.simpleMessage("Xóa phiếu"),
        "delivery_info":
            MessageLookupByLibrary.simpleMessage("Thông tin đồ chuyển"),
        "delivery_letter":
            MessageLookupByLibrary.simpleMessage("Phiếu đăng ký chuyển đồ"),
        "dependence_has_info": MessageLookupByLibrary.simpleMessage(
            "Người phụ thuộc đã có thông tin"),
        "dependence_not_info":
            MessageLookupByLibrary.simpleMessage("Người phụ thuộc mới"),
        "dependent_apartment":
            MessageLookupByLibrary.simpleMessage("Căn hộ thêm phụ thuộc"),
        "dependent_host":
            MessageLookupByLibrary.simpleMessage("Phụ thuộc người mua"),
        "dependent_person":
            MessageLookupByLibrary.simpleMessage("Người phụ thuộc"),
        "dependent_rent":
            MessageLookupByLibrary.simpleMessage("Phụ thuộc người thuê"),
        "deposit": MessageLookupByLibrary.simpleMessage("Đặt cọc"),
        "deputy": MessageLookupByLibrary.simpleMessage("Người đại diện"),
        "deputy_phone":
            MessageLookupByLibrary.simpleMessage("SĐT người đại diện"),
        "description": MessageLookupByLibrary.simpleMessage("Mô tả"),
        "detail_view": MessageLookupByLibrary.simpleMessage("Xem chi tiết"),
        "details": MessageLookupByLibrary.simpleMessage("Chi tiết"),
        "details_bill":
            MessageLookupByLibrary.simpleMessage("Hóa đơn chi tiết"),
        "dimention": MessageLookupByLibrary.simpleMessage("Kích thước"),
        "discount": MessageLookupByLibrary.simpleMessage("Chiết khấu"),
        "discount_type":
            MessageLookupByLibrary.simpleMessage("Loại chiết khấu"),
        "dob": MessageLookupByLibrary.simpleMessage("Ngày sinh"),
        "doctor_degree": MessageLookupByLibrary.simpleMessage("Bằng tiến sĩ"),
        "dog": MessageLookupByLibrary.simpleMessage("Chó"),
        "done": MessageLookupByLibrary.simpleMessage("Xong"),
        "drawing": MessageLookupByLibrary.simpleMessage("Bản vẽ"),
        "due_bill": MessageLookupByLibrary.simpleMessage("Hạn thanh toán"),
        "edit": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
        "edit_package": MessageLookupByLibrary.simpleMessage("Sửa hàng hóa"),
        "edit_reflection":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa phản ánh"),
        "edit_reg_const":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa đăng ký thi công"),
        "edit_reg_deliver":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa đăng ký chuyển đồ"),
        "edit_reg_pet":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa đăng ký vật nuôi"),
        "edit_reg_transport": MessageLookupByLibrary.simpleMessage(
            "Chỉnh sửa đăng ký thẻ phương tiện"),
        "edit_res_card":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa thẻ cư dân"),
        "edit_service_a": m17,
        "edit_trans_card":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa thẻ phương tiện"),
        "edit_transport":
            MessageLookupByLibrary.simpleMessage("Sửa phương tiện"),
        "education_level":
            MessageLookupByLibrary.simpleMessage("Trình độ học vấn"),
        "elcetric_bill": MessageLookupByLibrary.simpleMessage("Tiền điện"),
        "elec_details": MessageLookupByLibrary.simpleMessage(
            "Chi tiết số điện nắng sử dụng"),
        "elec_index": MessageLookupByLibrary.simpleMessage("Chỉ số điện"),
        "elect_consume_chart":
            MessageLookupByLibrary.simpleMessage("Biểu đồ điện năng tiêu thụ"),
        "electricity": MessageLookupByLibrary.simpleMessage("Điện"),
        "elevator_card": MessageLookupByLibrary.simpleMessage("Thẻ thang máy"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "email_not_empty":
            MessageLookupByLibrary.simpleMessage("Email không được để trống"),
        "email_not_same": MessageLookupByLibrary.simpleMessage(
            "Email mới không được trùng với email cũ"),
        "employee_handover": MessageLookupByLibrary.simpleMessage(
            "Nhân viên phụ trách bàn giao"),
        "en": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
        "end": MessageLookupByLibrary.simpleMessage("Kết thúc"),
        "end_chat":
            MessageLookupByLibrary.simpleMessage("Kết thúc cuộc trò chuyện!"),
        "end_date": MessageLookupByLibrary.simpleMessage("Ngày kết thúc"),
        "end_date_after_now": MessageLookupByLibrary.simpleMessage(
            "Ngày kết thúc không được nhỏ hơn ngày hiện tại"),
        "end_date_after_start_date": MessageLookupByLibrary.simpleMessage(
            "Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu "),
        "end_date_extend":
            MessageLookupByLibrary.simpleMessage("Ngày kết thúc gia hạn"),
        "end_date_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ngày kết thúc không được để trống"),
        "end_time": MessageLookupByLibrary.simpleMessage("Thời gian kết thúc"),
        "end_time_reg":
            MessageLookupByLibrary.simpleMessage("Thời gian kết thúc đăng ký"),
        "enter": MessageLookupByLibrary.simpleMessage("Nhập"),
        "enter_address": MessageLookupByLibrary.simpleMessage("Nhập địa chỉ"),
        "enter_cons_unit_name":
            MessageLookupByLibrary.simpleMessage("Nhập tên đơn vị thi công"),
        "enter_deputy_name":
            MessageLookupByLibrary.simpleMessage("Nhập tên người đại diện"),
        "enter_email":
            MessageLookupByLibrary.simpleMessage("Nhập địa chỉ email"),
        "enter_email_phone":
            MessageLookupByLibrary.simpleMessage("Nhập SĐT/Email "),
        "enter_identity":
            MessageLookupByLibrary.simpleMessage("Nhập CMND/ CCCD/ Hộ chiếu"),
        "enter_license_num":
            MessageLookupByLibrary.simpleMessage("Nhập biển số xe"),
        "enter_name": MessageLookupByLibrary.simpleMessage("Nhập họ và tên"),
        "enter_num": MessageLookupByLibrary.simpleMessage("Nhập số"),
        "enter_pas": MessageLookupByLibrary.simpleMessage("Nhập mật khẩu"),
        "enter_payment_pass":
            MessageLookupByLibrary.simpleMessage("Nhập mật khẩu thanh toán"),
        "enter_phone":
            MessageLookupByLibrary.simpleMessage("Nhập số điện thoại"),
        "enter_phone_email": MessageLookupByLibrary.simpleMessage(
            "Nhập số điện thoại hoặc email"),
        "enter_reason_refuse":
            MessageLookupByLibrary.simpleMessage("Nhập lý do từ chối"),
        "enter_reg_num":
            MessageLookupByLibrary.simpleMessage("Nhập số đăng ký xe"),
        "enter_sell_contract_num":
            MessageLookupByLibrary.simpleMessage("Nhập số hợp đồng mua bán"),
        "enter_username":
            MessageLookupByLibrary.simpleMessage("Nhập tên tài khoản"),
        "enter_worker_num":
            MessageLookupByLibrary.simpleMessage("Nhập số công nhân"),
        "err_conn": MessageLookupByLibrary.simpleMessage("Lỗi kết nối "),
        "err_internet": MessageLookupByLibrary.simpleMessage(
            "Không kết nối được với máy chủ"),
        "err_reason": MessageLookupByLibrary.simpleMessage("Lý do báo lỗi"),
        "err_report": MessageLookupByLibrary.simpleMessage("Báo lỗi"),
        "err_unknown":
            MessageLookupByLibrary.simpleMessage("Lỗi Không xác định"),
        "err_upload": MessageLookupByLibrary.simpleMessage("Upload file lỗi"),
        "err_x": m18,
        "error": MessageLookupByLibrary.simpleMessage("Có lỗi xảy ra"),
        "ethnic": MessageLookupByLibrary.simpleMessage("Dân tộc"),
        "event": MessageLookupByLibrary.simpleMessage("Sự kiện"),
        "event_msg": MessageLookupByLibrary.simpleMessage(
            "Theo dõi các sự kiện từng ngày/ tháng"),
        "event_notification":
            MessageLookupByLibrary.simpleMessage("Thông báo sự kiện, tin tức"),
        "executed": MessageLookupByLibrary.simpleMessage("Đã xử lý"),
        "executing": MessageLookupByLibrary.simpleMessage("Đang xử lý"),
        "exist_drawing":
            MessageLookupByLibrary.simpleMessage("Bản vẽ hiện trạng"),
        "existed_drawing_not_empty": MessageLookupByLibrary.simpleMessage(
            "Bản vẽ hiện trạng không được bỏ trống"),
        "expired": MessageLookupByLibrary.simpleMessage("Hết hạn"),
        "expired_date": MessageLookupByLibrary.simpleMessage("Ngày hết hạn"),
        "expired_date_create":
            MessageLookupByLibrary.simpleMessage("Ngày gia hạn"),
        "expired_date_new":
            MessageLookupByLibrary.simpleMessage("Ngày hết hạn mới"),
        "expired_date_old":
            MessageLookupByLibrary.simpleMessage("Ngày hết hạn hiện tại"),
        "expired_login": MessageLookupByLibrary.simpleMessage(
            "Phiên đăng nhập hết hạn, hãy đăng nhập lại"),
        "extend": MessageLookupByLibrary.simpleMessage("Gia hạn"),
        "extend_letter": MessageLookupByLibrary.simpleMessage("Phiếu gia hạn"),
        "fa": MessageLookupByLibrary.simpleMessage("Độc thân"),
        "facebook": MessageLookupByLibrary.simpleMessage("Facebook"),
        "failure": MessageLookupByLibrary.simpleMessage("Thất bại"),
        "fee_paid": MessageLookupByLibrary.simpleMessage("Đã đóng phí"),
        "feedback": MessageLookupByLibrary.simpleMessage("Góp ý"),
        "female": MessageLookupByLibrary.simpleMessage("Nữ"),
        "file_code": MessageLookupByLibrary.simpleMessage("Mã hồ sơ"),
        "file_downloading":
            MessageLookupByLibrary.simpleMessage("Đang tải file xuống"),
        "file_image": MessageLookupByLibrary.simpleMessage("File/ Ảnh"),
        "file_info": MessageLookupByLibrary.simpleMessage("Thông tin hồ sơ"),
        "file_not_support": MessageLookupByLibrary.simpleMessage(
            "File tải lên không đúng định dạng. Vui lòng tải lại"),
        "file_selection": MessageLookupByLibrary.simpleMessage("Chọn file"),
        "file_status": MessageLookupByLibrary.simpleMessage("Trạng thái hồ sơ"),
        "find_time_now": MessageLookupByLibrary.simpleMessage(
            "Thời điểm thấy phải nhỏ hơn hoặc bằng ngày hiện tại"),
        "finish": MessageLookupByLibrary.simpleMessage("Kết thúc"),
        "floor": MessageLookupByLibrary.simpleMessage("Tầng"),
        "follow_ser": MessageLookupByLibrary.simpleMessage("Theo dõi dịch vụ"),
        "forgot_pass": MessageLookupByLibrary.simpleMessage("Quên mật khẩu?"),
        "forum": MessageLookupByLibrary.simpleMessage("Diễn đàn"),
        "found": MessageLookupByLibrary.simpleMessage("Chờ xác nhận"),
        "found_object":
            MessageLookupByLibrary.simpleMessage("Vật phẩm tìm thấy"),
        "found_place": MessageLookupByLibrary.simpleMessage("Địa điểm thấy"),
        "found_time": MessageLookupByLibrary.simpleMessage("Thời điểm thấy"),
        "free_res_card":
            MessageLookupByLibrary.simpleMessage("Thẻ cư dân miễn phí"),
        "free_service":
            MessageLookupByLibrary.simpleMessage("Dịch vụ không tính phí"),
        "front_side": MessageLookupByLibrary.simpleMessage("Mặt trước"),
        "full_name": MessageLookupByLibrary.simpleMessage("Họ và tên"),
        "gallery": MessageLookupByLibrary.simpleMessage("Thư viện"),
        "general_info": MessageLookupByLibrary.simpleMessage("Thông tin chung"),
        "general_notification":
            MessageLookupByLibrary.simpleMessage("Thông báo chung"),
        "go_high_school":
            MessageLookupByLibrary.simpleMessage("Đang học trung học"),
        "go_university":
            MessageLookupByLibrary.simpleMessage("Đang học đại học"),
        "guest": MessageLookupByLibrary.simpleMessage("Khách"),
        "guest_account":
            MessageLookupByLibrary.simpleMessage("Tài khoản khách"),
        "gym_card": MessageLookupByLibrary.simpleMessage("Dịch vụ Gym"),
        "hand_date": MessageLookupByLibrary.simpleMessage("Ngày nhận"),
        "hand_over": MessageLookupByLibrary.simpleMessage("Nhận bàn giao"),
        "hand_over_asset_list":
            MessageLookupByLibrary.simpleMessage("Danh sách tài sản bàn giao"),
        "hand_over_date":
            MessageLookupByLibrary.simpleMessage("Ngày nhận bàn giao"),
        "hand_over_employee": MessageLookupByLibrary.simpleMessage(
            "Nhân viên phụ trách bàn giao"),
        "hand_over_rule":
            MessageLookupByLibrary.simpleMessage("Quy định bàn giao"),
        "hand_over_time":
            MessageLookupByLibrary.simpleMessage("Giờ nhận bàn giao"),
        "hand_time": MessageLookupByLibrary.simpleMessage("Giờ nhận"),
        "handed_over": MessageLookupByLibrary.simpleMessage("Đã bàn giao"),
        "handing_over": MessageLookupByLibrary.simpleMessage("Đang bàn giao"),
        "happened": MessageLookupByLibrary.simpleMessage("Đã diễn ra"),
        "happening": MessageLookupByLibrary.simpleMessage("Đang diễn ra"),
        "happening_location":
            MessageLookupByLibrary.simpleMessage("Địa điểm diễn ra"),
        "have_acc":
            MessageLookupByLibrary.simpleMessage("Bạn đã có tài khoản?"),
        "have_baby": MessageLookupByLibrary.simpleMessage("Đã có con"),
        "height": MessageLookupByLibrary.simpleMessage("cao"),
        "hello": MessageLookupByLibrary.simpleMessage("Xin chào"),
        "here": MessageLookupByLibrary.simpleMessage("tại đây"),
        "high_school_degree":
            MessageLookupByLibrary.simpleMessage("Tốt nghiệp trung học"),
        "his_reg_service":
            MessageLookupByLibrary.simpleMessage("Lịch sử đăng ký dịch vụ"),
        "history": MessageLookupByLibrary.simpleMessage("Lịch sử"),
        "history_find_obj":
            MessageLookupByLibrary.simpleMessage("Lịch sử tìm đồ"),
        "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
        "hour": MessageLookupByLibrary.simpleMessage("Giờ"),
        "housework": MessageLookupByLibrary.simpleMessage("Giúp việc"),
        "i_agree": MessageLookupByLibrary.simpleMessage("Tôi đồng ý tuân thủ"),
        "i_confirm": MessageLookupByLibrary.simpleMessage(
            "Tôi xác nhận sẽ tuân thủ các quy định về thi công và sẽ chịu đền bù mọi tổn thất, khiếu nại, chi phí phát sinh từ công việc xây dựng, sửa chữa này. Xem thêm"),
        "i_found": MessageLookupByLibrary.simpleMessage("Đã tìm thấy"),
        "identity_back_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh CMND/CCCD/Hộ chiếu mặt sau không được để trống"),
        "identity_front_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh CMND/CCCD/Hộ chiếu mặt trước không được để trống"),
        "identity_photo":
            MessageLookupByLibrary.simpleMessage("Ảnh CMND/ CCCD/ Hộ chiếu"),
        "if_not_resident": MessageLookupByLibrary.simpleMessage(
            "Nếu Anh/Chị chưa đăng ký thông tin cư dân vui lòng click"),
        "image_not_empty": MessageLookupByLibrary.simpleMessage(
            "Hình ảnh không được để trống"),
        "inactive": MessageLookupByLibrary.simpleMessage("Dừng hoạt động"),
        "incorrect_usn_pass": MessageLookupByLibrary.simpleMessage(
            "Số điện thoại/Email hoặc mật khẩu không chính xác."),
        "info": MessageLookupByLibrary.simpleMessage("Thông tin"),
        "info_reception":
            MessageLookupByLibrary.simpleMessage("Tiếp nhận thông tin"),
        "instagram": MessageLookupByLibrary.simpleMessage("Instagram"),
        "intergrate_existed_resident_card":
            MessageLookupByLibrary.simpleMessage(
                "Tích hợp vào thẻ cư dân có sẵn"),
        "internet": MessageLookupByLibrary.simpleMessage("Internet"),
        "invalid_data":
            MessageLookupByLibrary.simpleMessage("Dữ liệu không hợp lệ"),
        "issue_res_card":
            MessageLookupByLibrary.simpleMessage("Thẻ cư dân miễn phí đã cấp"),
        "item_list_not_empty": MessageLookupByLibrary.simpleMessage(
            "Danh sách chuyển đồ không được để trống"),
        "job": MessageLookupByLibrary.simpleMessage("Nghề nghiệp"),
        "l_new": MessageLookupByLibrary.simpleMessage("Mới"),
        "l_w_e": MessageLookupByLibrary.simpleMessage("Dài x rộng x cao"),
        "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
        "legend": MessageLookupByLibrary.simpleMessage("Ghi chú"),
        "letter_info": MessageLookupByLibrary.simpleMessage("Thông tin phiếu"),
        "letter_num": MessageLookupByLibrary.simpleMessage("Mã phiếu"),
        "letter_status":
            MessageLookupByLibrary.simpleMessage("Trạng thái phiếu"),
        "licene_plate": MessageLookupByLibrary.simpleMessage("Biển số xe"),
        "limit_15mb": MessageLookupByLibrary.simpleMessage(
            "Giới hạn mỗi file tải lên không vượt quá 15MB/file"),
        "linkedin": MessageLookupByLibrary.simpleMessage("Linkedin"),
        "list_transport":
            MessageLookupByLibrary.simpleMessage("Danh sách phương tiện"),
        "location": MessageLookupByLibrary.simpleMessage("Vị trí"),
        "lock": MessageLookupByLibrary.simpleMessage("Khóa"),
        "lock_card": MessageLookupByLibrary.simpleMessage("Khóa thẻ"),
        "lock_reason": MessageLookupByLibrary.simpleMessage("Lý do khóa"),
        "long": MessageLookupByLibrary.simpleMessage("Dài"),
        "lost_time": MessageLookupByLibrary.simpleMessage("Giờ thất lạc"),
        "lost_time_now": MessageLookupByLibrary.simpleMessage(
            "Thời điểm thất lạc không được lớn hơn ngày hiện tại"),
        "male": MessageLookupByLibrary.simpleMessage("Nam"),
        "married": MessageLookupByLibrary.simpleMessage("Đã kết hôn"),
        "master_degree": MessageLookupByLibrary.simpleMessage("Bằng thạc sĩ"),
        "material": MessageLookupByLibrary.simpleMessage("Vật liệu"),
        "material0": MessageLookupByLibrary.simpleMessage("Vật liệu"),
        "material_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết danh mục vật liệu"),
        "material_list":
            MessageLookupByLibrary.simpleMessage("Danh sách danh mục vật liệu"),
        "material_specification":
            MessageLookupByLibrary.simpleMessage("Vật liệu, quy cách"),
        "matial_status":
            MessageLookupByLibrary.simpleMessage("Tình trạng hôn nhân"),
        "max_day_pay":
            MessageLookupByLibrary.simpleMessage("Số ngày thanh toán tối đa"),
        "max_pay_day_not_empty": MessageLookupByLibrary.simpleMessage(
            "Số ngày thanh toán tối đa không được để trống"),
        "member_num": MessageLookupByLibrary.simpleMessage("Số thành viên"),
        "message": MessageLookupByLibrary.simpleMessage("Tin nhắn"),
        "meter_code": MessageLookupByLibrary.simpleMessage("Mã công tơ"),
        "minutes": MessageLookupByLibrary.simpleMessage("Biên bản"),
        "missing_obj": MessageLookupByLibrary.simpleMessage("Đồ thất lạc"),
        "missing_object": MessageLookupByLibrary.simpleMessage("Đồ thất lạc"),
        "missing_report": MessageLookupByLibrary.simpleMessage("Báo mất"),
        "missing_time":
            MessageLookupByLibrary.simpleMessage("Thời điểm thất lạc"),
        "month": MessageLookupByLibrary.simpleMessage("Tháng"),
        "my_letter": MessageLookupByLibrary.simpleMessage("Phiếu của tôi"),
        "name": MessageLookupByLibrary.simpleMessage("Tên"),
        "nationality": MessageLookupByLibrary.simpleMessage("Quốc tịch"),
        "need_choose_cylce_regdate": MessageLookupByLibrary.simpleMessage(
            "Bạn cần chọn chu kỳ thanh toán và ngày đăng ký trước"),
        "need_pay": MessageLookupByLibrary.simpleMessage("Cần thanh toán"),
        "need_support":
            MessageLookupByLibrary.simpleMessage("Cần bảo vệ hỗ trợ"),
        "new_index": MessageLookupByLibrary.simpleMessage("Chỉ số cuối kì"),
        "new_pass": MessageLookupByLibrary.simpleMessage("Mật khẩu mới"),
        "new_resident": MessageLookupByLibrary.simpleMessage("Cư dân mới"),
        "new_schedule": MessageLookupByLibrary.simpleMessage("Lịch hẹn mới"),
        "newl": MessageLookupByLibrary.simpleMessage("Mới"),
        "news": MessageLookupByLibrary.simpleMessage("Tin tức"),
        "next": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
        "no_acc":
            MessageLookupByLibrary.simpleMessage("Bạn chưa có tài khoản?"),
        "no_bill": MessageLookupByLibrary.simpleMessage("Không có hóa đơn nào"),
        "no_card": MessageLookupByLibrary.simpleMessage("Không có thẻ nào"),
        "no_comment":
            MessageLookupByLibrary.simpleMessage("Chưa có bình luận nào"),
        "no_cons_file":
            MessageLookupByLibrary.simpleMessage("Không có hồ sơ thi công nào"),
        "no_delivery": MessageLookupByLibrary.simpleMessage(
            "Không có đăng ký chuyển đố nào"),
        "no_dependence": MessageLookupByLibrary.simpleMessage(
            "Không có phiếu đăng ký người phụ thuộc nào"),
        "no_event":
            MessageLookupByLibrary.simpleMessage("Không có sự kiện nào"),
        "no_extend_letter":
            MessageLookupByLibrary.simpleMessage("Không có phiếu gia hạn nào"),
        "no_hand_over":
            MessageLookupByLibrary.simpleMessage("Không có nhận bàn giao nào"),
        "no_home": MessageLookupByLibrary.simpleMessage("Không có căn hộ nào"),
        "no_letter": MessageLookupByLibrary.simpleMessage("Không có phiếu nào"),
        "no_missing_obj":
            MessageLookupByLibrary.simpleMessage("Không có đồ thất lạc nào"),
        "no_more_data":
            MessageLookupByLibrary.simpleMessage("Không còn dữ liệu"),
        "no_news": MessageLookupByLibrary.simpleMessage("Không có tin tức nào"),
        "no_notification":
            MessageLookupByLibrary.simpleMessage("Không có thông báo nào"),
        "no_parcel":
            MessageLookupByLibrary.simpleMessage("Không có bưu phẩm nào"),
        "no_pet": MessageLookupByLibrary.simpleMessage(
            "Không có đăng ký vật nuôi nào"),
        "no_pick_obj":
            MessageLookupByLibrary.simpleMessage("Không có đồ thất lạc nào"),
        "no_project":
            MessageLookupByLibrary.simpleMessage("Không có dự án nào"),
        "no_reflection": MessageLookupByLibrary.simpleMessage(
            "Không có góp ý hay khiếu nại nào"),
        "no_reg_cons": MessageLookupByLibrary.simpleMessage(
            "Không có đăng ký thi công nào"),
        "no_reg_proj": MessageLookupByLibrary.simpleMessage(
            "Anh/Chị hiện tại chưa có bản đăng ký cư dân nào"),
        "no_service_regitration": MessageLookupByLibrary.simpleMessage(
            "Không có đăng ký dịch vụ vào"),
        "no_trans_card":
            MessageLookupByLibrary.simpleMessage("Không có thẻ xe nào"),
        "no_trans_letter":
            MessageLookupByLibrary.simpleMessage("Không có phiếu đăng ký nào"),
        "not_blank":
            MessageLookupByLibrary.simpleMessage("Không được để trống"),
        "not_complete_check": MessageLookupByLibrary.simpleMessage(
            "Bạn cần đánh giá đầy đủ các đầu mục của danh mục vật liệu. Vui lòng kiểm tra lại"),
        "not_date_handover":
            MessageLookupByLibrary.simpleMessage("Chưa đến hạn bàn giao"),
        "not_dimention":
            MessageLookupByLibrary.simpleMessage("Kích thước không đúng"),
        "not_email":
            MessageLookupByLibrary.simpleMessage("Email không đúng định dạng"),
        "not_empty_back": MessageLookupByLibrary.simpleMessage(
            "Không để trống hình ảnh mặt sau"),
        "not_empty_front": MessageLookupByLibrary.simpleMessage(
            "Không để trống hình ảnh mặt trước"),
        "not_empty_vehicle_type": MessageLookupByLibrary.simpleMessage(
            "Loại phương tiện không được để trống"),
        "not_extend_inactive_card": MessageLookupByLibrary.simpleMessage(
            "Thẻ đang bị khóa không thể gia hạn, vui lòng liên hệ BQL để đăng ký lại thẻ"),
        "not_found": MessageLookupByLibrary.simpleMessage("Chưa tìm thấy"),
        "not_found_account": MessageLookupByLibrary.simpleMessage(
            "Không tìm thấy thông tin tài khoản"),
        "not_get_otp":
            MessageLookupByLibrary.simpleMessage("Không nhận được OTP?"),
        "not_greater_than_today":
            MessageLookupByLibrary.simpleMessage("Không lớn hơn ngày hiện tại"),
        "not_larger": m19,
        "not_pass": MessageLookupByLibrary.simpleMessage("Không đạt"),
        "not_pass_list": m20,
        "not_pass_reason":
            MessageLookupByLibrary.simpleMessage("Lý do không đạt"),
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
        "note_can_reason":
            MessageLookupByLibrary.simpleMessage("Ghi chú lý do hủy"),
        "note_cancel":
            MessageLookupByLibrary.simpleMessage("Ghi chú lý do hủy"),
        "note_content":
            MessageLookupByLibrary.simpleMessage("Nội dung ghi chú"),
        "noti_history":
            MessageLookupByLibrary.simpleMessage("Lịch sử thông báo"),
        "notification": MessageLookupByLibrary.simpleMessage("Thông báo"),
        "notification_type":
            MessageLookupByLibrary.simpleMessage("Loại thông báo"),
        "num_seat": MessageLookupByLibrary.simpleMessage("Số chỗ ngồi"),
        "num_seat_not_zero": MessageLookupByLibrary.simpleMessage(
            "Số chỗ ngồi không được bằng 0"),
        "object_code": MessageLookupByLibrary.simpleMessage("Mã vật phẩm"),
        "object_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết vật phẩm"),
        "object_info":
            MessageLookupByLibrary.simpleMessage("Thông tin vật phẩm"),
        "object_name": MessageLookupByLibrary.simpleMessage("Tên vật phẩm"),
        "of_building_management":
            MessageLookupByLibrary.simpleMessage("của ban quản lý tòa nhà"),
        "off_day": MessageLookupByLibrary.simpleMessage("Số ngày nghỉ"),
        "old_index": MessageLookupByLibrary.simpleMessage("Chỉ số đầu kì"),
        "other": MessageLookupByLibrary.simpleMessage("Khác"),
        "other_bill": MessageLookupByLibrary.simpleMessage("Tiền khác"),
        "other_gender": MessageLookupByLibrary.simpleMessage("Giới tính khác"),
        "other_info": MessageLookupByLibrary.simpleMessage("Thông tin khác"),
        "otp_invalid":
            MessageLookupByLibrary.simpleMessage("Mã OTP không hợp lệ"),
        "otp_msg": MessageLookupByLibrary.simpleMessage(
            "Vui lòng kiểm tra điện thoại hoặc email để xem tin nhắn văn bản có mã. Mã của bạn có 6 ký tự."),
        "otp_msg_email": MessageLookupByLibrary.simpleMessage(
            "Vui lòng kiểm tra email để xem tin nhắn văn bản có mã. Mã của bạn có 6 ký tự."),
        "otp_msg_phone": MessageLookupByLibrary.simpleMessage(
            "Vui lòng kiểm tra điện thoại để xem tin nhắn văn bản có mã. Mã của bạn có 6 ký tự."),
        "otp_verify": MessageLookupByLibrary.simpleMessage("Xác thực OTP"),
        "owner": MessageLookupByLibrary.simpleMessage("Chủ hộ"),
        "owner_refuse": MessageLookupByLibrary.simpleMessage("Chủ hộ từ chối"),
        "package": MessageLookupByLibrary.simpleMessage("Hàng hóa"),
        "package_info":
            MessageLookupByLibrary.simpleMessage("Thông tin hàng hóa"),
        "package_items_not_empty": MessageLookupByLibrary.simpleMessage(
            "Thông tin hàng hóa không được để trống"),
        "package_name": MessageLookupByLibrary.simpleMessage("Tên hàng hóa"),
        "paid": MessageLookupByLibrary.simpleMessage("Đã thanh toán"),
        "paid_deposit": MessageLookupByLibrary.simpleMessage("Đã đóng phí"),
        "paid_payment": MessageLookupByLibrary.simpleMessage("Đã thanh toán"),
        "parcel": MessageLookupByLibrary.simpleMessage("Bưu phẩm"),
        "parcel_code": MessageLookupByLibrary.simpleMessage("Mã bưu phẩm"),
        "parcel_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết bưu phẩm"),
        "parcel_info":
            MessageLookupByLibrary.simpleMessage("Thông tin bưu phẩm"),
        "parcel_name": MessageLookupByLibrary.simpleMessage("Tên bưu phẩm"),
        "parking_bill": MessageLookupByLibrary.simpleMessage("Tiền gửi xe"),
        "parking_card": MessageLookupByLibrary.simpleMessage("Thẻ phương tiện"),
        "participate": MessageLookupByLibrary.simpleMessage("Tham gia"),
        "pass": MessageLookupByLibrary.simpleMessage("Đạt"),
        "pass_list": MessageLookupByLibrary.simpleMessage(
            "Các tài sản đã được bàn giao đầy đủ"),
        "pass_min_length": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu không ít hơn 8 ký tự"),
        "pass_not_same": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu mới phải khác mật khảu cũ"),
        "pass_special": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu phải gồm 1 ký tự đặc biệt"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "pause_construction":
            MessageLookupByLibrary.simpleMessage("Khóa thi công"),
        "pay": MessageLookupByLibrary.simpleMessage("Thanh toán"),
        "pay_construction_fee":
            MessageLookupByLibrary.simpleMessage("Thanh toán phí thi công"),
        "pay_date": MessageLookupByLibrary.simpleMessage("Ngày thanh toán"),
        "pay_done":
            MessageLookupByLibrary.simpleMessage("Hoàn thành thanh toán"),
        "payment_circle":
            MessageLookupByLibrary.simpleMessage("Thời hạn sử dụng"),
        "payment_cycle_not_empty": MessageLookupByLibrary.simpleMessage(
            "Chu kỳ thanh toán không được để trống"),
        "payment_method":
            MessageLookupByLibrary.simpleMessage("Phương thức thanh toán"),
        "per_res": MessageLookupByLibrary.simpleMessage("Thường trú"),
        "per_res_address":
            MessageLookupByLibrary.simpleMessage("Địa chỉ thường trú"),
        "percent": MessageLookupByLibrary.simpleMessage("Phần trăm"),
        "perform_person":
            MessageLookupByLibrary.simpleMessage("Người thực hiện"),
        "permission_denied":
            MessageLookupByLibrary.simpleMessage("Từ chối truy cập"),
        "permission_denied_msg":
            MessageLookupByLibrary.simpleMessage("Bạn chưa cấp quyền ứng dụng"),
        "personal_info": MessageLookupByLibrary.simpleMessage("Hồ sơ cá nhân"),
        "pet": MessageLookupByLibrary.simpleMessage("Vật nuôi"),
        "pet_agree": MessageLookupByLibrary.simpleMessage(
            "Bạn cần đồng ý tuân thủ quy định về đăng ký vật nuôi"),
        "pet_female": MessageLookupByLibrary.simpleMessage("Cái"),
        "pet_image_not_empty": MessageLookupByLibrary.simpleMessage(
            "Hình ảnh vật nuôi không được để trống"),
        "pet_images": MessageLookupByLibrary.simpleMessage("Ảnh vật nuôi"),
        "pet_info": MessageLookupByLibrary.simpleMessage("Thông tin vật nuôi"),
        "pet_male": MessageLookupByLibrary.simpleMessage("Đực"),
        "pet_name": MessageLookupByLibrary.simpleMessage("Tên vật nuôi"),
        "pet_origin": MessageLookupByLibrary.simpleMessage("Giống loài"),
        "pet_regulation":
            MessageLookupByLibrary.simpleMessage("Nội quy vật nuôi"),
        "pet_type": MessageLookupByLibrary.simpleMessage("Loại vật nuôi"),
        "phone_email":
            MessageLookupByLibrary.simpleMessage("Số điện thoại/ Email"),
        "phone_less_10": MessageLookupByLibrary.simpleMessage(
            "Số điện thoại không được nhỏ hơn 10 ký tự"),
        "phone_num": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
        "photo_back_side": MessageLookupByLibrary.simpleMessage("Ảnh mặt sau"),
        "photo_front_side":
            MessageLookupByLibrary.simpleMessage("Ảnh mặt trước"),
        "photos": MessageLookupByLibrary.simpleMessage("Hình ảnh"),
        "pick_file_error": MessageLookupByLibrary.simpleMessage(
            "Bạn chỉ có thể upload file jpeg, jpg, png, pdf, doc, docx, xls, xlsx"),
        "pick_image_error": MessageLookupByLibrary.simpleMessage(
            "Bạn chỉ có thể upload file jpeg, jpg, png"),
        "pin": MessageLookupByLibrary.simpleMessage("Chốt trực"),
        "place_issue": MessageLookupByLibrary.simpleMessage("Nơi cấp"),
        "plan_code": MessageLookupByLibrary.simpleMessage("Mã mặt bằng"),
        "plan_info": MessageLookupByLibrary.simpleMessage("Thông tin mặt bằng"),
        "plan_name": MessageLookupByLibrary.simpleMessage("Tên mặt bằng"),
        "pool": MessageLookupByLibrary.simpleMessage("Bể bơi"),
        "possessed_apartment":
            MessageLookupByLibrary.simpleMessage("Căn hộ sở hữu"),
        "post_graduate":
            MessageLookupByLibrary.simpleMessage("đang học cao học"),
        "prev": MessageLookupByLibrary.simpleMessage("Trở lại"),
        "processing_content":
            MessageLookupByLibrary.simpleMessage("Nội dung xử lý"),
        "processing_result":
            MessageLookupByLibrary.simpleMessage("Kết quả xử lý"),
        "project": MessageLookupByLibrary.simpleMessage("Dự án"),
        "prov_city": MessageLookupByLibrary.simpleMessage("Tỉnh/Thành phố"),
        "pull_load_failed":
            MessageLookupByLibrary.simpleMessage("Load thất bại"),
        "pull_to_load": MessageLookupByLibrary.simpleMessage("Kéo để xem thêm"),
        "qualification_level":
            MessageLookupByLibrary.simpleMessage("Trình độ chuyên môn"),
        "re_book": MessageLookupByLibrary.simpleMessage("Đổi lịch"),
        "re_sign_in": MessageLookupByLibrary.simpleMessage("Hãy đăng nhập lại"),
        "reality": MessageLookupByLibrary.simpleMessage("Thực tế"),
        "reality_handover_date":
            MessageLookupByLibrary.simpleMessage("Ngày nhận thực tế"),
        "reality_handover_hour":
            MessageLookupByLibrary.simpleMessage("Giờ nhận thực tế"),
        "reason": MessageLookupByLibrary.simpleMessage("Lý do"),
        "reason_refuse": MessageLookupByLibrary.simpleMessage("Lý do từ chối"),
        "receipt_date": MessageLookupByLibrary.simpleMessage("Ngày nhận"),
        "receipted": MessageLookupByLibrary.simpleMessage("Đã nhận"),
        "red_code": MessageLookupByLibrary.simpleMessage("Mã đăng kí"),
        "reflection": MessageLookupByLibrary.simpleMessage("Góc phản ánh"),
        "reflection_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết phản ánh"),
        "reflection_reason":
            MessageLookupByLibrary.simpleMessage("Lý do phản ánh"),
        "reflection_reason_not_empty": MessageLookupByLibrary.simpleMessage(
            "Lý do phản ánh không được để trống"),
        "reflection_type":
            MessageLookupByLibrary.simpleMessage("Loại phản ánh"),
        "reflex": MessageLookupByLibrary.simpleMessage("Phản ánh"),
        "refuse": MessageLookupByLibrary.simpleMessage("Từ chối"),
        "refuse_letter": MessageLookupByLibrary.simpleMessage("Từ chối phiếu"),
        "reg_cancel": MessageLookupByLibrary.simpleMessage("Hủy đăng ký"),
        "reg_code": MessageLookupByLibrary.simpleMessage("Mã đăng ký"),
        "reg_const": MessageLookupByLibrary.simpleMessage("Đăng ký thi công"),
        "reg_date": MessageLookupByLibrary.simpleMessage("Ngày đăng ký"),
        "reg_date_not_after_now": MessageLookupByLibrary.simpleMessage(
            "Ngày đăng ký không hợp lệ. Vui lòng chọn lại."),
        "reg_day_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ngày đăng ký không được để trống"),
        "reg_deliver":
            MessageLookupByLibrary.simpleMessage("Đăng ký chuyển đồ"),
        "reg_images_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh đăng ký phương tiện phải ít nhất 2 ảnh"),
        "reg_info": MessageLookupByLibrary.simpleMessage("Thông tin đăng ký"),
        "reg_letter_num":
            MessageLookupByLibrary.simpleMessage("Mã phiếu đăng ký"),
        "reg_missing_obj":
            MessageLookupByLibrary.simpleMessage("Đăng ký tìm đồ thất lạc"),
        "reg_num": MessageLookupByLibrary.simpleMessage("Số đăng ký"),
        "reg_pet": MessageLookupByLibrary.simpleMessage("Đăng ký vật nuôi"),
        "reg_pet_info":
            MessageLookupByLibrary.simpleMessage("Thông tin đăng ký vật nuôi"),
        "reg_pet_list":
            MessageLookupByLibrary.simpleMessage("Danh sách đăng ký vật nuôi"),
        "reg_service": MessageLookupByLibrary.simpleMessage("Đăng ký dịch vụ"),
        "reg_service_a": m21,
        "reg_time": MessageLookupByLibrary.simpleMessage("Thời gian đăng ký"),
        "reg_trans_photos": MessageLookupByLibrary.simpleMessage(
            "Ảnh đăng ký xe (ảnh chụp 2 mặt)"),
        "reg_transport_card":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ phương tiện"),
        "region": MessageLookupByLibrary.simpleMessage("Khu vực"),
        "registed_resident":
            MessageLookupByLibrary.simpleMessage("Cư dân đã đăng ký"),
        "register_code": MessageLookupByLibrary.simpleMessage("Mã đăng ký"),
        "register_info":
            MessageLookupByLibrary.simpleMessage("Thông tin người đăng ký"),
        "register_res_card":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ cư dân"),
        "register_trans_card":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ phương tiện"),
        "registered_card":
            MessageLookupByLibrary.simpleMessage("Thẻ đã đăng ký"),
        "regulations": MessageLookupByLibrary.simpleMessage("quy định"),
        "reject_card": MessageLookupByLibrary.simpleMessage("Hủy thẻ"),
        "reject_reason": MessageLookupByLibrary.simpleMessage("Lý do hủy"),
        "related_doc_photo":
            MessageLookupByLibrary.simpleMessage("Ảnh giấy tờ liên quan"),
        "related_image_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh tài liệu liên quan không được để trống"),
        "related_photo":
            MessageLookupByLibrary.simpleMessage("Ảnh giấy tờ liên quan"),
        "relation_not_empty": MessageLookupByLibrary.simpleMessage(
            "Mối quan hệ không được để trống"),
        "relation_owner": MessageLookupByLibrary.simpleMessage("QH với chủ hộ"),
        "relation_with_owner":
            MessageLookupByLibrary.simpleMessage("Quan hệ với chủ hộ"),
        "release_to_load":
            MessageLookupByLibrary.simpleMessage("Thả để xem thêm"),
        "remember_acc": MessageLookupByLibrary.simpleMessage("Lưu tài khoản"),
        "renew_drawing_not_empty": MessageLookupByLibrary.simpleMessage(
            "Bản vẽ cải tạo không được bỏ trống"),
        "renewal_drawing":
            MessageLookupByLibrary.simpleMessage("Bản vẽ cải tạo"),
        "renter": MessageLookupByLibrary.simpleMessage("Người thuê"),
        "report_lost": MessageLookupByLibrary.simpleMessage("Báo mất"),
        "report_missing_card":
            MessageLookupByLibrary.simpleMessage("Báo mất thẻ xe"),
        "report_missing_card_res":
            MessageLookupByLibrary.simpleMessage("Báo mất thẻ cư dân"),
        "report_not_empty": MessageLookupByLibrary.simpleMessage(
            "Biên bản không được để trống"),
        "res_card": MessageLookupByLibrary.simpleMessage("Thẻ cư dân"),
        "res_card_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết thẻ cư dân"),
        "res_card_register":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ cư dân"),
        "res_image_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh cư dân không được để trống"),
        "res_images_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh cư dân không được để trống"),
        "res_name": MessageLookupByLibrary.simpleMessage("Tên cư dân"),
        "res_photo": MessageLookupByLibrary.simpleMessage("Ảnh cư dân"),
        "res_reaction":
            MessageLookupByLibrary.simpleMessage("Tương tác cư dân"),
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
        "resident": MessageLookupByLibrary.simpleMessage("Cư dân"),
        "resident_account":
            MessageLookupByLibrary.simpleMessage("Tài khoản cư dân"),
        "resident_address":
            MessageLookupByLibrary.simpleMessage("Địa chỉ thường trú"),
        "resident_info":
            MessageLookupByLibrary.simpleMessage("Thông tin cư dân"),
        "resident_letter_details": MessageLookupByLibrary.simpleMessage(
            "Chi tiết phiếu đăng ký thẻ cư dân"),
        "resident_not_empty":
            MessageLookupByLibrary.simpleMessage("cư dân không được để trống"),
        "resident_reg": MessageLookupByLibrary.simpleMessage("Đăng ký cư dân"),
        "resident_type": MessageLookupByLibrary.simpleMessage("Loại cư trú"),
        "result_date":
            MessageLookupByLibrary.simpleMessage("Ngày nhận kết quả"),
        "retry": MessageLookupByLibrary.simpleMessage("Vui lòng kiểm tra lại."),
        "return_image": MessageLookupByLibrary.simpleMessage("Hình ảnh đã trả"),
        "returned": MessageLookupByLibrary.simpleMessage("Đã trả"),
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
        "s_cons_apartment": MessageLookupByLibrary.simpleMessage(
            "Diện tích sàn xây dựng căn hộ (tim tường)"),
        "s_usage_apartment": MessageLookupByLibrary.simpleMessage(
            "Diện tích sử dụng căn hộ (thông thủy)"),
        "save": MessageLookupByLibrary.simpleMessage("Lưu"),
        "scuccess_participation": m22,
        "search": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
        "search_aparment":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm căn hộ"),
        "search_apartment":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm căn hộ"),
        "search_project":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm dự án"),
        "select": MessageLookupByLibrary.simpleMessage("Chọn"),
        "select_card_type":
            MessageLookupByLibrary.simpleMessage("Chọn loại thẻ"),
        "select_cons_type":
            MessageLookupByLibrary.simpleMessage("Chọn loại thi công"),
        "select_expire": MessageLookupByLibrary.simpleMessage("Chọn thời hạn"),
        "select_project": MessageLookupByLibrary.simpleMessage("Chọn dự án"),
        "select_seat_num":
            MessageLookupByLibrary.simpleMessage("Chọn số chỗ ngồi"),
        "select_surface": MessageLookupByLibrary.simpleMessage("Chọn mặt bằng"),
        "select_transport":
            MessageLookupByLibrary.simpleMessage("Chọn phương tiện"),
        "sell_contract_num":
            MessageLookupByLibrary.simpleMessage("Số hợp đồng mua bán"),
        "send_email_wait": MessageLookupByLibrary.simpleMessage(
            "Hệ thống đang gủi mã xác thực vào email, xin vui lòng đợi"),
        "send_letter": MessageLookupByLibrary.simpleMessage("Gửi phiếu"),
        "send_otp_to": MessageLookupByLibrary.simpleMessage(
            "Gửi mã để đặt lại mật khẩu về"),
        "send_reflection":
            MessageLookupByLibrary.simpleMessage("Gửi phản ánh "),
        "send_request": MessageLookupByLibrary.simpleMessage("Gửi duyệt"),
        "send_to_email":
            MessageLookupByLibrary.simpleMessage("Gửi mã về email"),
        "send_to_phone": MessageLookupByLibrary.simpleMessage("Gửi mã về SĐT"),
        "send_verify": MessageLookupByLibrary.simpleMessage("Gửi xác thực"),
        "service_bill":
            MessageLookupByLibrary.simpleMessage("Tiền đăng ký dịch vụ"),
        "service_name": m23,
        "service_reflection":
            MessageLookupByLibrary.simpleMessage("Phản hồi dịch vụ"),
        "services": MessageLookupByLibrary.simpleMessage("Dịch vụ"),
        "setting": MessageLookupByLibrary.simpleMessage("Cài đặt"),
        "sex": MessageLookupByLibrary.simpleMessage("Giới tính"),
        "shelflife_money": MessageLookupByLibrary.simpleMessage("Kỳ đóng tiền"),
        "shopping_online":
            MessageLookupByLibrary.simpleMessage("Mua sắm online"),
        "shopping_represent": MessageLookupByLibrary.simpleMessage("Đi chợ hộ"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "sign_out": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "sign_out_msg": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn đăng xuất không ?"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "social_media":
            MessageLookupByLibrary.simpleMessage("Link thông tin mạng xã hội"),
        "start": MessageLookupByLibrary.simpleMessage("Bắt đầu"),
        "start_chat":
            MessageLookupByLibrary.simpleMessage("Bắt đầu cuộc trò chuyện!"),
        "start_date": MessageLookupByLibrary.simpleMessage("Ngày bắt đầu"),
        "start_date_after_now": MessageLookupByLibrary.simpleMessage(
            "Ngày bắt đầu không được nhỏ hơn ngày hiện tại"),
        "start_date_after_now_equal": MessageLookupByLibrary.simpleMessage(
            "Ngày bắt đầu phải lớn hơn hoặc bằng ngày hiện tại"),
        "start_date_extend":
            MessageLookupByLibrary.simpleMessage("Ngày bắt đầu gia hạn"),
        "start_date_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ngày bắt đầu không được để trống"),
        "start_time": MessageLookupByLibrary.simpleMessage("Thời gian bắt đầu"),
        "status": MessageLookupByLibrary.simpleMessage("Trạng thái"),
        "status_cons":
            MessageLookupByLibrary.simpleMessage("Trạng thái thi công"),
        "status_letter":
            MessageLookupByLibrary.simpleMessage("Trạng thái phiếu"),
        "step1": MessageLookupByLibrary.simpleMessage("Bước 1"),
        "step2": MessageLookupByLibrary.simpleMessage("Bước 2"),
        "step3": MessageLookupByLibrary.simpleMessage("Bước 3"),
        "stt": MessageLookupByLibrary.simpleMessage("STT"),
        "succees_extend_trans": MessageLookupByLibrary.simpleMessage(
            "Gia hạn phương tiện thành công"),
        "success": MessageLookupByLibrary.simpleMessage("Thành công"),
        "success_accept":
            MessageLookupByLibrary.simpleMessage("Xác nhận thành công"),
        "success_accept_letter":
            MessageLookupByLibrary.simpleMessage("Xác nhận phiếu thành công"),
        "success_add_dependence": m24,
        "success_add_email":
            MessageLookupByLibrary.simpleMessage("Thêm email thành công"),
        "success_add_ticket": MessageLookupByLibrary.simpleMessage(
            "Thêm mới phản ánh thành công"),
        "success_book_schedule": m25,
        "success_can_req": MessageLookupByLibrary.simpleMessage(
            "Hủy đăng ký phiếu thành công"),
        "success_can_res_card":
            MessageLookupByLibrary.simpleMessage("Hủy thẻ cư dân thành công"),
        "success_can_schedule": m26,
        "success_can_trans_card":
            MessageLookupByLibrary.simpleMessage("Hủy thẻ xe thành công"),
        "success_cancel_dependence": MessageLookupByLibrary.simpleMessage(
            "Hủy đăng ký người phụ thuộc thành công"),
        "success_cancel_reflection":
            MessageLookupByLibrary.simpleMessage("Hủy phản ánh thành công"),
        "success_cancel_trans":
            MessageLookupByLibrary.simpleMessage("Hủy phương tiện thành công"),
        "success_change_pass": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu mới đã được cập nhật thành công. Vui lòng đăng nhập bằng mật khẩu mới"),
        "success_confirm":
            MessageLookupByLibrary.simpleMessage("Xác nhận thành công"),
        "success_cr_new":
            MessageLookupByLibrary.simpleMessage("Thêm mới thành công"),
        "success_edit":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa thành công"),
        "success_edit_reflection": MessageLookupByLibrary.simpleMessage(
            "Cập nhật phản ánh thành công"),
        "success_find": MessageLookupByLibrary.simpleMessage(
            "Đổi trạng thái đồ thành đã tìm thấy thành công"),
        "success_found": MessageLookupByLibrary.simpleMessage("Đã tìm thấy"),
        "success_handover": m27,
        "success_lock_card":
            MessageLookupByLibrary.simpleMessage("Khóa thẻ thành công"),
        "success_opt":
            MessageLookupByLibrary.simpleMessage("Gửi mã OTP thành công"),
        "success_payment": m28,
        "success_refuse_letter":
            MessageLookupByLibrary.simpleMessage("Từ chối phiếu thành công"),
        "success_reg_res":
            MessageLookupByLibrary.simpleMessage("Đăng ký cư dân thành công"),
        "success_register_dependence": MessageLookupByLibrary.simpleMessage(
            "Đăng ký người phụ thuộc thành công"),
        "success_remove":
            MessageLookupByLibrary.simpleMessage("Xóa thành công"),
        "success_report_handover":
            MessageLookupByLibrary.simpleMessage("Báo lỗi thành công"),
        "success_report_missing":
            MessageLookupByLibrary.simpleMessage("Báo mất thẻ thành công"),
        "success_returned": MessageLookupByLibrary.simpleMessage(
            "Đổi trạng thái đồ thành đã trả thành công"),
        "success_send_letter":
            MessageLookupByLibrary.simpleMessage("Gửi duyệt phiếu thành công"),
        "success_send_req":
            MessageLookupByLibrary.simpleMessage("Gửi duyệt thành công"),
        "success_send_ticket":
            MessageLookupByLibrary.simpleMessage("Gửi phản ánh thành công"),
        "success_sign_up":
            MessageLookupByLibrary.simpleMessage("Đăng ký thành công"),
        "success_update":
            MessageLookupByLibrary.simpleMessage("Cập nhật thành công"),
        "success_update_email":
            MessageLookupByLibrary.simpleMessage("Cập nhật email thành công"),
        "surface": MessageLookupByLibrary.simpleMessage("Mặt bằng"),
        "sys_support": MessageLookupByLibrary.simpleMessage("Đường dây hỗ trợ"),
        "system_notification":
            MessageLookupByLibrary.simpleMessage("Thông báo hệ thống"),
        "take_place_time":
            MessageLookupByLibrary.simpleMessage("Thời gian diễn ra"),
        "temp_res": MessageLookupByLibrary.simpleMessage("Tạm trú"),
        "temp_res_foreigner": MessageLookupByLibrary.simpleMessage(
            "Tạm trú cho người nước ngoài"),
        "terms_services":
            MessageLookupByLibrary.simpleMessage("Điều khoản & dịch vụ"),
        "terms_services_msg": MessageLookupByLibrary.simpleMessage(
            "Đăng ký tài khoản cư dân đồng nghĩa với việc đồng thuận với "),
        "th01": MessageLookupByLibrary.simpleMessage("Tháng 1"),
        "th02": MessageLookupByLibrary.simpleMessage("Tháng 2"),
        "th03": MessageLookupByLibrary.simpleMessage("Tháng 3"),
        "th04": MessageLookupByLibrary.simpleMessage("Tháng 4"),
        "th05": MessageLookupByLibrary.simpleMessage("Tháng 5"),
        "th06": MessageLookupByLibrary.simpleMessage("Tháng 6"),
        "th07": MessageLookupByLibrary.simpleMessage("Tháng 7"),
        "th08": MessageLookupByLibrary.simpleMessage("Tháng 8"),
        "th09": MessageLookupByLibrary.simpleMessage("Tháng 9"),
        "th10": MessageLookupByLibrary.simpleMessage("Tháng 10"),
        "th11": MessageLookupByLibrary.simpleMessage("Tháng 11"),
        "th12": MessageLookupByLibrary.simpleMessage("Tháng 12"),
        "this_trans_letter":
            MessageLookupByLibrary.simpleMessage("Phiếu đăng ký xe này"),
        "tiktok": MessageLookupByLibrary.simpleMessage("Tiktok"),
        "time_event_happening":
            MessageLookupByLibrary.simpleMessage("Thời gian diễn ra sự kiện"),
        "time_hanover": MessageLookupByLibrary.simpleMessage(
            "Thời gian nhận bàn giao dự kiến"),
        "time_happening":
            MessageLookupByLibrary.simpleMessage("Thời gian diễn ra"),
        "title": MessageLookupByLibrary.simpleMessage("Tiêu đề"),
        "to_money": MessageLookupByLibrary.simpleMessage("Thành tiền"),
        "to_money_vnd":
            MessageLookupByLibrary.simpleMessage("Thành tiền (VNĐ)"),
        "total": MessageLookupByLibrary.simpleMessage("Tổng cộng"),
        "total_bill": MessageLookupByLibrary.simpleMessage("Tổng hóa đơn"),
        "total_consumed_water_month": m29,
        "total_money": MessageLookupByLibrary.simpleMessage("Tổng tiền"),
        "total_money_pay":
            MessageLookupByLibrary.simpleMessage("Tổng cộng tiền thanh toán"),
        "total_money_to_pay":
            MessageLookupByLibrary.simpleMessage("Tổng cộng tiền thanh toán"),
        "total_pay": MessageLookupByLibrary.simpleMessage("Tổng thanh toán"),
        "tranfer_in": MessageLookupByLibrary.simpleMessage("Chuyển đồ vào"),
        "tranfer_in_reg":
            MessageLookupByLibrary.simpleMessage("Đăng ký chuyển đồ vào"),
        "tranfer_out": MessageLookupByLibrary.simpleMessage("Chuyển đồ ra"),
        "tranfer_out_reg":
            MessageLookupByLibrary.simpleMessage("Đăng ký chuyển đồ ra"),
        "tranfer_rule":
            MessageLookupByLibrary.simpleMessage("Quy định chuyển đồ"),
        "trans_card": MessageLookupByLibrary.simpleMessage("Thẻ xe"),
        "trans_card_atleast_1": MessageLookupByLibrary.simpleMessage(
            "Thẻ phải có ít nhất 1 phương tiện"),
        "trans_card_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết thẻ phương tiện"),
        "trans_cer": MessageLookupByLibrary.simpleMessage("Đăng ký xe"),
        "trans_details":
            MessageLookupByLibrary.simpleMessage("Chi tiết phương tiện"),
        "trans_images": MessageLookupByLibrary.simpleMessage("Ảnh phương tiện"),
        "trans_images_not_empty": MessageLookupByLibrary.simpleMessage(
            "Ảnh phương tiện không được để trống"),
        "trans_info":
            MessageLookupByLibrary.simpleMessage("Thông tin phương tiện"),
        "trans_letter":
            MessageLookupByLibrary.simpleMessage("Phiếu đăng ký xe"),
        "trans_reg_card_details": MessageLookupByLibrary.simpleMessage(
            "Chi tiết đăng ký phương tiện"),
        "trans_reg_num": MessageLookupByLibrary.simpleMessage("Số đăng ký xe"),
        "trans_status":
            MessageLookupByLibrary.simpleMessage("Trạng thái phương tiện"),
        "trans_type": MessageLookupByLibrary.simpleMessage("Loại phương tiện"),
        "transfer_list":
            MessageLookupByLibrary.simpleMessage("Danh sách chuyển đồ"),
        "transfer_type": MessageLookupByLibrary.simpleMessage("Loại chuyển"),
        "transport": MessageLookupByLibrary.simpleMessage("Phương tiện"),
        "transport_card":
            MessageLookupByLibrary.simpleMessage("Thẻ phương tiện"),
        "transport_info":
            MessageLookupByLibrary.simpleMessage("Thông tin phương tiện"),
        "transport_list":
            MessageLookupByLibrary.simpleMessage("Danh sách phương tiện"),
        "transport_reg": MessageLookupByLibrary.simpleMessage("Đăng ký xe"),
        "transportation": MessageLookupByLibrary.simpleMessage("Phương tiện"),
        "type": MessageLookupByLibrary.simpleMessage("Loại"),
        "under_acceptance": MessageLookupByLibrary.simpleMessage("Nghiệm thu"),
        "under_construction":
            MessageLookupByLibrary.simpleMessage("Bắt đầu thi công"),
        "unit_count": MessageLookupByLibrary.simpleMessage("Đơn vị tính"),
        "unit_price": MessageLookupByLibrary.simpleMessage("Đơn giá (VNĐ)"),
        "unkhown": MessageLookupByLibrary.simpleMessage("Không xác định"),
        "unpaid": MessageLookupByLibrary.simpleMessage("Chưa thanh toán"),
        "update": MessageLookupByLibrary.simpleMessage("Cập nhật"),
        "upload": MessageLookupByLibrary.simpleMessage("Tải lên"),
        "use_elevator": MessageLookupByLibrary.simpleMessage("Dùng thang máy"),
        "used_expired_date":
            MessageLookupByLibrary.simpleMessage("Thời hạn sử dụng"),
        "username": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "value": MessageLookupByLibrary.simpleMessage("Giá trị"),
        "vat": MessageLookupByLibrary.simpleMessage("VAT"),
        "verify": MessageLookupByLibrary.simpleMessage("Xác thực"),
        "vew_records": MessageLookupByLibrary.simpleMessage("Xem biên bản"),
        "vi": MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
        "view": MessageLookupByLibrary.simpleMessage("Xem"),
        "view_record": MessageLookupByLibrary.simpleMessage("Xem biên bản"),
        "violation_exe": MessageLookupByLibrary.simpleMessage("Xử lý vi phạm"),
        "violation_record":
            MessageLookupByLibrary.simpleMessage("Biên bản vi phạm"),
        "violation_records":
            MessageLookupByLibrary.simpleMessage("Biên bản vi phạm"),
        "w":
            MessageLookupByLibrary.simpleMessage("Home Community Smart Living"),
        "wait_acceptance":
            MessageLookupByLibrary.simpleMessage("Báo nghiệm thu"),
        "wait_approve": MessageLookupByLibrary.simpleMessage("Chờ duyệt"),
        "wait_chat_response": MessageLookupByLibrary.simpleMessage(
            "Có vẻ như bạn đã không hoạt động trong vài phút. Bạn có muốn tiếp tục cuộc trò chuyện không? Cuộc trò chuyện sẽ kết thúc sau một ít phút nếu không có phản hồi."),
        "wait_confirm_letter":
            MessageLookupByLibrary.simpleMessage("Phiếu chờ xác nhận"),
        "wait_execute": MessageLookupByLibrary.simpleMessage("Chờ xử lý"),
        "wait_find": MessageLookupByLibrary.simpleMessage("Chờ tìm"),
        "wait_hand_over": MessageLookupByLibrary.simpleMessage("Chờ bàn giao"),
        "wait_pay": MessageLookupByLibrary.simpleMessage("Chờ thanh toán"),
        "wait_receipt": MessageLookupByLibrary.simpleMessage("Chờ nhận"),
        "wait_return": MessageLookupByLibrary.simpleMessage("Chờ trả"),
        "waiting_project_resistration":
            MessageLookupByLibrary.simpleMessage("Thông tin đăng ký chờ duyệt"),
        "ward": MessageLookupByLibrary.simpleMessage("Quận/Huyện"),
        "water": MessageLookupByLibrary.simpleMessage("Nước"),
        "water_bill": MessageLookupByLibrary.simpleMessage("Tiền nước"),
        "way_send_otp": MessageLookupByLibrary.simpleMessage(
            "Bạn muốn nhận mã để đặt lại mật khẩu bằng cách nào?"),
        "we_send_to": m30,
        "weight": MessageLookupByLibrary.simpleMessage("Trọng lượng"),
        "weight_not_15": MessageLookupByLibrary.simpleMessage(
            "Trọng lượng không được quá 15kg"),
        "weight_not_zero":
            MessageLookupByLibrary.simpleMessage("Trọng lượng phải khác không"),
        "wellcome_back":
            MessageLookupByLibrary.simpleMessage("Chào mừng trở lại"),
        "when_missing": MessageLookupByLibrary.simpleMessage(
            "Khi báo mất thẻ của bạn sẽ bị hủy.Nếu muốn tiếp tục sử dụng dịch vụ, bạn cần đăng ký thẻ mới."),
        "width": MessageLookupByLibrary.simpleMessage("Rộng"),
        "work_description":
            MessageLookupByLibrary.simpleMessage("Mô tả công việc"),
        "worker_num":
            MessageLookupByLibrary.simpleMessage("Số lượng công nhân"),
        "year": MessageLookupByLibrary.simpleMessage("Năm"),
        "zalo": MessageLookupByLibrary.simpleMessage("Zalo"),
        "zone": MessageLookupByLibrary.simpleMessage("Khu vực"),
        "zone_type": MessageLookupByLibrary.simpleMessage("Loại khu vực")
      };
}
