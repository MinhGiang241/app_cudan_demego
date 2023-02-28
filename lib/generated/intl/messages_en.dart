// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(code) => "Do you want to cancel request letter [${code}]";

  static String m1(letter) => "Do you want to delete letter [${letter}]?";

  static String m2(delete) => "Do you want to delete [${delete}]?";

  static String m3(card) => "Do you want to lock card [${card}]?";

  static String m4(eventName) =>
      "Do you want to participate in [${eventName}]?";

  static String m5(approved) => "Do you want to send to approve [${approved}]?";

  static String m6(nameser) => "Edit registration service ${nameser}";

  static String m7(message) => "Error: ${message}";

  static String m8(numAsset) =>
      "Hand over list has ${numAsset} assets not pass";

  static String m9(nameser) => "Registration service ${nameser}";

  static String m10(eName) => "Paticipate event [${eName}] successfully";

  static String m11(service) => "Service ${service}";

  static String m12(person, build) =>
      "You has already add ${person} into apartment ${build}. Please wait management\'s approval";

  static String m13(p) => "Make payment for ${p} successfully";

  static String m14(to) => "We sent otp code to :${to}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept_hand_over":
            MessageLookupByLibrary.simpleMessage("Accept hand over"),
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "account_name": MessageLookupByLibrary.simpleMessage("Account name"),
        "active": MessageLookupByLibrary.simpleMessage("Active"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "add_dependent_person":
            MessageLookupByLibrary.simpleMessage("Add dependent person "),
        "add_file": MessageLookupByLibrary.simpleMessage("Add file"),
        "add_new": MessageLookupByLibrary.simpleMessage("Add new"),
        "add_package": MessageLookupByLibrary.simpleMessage("Add package"),
        "add_photo": MessageLookupByLibrary.simpleMessage("Add photos"),
        "add_reflection":
            MessageLookupByLibrary.simpleMessage("Create feedback"),
        "add_trans_card":
            MessageLookupByLibrary.simpleMessage("Resister new card"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "al_read": MessageLookupByLibrary.simpleMessage("read"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "amount": MessageLookupByLibrary.simpleMessage("Amount"),
        "apartment": MessageLookupByLibrary.simpleMessage("Apartment"),
        "apartment_add_resident":
            MessageLookupByLibrary.simpleMessage("Add residence apartment"),
        "apartment_bill":
            MessageLookupByLibrary.simpleMessage("Apartment bill"),
        "app_version": MessageLookupByLibrary.simpleMessage("App version"),
        "approved": MessageLookupByLibrary.simpleMessage("Approved"),
        "approved_date": MessageLookupByLibrary.simpleMessage("Approved date"),
        "arrived_date": MessageLookupByLibrary.simpleMessage("Arrived date"),
        "asset_detais": MessageLookupByLibrary.simpleMessage("Asset details"),
        "asset_list": MessageLookupByLibrary.simpleMessage("Asset list"),
        "asset_name": MessageLookupByLibrary.simpleMessage("Asset name"),
        "attachment_file":
            MessageLookupByLibrary.simpleMessage("Attachment file"),
        "back_side": MessageLookupByLibrary.simpleMessage("Back side"),
        "base_info":
            MessageLookupByLibrary.simpleMessage("General information"),
        "bill_code": MessageLookupByLibrary.simpleMessage("Bill code"),
        "bill_details": MessageLookupByLibrary.simpleMessage("Bill details"),
        "bill_name": MessageLookupByLibrary.simpleMessage("Bill name"),
        "bills": MessageLookupByLibrary.simpleMessage("Bill"),
        "birthday_congratulaion":
            MessageLookupByLibrary.simpleMessage("Birthday Congratulaion"),
        "booking": MessageLookupByLibrary.simpleMessage("Booking"),
        "booking_hand_over":
            MessageLookupByLibrary.simpleMessage("Booking hand over"),
        "booking_his": MessageLookupByLibrary.simpleMessage("Booking history"),
        "building": MessageLookupByLibrary.simpleMessage("Building"),
        "c_new_pass":
            MessageLookupByLibrary.simpleMessage("Re-enter new password"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "can_not_empty": MessageLookupByLibrary.simpleMessage("Can not empty"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cancel_reason": MessageLookupByLibrary.simpleMessage("Reject_reason"),
        "cancel_reflection":
            MessageLookupByLibrary.simpleMessage("Cancel reflection"),
        "cancel_reg": MessageLookupByLibrary.simpleMessage("Cancel register"),
        "cancel_register":
            MessageLookupByLibrary.simpleMessage("Cancel register"),
        "cancel_request": MessageLookupByLibrary.simpleMessage("Cancel letter"),
        "card_num": MessageLookupByLibrary.simpleMessage("Card number"),
        "card_status": MessageLookupByLibrary.simpleMessage("Card status"),
        "cat": MessageLookupByLibrary.simpleMessage("Cat"),
        "cer_vacxin_doc": MessageLookupByLibrary.simpleMessage(
            "Certification of rabies vaccination"),
        "certificate_not_empty":
            MessageLookupByLibrary.simpleMessage("Certificate is not empty"),
        "change_pass": MessageLookupByLibrary.simpleMessage("Change password"),
        "choices": MessageLookupByLibrary.simpleMessage("Choice"),
        "choose_a_project":
            MessageLookupByLibrary.simpleMessage("Choose a project"),
        "choose_an_apartment":
            MessageLookupByLibrary.simpleMessage("Choose an apartment"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "cmnd": MessageLookupByLibrary.simpleMessage("CMCD/ CCCD/ Passport"),
        "code_file": MessageLookupByLibrary.simpleMessage("File code"),
        "code_verify":
            MessageLookupByLibrary.simpleMessage("Verify security code"),
        "color": MessageLookupByLibrary.simpleMessage("Color"),
        "coming_soon": MessageLookupByLibrary.simpleMessage("Comming soon"),
        "complain": MessageLookupByLibrary.simpleMessage("Complain"),
        "complain_reason":
            MessageLookupByLibrary.simpleMessage("Complain reason"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirm_cancel_request": m0,
        "confirm_delete_letter": m1,
        "confirm_delete_service": m2,
        "confirm_end_chat": MessageLookupByLibrary.simpleMessage(
            "Do you want to end this conversation."),
        "confirm_hand_over": MessageLookupByLibrary.simpleMessage(
            "Are you sure accept to hand over."),
        "confirm_lock_card": m3,
        "confirm_lock_trans_card": MessageLookupByLibrary.simpleMessage(
            "Do you want to lock transportation card?"),
        "confirm_par_ques_event": m4,
        "confirm_participate_event":
            MessageLookupByLibrary.simpleMessage("Confirm participate event"),
        "confirm_pass":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "confirm_send_request": m5,
        "confirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
        "cons_agree": MessageLookupByLibrary.simpleMessage(
            "You need to agree to comply with the regulations on construction registration"),
        "cons_code": MessageLookupByLibrary.simpleMessage("Construction code"),
        "cons_day": MessageLookupByLibrary.simpleMessage("Construction day"),
        "cons_drawing":
            MessageLookupByLibrary.simpleMessage("Construction drawing"),
        "cons_fee": MessageLookupByLibrary.simpleMessage("Construction fee"),
        "cons_file": MessageLookupByLibrary.simpleMessage("Construction file"),
        "cons_file_details": MessageLookupByLibrary.simpleMessage(
            "Construction document details"),
        "cons_info":
            MessageLookupByLibrary.simpleMessage("Construction information"),
        "cons_list": MessageLookupByLibrary.simpleMessage("Construction list"),
        "cons_reg":
            MessageLookupByLibrary.simpleMessage("Construction registration"),
        "cons_reg_detail": MessageLookupByLibrary.simpleMessage(
            "Construction registration details"),
        "cons_reg_letter": MessageLookupByLibrary.simpleMessage(
            "Construction registration letter"),
        "cons_regulation":
            MessageLookupByLibrary.simpleMessage("Construction regulation"),
        "cons_type": MessageLookupByLibrary.simpleMessage("Construction type"),
        "cons_unit": MessageLookupByLibrary.simpleMessage("Construction unit"),
        "cons_unit_info": MessageLookupByLibrary.simpleMessage(
            "Construction unit information"),
        "construction": MessageLookupByLibrary.simpleMessage("Construction"),
        "content": MessageLookupByLibrary.simpleMessage("Content"),
        "covenient_service":
            MessageLookupByLibrary.simpleMessage("Covenient service"),
        "create_acc": MessageLookupByLibrary.simpleMessage("Create an account"),
        "create_acc_1":
            MessageLookupByLibrary.simpleMessage("Create an account"),
        "created_date": MessageLookupByLibrary.simpleMessage("Created date"),
        "current_pass":
            MessageLookupByLibrary.simpleMessage("Current password"),
        "customer_care": MessageLookupByLibrary.simpleMessage("Customer care"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "date_send": MessageLookupByLibrary.simpleMessage("Send date"),
        "debt": MessageLookupByLibrary.simpleMessage("Payment, debt remind"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "delete_letter": MessageLookupByLibrary.simpleMessage("Delete letter"),
        "delivery_info":
            MessageLookupByLibrary.simpleMessage("Tranfer information"),
        "delivery_letter":
            MessageLookupByLibrary.simpleMessage("Delivery_letter"),
        "dependence_has_info":
            MessageLookupByLibrary.simpleMessage("Existed dependent person"),
        "dependence_not_info": MessageLookupByLibrary.simpleMessage(
            "Non-Existed dependent person"),
        "dependent_apartment":
            MessageLookupByLibrary.simpleMessage("Dependent apartment"),
        "dependent_person":
            MessageLookupByLibrary.simpleMessage("Dependent person"),
        "deposit": MessageLookupByLibrary.simpleMessage("Deposit"),
        "deputy": MessageLookupByLibrary.simpleMessage("Deputy"),
        "deputy_phone": MessageLookupByLibrary.simpleMessage("Phone of deputy"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "detail_view": MessageLookupByLibrary.simpleMessage("Details view"),
        "details": MessageLookupByLibrary.simpleMessage("Details"),
        "dimention": MessageLookupByLibrary.simpleMessage("Dimention"),
        "discount": MessageLookupByLibrary.simpleMessage("Discount"),
        "discount_type": MessageLookupByLibrary.simpleMessage("Discount type"),
        "dog": MessageLookupByLibrary.simpleMessage("Dog"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "due_bill": MessageLookupByLibrary.simpleMessage("Due date"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "edit_package": MessageLookupByLibrary.simpleMessage("Edit package"),
        "edit_reg_const": MessageLookupByLibrary.simpleMessage(
            "Edit construction regitration"),
        "edit_reg_deliver":
            MessageLookupByLibrary.simpleMessage("Edit register delivery"),
        "edit_reg_pet":
            MessageLookupByLibrary.simpleMessage("Edit registration pet"),
        "edit_res_card":
            MessageLookupByLibrary.simpleMessage("edit resident card"),
        "edit_service_a": m6,
        "edit_trans_card": MessageLookupByLibrary.simpleMessage(
            "Register transportation card"),
        "education_level":
            MessageLookupByLibrary.simpleMessage("Education level"),
        "elcetric_bill":
            MessageLookupByLibrary.simpleMessage("Electricity bill"),
        "electricity": MessageLookupByLibrary.simpleMessage("Electricity"),
        "elevator_card": MessageLookupByLibrary.simpleMessage("Elevator card"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "en": MessageLookupByLibrary.simpleMessage("English"),
        "end": MessageLookupByLibrary.simpleMessage("End"),
        "end_chat": MessageLookupByLibrary.simpleMessage("End conversation!"),
        "end_date": MessageLookupByLibrary.simpleMessage("End date"),
        "end_date_after_now": MessageLookupByLibrary.simpleMessage(
            "End date can not be less than now"),
        "end_date_after_start_date": MessageLookupByLibrary.simpleMessage(
            "End date can not be less than start date"),
        "end_date_not_empty":
            MessageLookupByLibrary.simpleMessage("End date can not be empty"),
        "end_time": MessageLookupByLibrary.simpleMessage("End time"),
        "end_time_reg":
            MessageLookupByLibrary.simpleMessage("End registration time"),
        "enter": MessageLookupByLibrary.simpleMessage("Enter"),
        "enter_address": MessageLookupByLibrary.simpleMessage("Enter address"),
        "enter_cons_unit_name": MessageLookupByLibrary.simpleMessage(
            "Enter construction uint name"),
        "enter_deputy_name":
            MessageLookupByLibrary.simpleMessage("Enter deputy name"),
        "enter_email": MessageLookupByLibrary.simpleMessage("Enter email"),
        "enter_email_phone":
            MessageLookupByLibrary.simpleMessage("Enter email /phone"),
        "enter_identity":
            MessageLookupByLibrary.simpleMessage("Enter identity"),
        "enter_name": MessageLookupByLibrary.simpleMessage("Enter name"),
        "enter_num": MessageLookupByLibrary.simpleMessage("Enter Number"),
        "enter_pas": MessageLookupByLibrary.simpleMessage("Enter password"),
        "enter_payment_pass":
            MessageLookupByLibrary.simpleMessage("Enter payment password"),
        "enter_phone":
            MessageLookupByLibrary.simpleMessage("Enter phone number"),
        "enter_phone_email":
            MessageLookupByLibrary.simpleMessage("Enter phone number or email"),
        "enter_username":
            MessageLookupByLibrary.simpleMessage("Enter username"),
        "enter_worker_num":
            MessageLookupByLibrary.simpleMessage("Enter worker amount"),
        "err_conn": MessageLookupByLibrary.simpleMessage("Error Connection"),
        "err_internet":
            MessageLookupByLibrary.simpleMessage("Can not connect to server"),
        "err_unknown": MessageLookupByLibrary.simpleMessage("Unknown Error"),
        "err_x": m7,
        "error": MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "ethnic": MessageLookupByLibrary.simpleMessage("Ethnic"),
        "event": MessageLookupByLibrary.simpleMessage("Event"),
        "event_msg":
            MessageLookupByLibrary.simpleMessage("Follow events by date/month"),
        "event_notification":
            MessageLookupByLibrary.simpleMessage("Event_notification"),
        "executed": MessageLookupByLibrary.simpleMessage("Executing"),
        "executing": MessageLookupByLibrary.simpleMessage("Executing"),
        "exist_drawing":
            MessageLookupByLibrary.simpleMessage("Existing drawing"),
        "existed_drawing_not_empty": MessageLookupByLibrary.simpleMessage(
            "Existed drawing can not be empty"),
        "expired": MessageLookupByLibrary.simpleMessage("Expired"),
        "expired_date": MessageLookupByLibrary.simpleMessage("Expired_date"),
        "expired_login": MessageLookupByLibrary.simpleMessage(
            "Login session is invalid, please sign in again"),
        "extend": MessageLookupByLibrary.simpleMessage("Extend"),
        "failure": MessageLookupByLibrary.simpleMessage("Failure"),
        "fee_paid": MessageLookupByLibrary.simpleMessage("Fee paid"),
        "feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
        "female": MessageLookupByLibrary.simpleMessage("Female"),
        "file_code": MessageLookupByLibrary.simpleMessage("Document code"),
        "file_downloading":
            MessageLookupByLibrary.simpleMessage("File is downloading"),
        "file_info": MessageLookupByLibrary.simpleMessage("File information"),
        "file_not_support": MessageLookupByLibrary.simpleMessage(
            "Upload file is not supported"),
        "file_selection":
            MessageLookupByLibrary.simpleMessage("File selection"),
        "file_status": MessageLookupByLibrary.simpleMessage("File status"),
        "find_time_now": MessageLookupByLibrary.simpleMessage(
            "Found time not after now day"),
        "finish": MessageLookupByLibrary.simpleMessage("Finish"),
        "follow_ser": MessageLookupByLibrary.simpleMessage("Follow services"),
        "forgot_pass": MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "forum": MessageLookupByLibrary.simpleMessage("Forum"),
        "found": MessageLookupByLibrary.simpleMessage("Wait to confirm"),
        "found_object": MessageLookupByLibrary.simpleMessage("Found object"),
        "found_place": MessageLookupByLibrary.simpleMessage("Found place"),
        "found_time": MessageLookupByLibrary.simpleMessage("Found time"),
        "free_service": MessageLookupByLibrary.simpleMessage("Free service"),
        "front_side": MessageLookupByLibrary.simpleMessage("Front side"),
        "full_name": MessageLookupByLibrary.simpleMessage("Full name"),
        "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "general_info":
            MessageLookupByLibrary.simpleMessage("General information"),
        "general_notification":
            MessageLookupByLibrary.simpleMessage("General notification"),
        "gym_card": MessageLookupByLibrary.simpleMessage("Gym service"),
        "hand_date": MessageLookupByLibrary.simpleMessage("Hand over date"),
        "hand_over": MessageLookupByLibrary.simpleMessage("Hand over"),
        "hand_over_asset_list":
            MessageLookupByLibrary.simpleMessage("Hand over asset list"),
        "hand_over_date":
            MessageLookupByLibrary.simpleMessage("Hand over date"),
        "hand_over_employee":
            MessageLookupByLibrary.simpleMessage("Hand over employee"),
        "hand_over_time":
            MessageLookupByLibrary.simpleMessage("Hand over time"),
        "hand_time": MessageLookupByLibrary.simpleMessage("Hand over time"),
        "handed_over": MessageLookupByLibrary.simpleMessage("Handed over"),
        "handing_over":
            MessageLookupByLibrary.simpleMessage("Inprocess hand over"),
        "happened": MessageLookupByLibrary.simpleMessage("Happened"),
        "happening": MessageLookupByLibrary.simpleMessage("Happenning"),
        "happening_location":
            MessageLookupByLibrary.simpleMessage("Happening location"),
        "have_acc":
            MessageLookupByLibrary.simpleMessage("already have an account "),
        "height": MessageLookupByLibrary.simpleMessage("Height"),
        "hello": MessageLookupByLibrary.simpleMessage("Hello"),
        "here": MessageLookupByLibrary.simpleMessage("tại đây"),
        "his_reg_service":
            MessageLookupByLibrary.simpleMessage("Register service history"),
        "history": MessageLookupByLibrary.simpleMessage("Timeline"),
        "history_find_obj":
            MessageLookupByLibrary.simpleMessage("History find object"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "hour": MessageLookupByLibrary.simpleMessage("Time"),
        "housework": MessageLookupByLibrary.simpleMessage("Housework"),
        "i_agree": MessageLookupByLibrary.simpleMessage("I agree with"),
        "i_confirm": MessageLookupByLibrary.simpleMessage(
            "I confirm that I will comply with the regulations on construction and will compensate for all losses, complaints, costs incurred from this construction and repair work.See more"),
        "i_found": MessageLookupByLibrary.simpleMessage("Found"),
        "identity_back_not_empty": MessageLookupByLibrary.simpleMessage(
            "Identity card back side image can not be empty"),
        "identity_front_not_empty": MessageLookupByLibrary.simpleMessage(
            "Identity card front side image can not be empty"),
        "identity_photo": MessageLookupByLibrary.simpleMessage(
            "Identity card/ passport photos"),
        "image_not_empty":
            MessageLookupByLibrary.simpleMessage("Image can not be empty"),
        "inactive": MessageLookupByLibrary.simpleMessage("Inactive"),
        "incorrect_usn_pass": MessageLookupByLibrary.simpleMessage(
            "Phone number/Email or password is not correct."),
        "info": MessageLookupByLibrary.simpleMessage("Infomation"),
        "info_reception":
            MessageLookupByLibrary.simpleMessage("Information reception"),
        "internet": MessageLookupByLibrary.simpleMessage("Internet"),
        "invalid_data": MessageLookupByLibrary.simpleMessage("Invalid date"),
        "item_list_not_empty":
            MessageLookupByLibrary.simpleMessage("Item list can not be empty"),
        "job": MessageLookupByLibrary.simpleMessage("Job"),
        "l_new": MessageLookupByLibrary.simpleMessage("New"),
        "l_w_e":
            MessageLookupByLibrary.simpleMessage("Length x width x elevation"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "letter_info":
            MessageLookupByLibrary.simpleMessage("Letter infomation"),
        "letter_num": MessageLookupByLibrary.simpleMessage("Letter code"),
        "letter_status": MessageLookupByLibrary.simpleMessage("Letter status"),
        "licene_plate": MessageLookupByLibrary.simpleMessage("Licene plate"),
        "limit_15mb": MessageLookupByLibrary.simpleMessage(
            "The limit for each upload file does not exceed 15MB"),
        "lock": MessageLookupByLibrary.simpleMessage("Lock"),
        "lock_card": MessageLookupByLibrary.simpleMessage("Lock card"),
        "long": MessageLookupByLibrary.simpleMessage("Long"),
        "lost_time": MessageLookupByLibrary.simpleMessage("Lost time"),
        "lost_time_now":
            MessageLookupByLibrary.simpleMessage("Lost time not after now day"),
        "male": MessageLookupByLibrary.simpleMessage("Male"),
        "material": MessageLookupByLibrary.simpleMessage("Material"),
        "max_day_pay":
            MessageLookupByLibrary.simpleMessage("Maximum payment date"),
        "max_pay_day_not_empty": MessageLookupByLibrary.simpleMessage(
            "Maximum payment date can not be empty"),
        "message": MessageLookupByLibrary.simpleMessage("Message"),
        "minutes": MessageLookupByLibrary.simpleMessage("Minutes"),
        "missing_obj": MessageLookupByLibrary.simpleMessage("Missing object"),
        "missing_object":
            MessageLookupByLibrary.simpleMessage("Missing object"),
        "missing_report":
            MessageLookupByLibrary.simpleMessage("Missing Report"),
        "missing_time": MessageLookupByLibrary.simpleMessage("Missing time"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "nationality": MessageLookupByLibrary.simpleMessage("Nationality"),
        "need_choose_cylce_regdate": MessageLookupByLibrary.simpleMessage(
            "You need to choose payment cycle and register date first"),
        "need_pay": MessageLookupByLibrary.simpleMessage("Need to pay"),
        "need_support":
            MessageLookupByLibrary.simpleMessage("Need protection support"),
        "new_pass": MessageLookupByLibrary.simpleMessage("New Password"),
        "new_resident": MessageLookupByLibrary.simpleMessage("New resident"),
        "newl": MessageLookupByLibrary.simpleMessage("New"),
        "news": MessageLookupByLibrary.simpleMessage("News"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "no_acc":
            MessageLookupByLibrary.simpleMessage("You don\'t have any account"),
        "no_bill": MessageLookupByLibrary.simpleMessage("Don\'t have any bill"),
        "no_card": MessageLookupByLibrary.simpleMessage("Don\'t have any card"),
        "no_comment": MessageLookupByLibrary.simpleMessage("No comment"),
        "no_cons_file": MessageLookupByLibrary.simpleMessage(
            "Don\'t have any construction file"),
        "no_delivery":
            MessageLookupByLibrary.simpleMessage("Don\'t have any package"),
        "no_event":
            MessageLookupByLibrary.simpleMessage("Don\'t have any event"),
        "no_hand_over": MessageLookupByLibrary.simpleMessage("No hand over"),
        "no_letter":
            MessageLookupByLibrary.simpleMessage("Don\'t have any letter"),
        "no_missing_obj": MessageLookupByLibrary.simpleMessage(
            "Don\'t have any missing object"),
        "no_more_data": MessageLookupByLibrary.simpleMessage("No more data"),
        "no_news": MessageLookupByLibrary.simpleMessage("Don\'t have any news"),
        "no_notification": MessageLookupByLibrary.simpleMessage(
            "Don\'t have any notification"),
        "no_parcel":
            MessageLookupByLibrary.simpleMessage("Don\'t have any parcel"),
        "no_pet": MessageLookupByLibrary.simpleMessage(
            "Don\'t have any pet registration"),
        "no_pick_obj": MessageLookupByLibrary.simpleMessage(
            "Don\'t have any picked object"),
        "no_reflection":
            MessageLookupByLibrary.simpleMessage("No have any feedback"),
        "no_reg_cons": MessageLookupByLibrary.simpleMessage(
            "Don\'t have any construction registration"),
        "no_service_regitration": MessageLookupByLibrary.simpleMessage(
            "Don\'t have any service registration"),
        "no_trans_card":
            MessageLookupByLibrary.simpleMessage("No have transportation card"),
        "no_trans_letter": MessageLookupByLibrary.simpleMessage(
            "No have transportation letter"),
        "not_blank": MessageLookupByLibrary.simpleMessage("Can not be empty"),
        "not_dimention":
            MessageLookupByLibrary.simpleMessage("Not be dimention"),
        "not_email": MessageLookupByLibrary.simpleMessage("Not is email."),
        "not_empty_back":
            MessageLookupByLibrary.simpleMessage("Not empty back side photo"),
        "not_empty_front":
            MessageLookupByLibrary.simpleMessage("Not empty front side photo"),
        "not_empty_vehicle_type": MessageLookupByLibrary.simpleMessage(
            "Vehicle type can not be empty"),
        "not_found": MessageLookupByLibrary.simpleMessage("Not found"),
        "not_found_account": MessageLookupByLibrary.simpleMessage(
            "Not found account Information"),
        "not_get_otp":
            MessageLookupByLibrary.simpleMessage("Did not receive OTP?"),
        "not_pass": MessageLookupByLibrary.simpleMessage("Not pass"),
        "not_pass_list": m8,
        "not_pass_reason":
            MessageLookupByLibrary.simpleMessage("Not pass reason"),
        "not_read": MessageLookupByLibrary.simpleMessage("Unread"),
        "not_special_char": MessageLookupByLibrary.simpleMessage(
            "Can not contain special symbol"),
        "not_upload_15mb": MessageLookupByLibrary.simpleMessage(
            "Can not upload file larger 15MB"),
        "not_vietnamese": MessageLookupByLibrary.simpleMessage(
            "Can not contain Vietnamese letter"),
        "not_zero":
            MessageLookupByLibrary.simpleMessage("Not enter only zero!"),
        "note": MessageLookupByLibrary.simpleMessage("Note"),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "notification_type":
            MessageLookupByLibrary.simpleMessage("Notification type"),
        "object_code": MessageLookupByLibrary.simpleMessage("Object code"),
        "object_details":
            MessageLookupByLibrary.simpleMessage("Object details"),
        "object_info":
            MessageLookupByLibrary.simpleMessage("Object information"),
        "object_name": MessageLookupByLibrary.simpleMessage("Object name"),
        "of_building_management":
            MessageLookupByLibrary.simpleMessage("of building management"),
        "off_day": MessageLookupByLibrary.simpleMessage("Off day"),
        "other": MessageLookupByLibrary.simpleMessage("Other"),
        "other_bill": MessageLookupByLibrary.simpleMessage("Other bill"),
        "other_gender": MessageLookupByLibrary.simpleMessage("Other gender"),
        "other_info": MessageLookupByLibrary.simpleMessage("Other information"),
        "otp_invalid":
            MessageLookupByLibrary.simpleMessage("OTP code is invalid"),
        "otp_msg": MessageLookupByLibrary.simpleMessage(
            "We have sent OTP code to your registered phone number or email. Please enter the OTP code to perform authentication."),
        "otp_verify": MessageLookupByLibrary.simpleMessage("OTP verify"),
        "package": MessageLookupByLibrary.simpleMessage("Package"),
        "package_info":
            MessageLookupByLibrary.simpleMessage("Package infomation"),
        "package_items_not_empty": MessageLookupByLibrary.simpleMessage(
            "Package items can not be empty"),
        "package_name": MessageLookupByLibrary.simpleMessage("Package Name"),
        "paid": MessageLookupByLibrary.simpleMessage("Paid"),
        "paid_deposit": MessageLookupByLibrary.simpleMessage("deposit paid"),
        "paid_payment": MessageLookupByLibrary.simpleMessage("Payment paid"),
        "parcel": MessageLookupByLibrary.simpleMessage("Parcel"),
        "parcel_code": MessageLookupByLibrary.simpleMessage("Parcel code"),
        "parcel_details":
            MessageLookupByLibrary.simpleMessage("Parcel details"),
        "parcel_info":
            MessageLookupByLibrary.simpleMessage("Parcel informations"),
        "parcel_name": MessageLookupByLibrary.simpleMessage("Parcel name"),
        "parking_bill": MessageLookupByLibrary.simpleMessage("Parking bill"),
        "parking_card": MessageLookupByLibrary.simpleMessage("Parking card"),
        "participate": MessageLookupByLibrary.simpleMessage("Participate"),
        "pass": MessageLookupByLibrary.simpleMessage("Pass"),
        "pass_list": MessageLookupByLibrary.simpleMessage(
            "Assets was handed over fully"),
        "pass_min_length": MessageLookupByLibrary.simpleMessage(
            "Password length can not less than 8 letter"),
        "pass_special": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least 1 special character"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "pay": MessageLookupByLibrary.simpleMessage("Payment"),
        "pay_date": MessageLookupByLibrary.simpleMessage("Pay date"),
        "payment_circle":
            MessageLookupByLibrary.simpleMessage("Payment circle"),
        "payment_cycle_not_empty": MessageLookupByLibrary.simpleMessage(
            "Payment circle can be not empty"),
        "payment_method":
            MessageLookupByLibrary.simpleMessage("Payment method"),
        "percent": MessageLookupByLibrary.simpleMessage("Percent"),
        "permission_denied":
            MessageLookupByLibrary.simpleMessage("Permission denied"),
        "permission_denied_msg":
            MessageLookupByLibrary.simpleMessage("You don\'t have permission"),
        "personal_info":
            MessageLookupByLibrary.simpleMessage("Personal Infomation"),
        "pet": MessageLookupByLibrary.simpleMessage("Pet"),
        "pet_agree": MessageLookupByLibrary.simpleMessage(
            "You need to agree to comply with the regulations on pet registration"),
        "pet_female": MessageLookupByLibrary.simpleMessage("Female"),
        "pet_images": MessageLookupByLibrary.simpleMessage("Pet images"),
        "pet_info": MessageLookupByLibrary.simpleMessage("Pet information"),
        "pet_male": MessageLookupByLibrary.simpleMessage("Male"),
        "pet_name": MessageLookupByLibrary.simpleMessage("Pet name"),
        "pet_origin": MessageLookupByLibrary.simpleMessage("Pet origin"),
        "pet_regulation":
            MessageLookupByLibrary.simpleMessage("Pet regulation"),
        "pet_type": MessageLookupByLibrary.simpleMessage("Pet type"),
        "phone_email": MessageLookupByLibrary.simpleMessage("Phone/ Email"),
        "phone_num": MessageLookupByLibrary.simpleMessage("Phone number"),
        "photo_back_side":
            MessageLookupByLibrary.simpleMessage("Photo back size"),
        "photo_front_side":
            MessageLookupByLibrary.simpleMessage("Photo front size"),
        "photos": MessageLookupByLibrary.simpleMessage("Photos"),
        "pick_file_error": MessageLookupByLibrary.simpleMessage(
            "You can only upload file jpeg, jpg, png, pdf, doc, docx, xls, xlsx"),
        "pick_image_error": MessageLookupByLibrary.simpleMessage(
            "You can only upload file jpeg, jpg, png"),
        "pin": MessageLookupByLibrary.simpleMessage("Pin"),
        "place_issue": MessageLookupByLibrary.simpleMessage("Issue place"),
        "pool": MessageLookupByLibrary.simpleMessage("Pool"),
        "prev": MessageLookupByLibrary.simpleMessage("Previous"),
        "processing_content":
            MessageLookupByLibrary.simpleMessage("Processing Content"),
        "processing_result":
            MessageLookupByLibrary.simpleMessage("Processing result"),
        "project": MessageLookupByLibrary.simpleMessage("Project"),
        "prov_city": MessageLookupByLibrary.simpleMessage("Province/City"),
        "pull_load_failed":
            MessageLookupByLibrary.simpleMessage("Load Failed!Click retry!"),
        "pull_to_load": MessageLookupByLibrary.simpleMessage("Pull to load"),
        "re_book": MessageLookupByLibrary.simpleMessage("Re book"),
        "re_sign_in":
            MessageLookupByLibrary.simpleMessage("Please sign in again"),
        "receipt_date": MessageLookupByLibrary.simpleMessage("Receipted date"),
        "receipted": MessageLookupByLibrary.simpleMessage("Receipted"),
        "red_code": MessageLookupByLibrary.simpleMessage("Register code"),
        "reflection": MessageLookupByLibrary.simpleMessage("Refection"),
        "reflection_details":
            MessageLookupByLibrary.simpleMessage("Reflection details"),
        "reflection_reason":
            MessageLookupByLibrary.simpleMessage("Reflection reason"),
        "reflection_reason_not_empty": MessageLookupByLibrary.simpleMessage(
            "reflection reason can\'t not be empty"),
        "reflection_type":
            MessageLookupByLibrary.simpleMessage("Reflection type"),
        "reflex": MessageLookupByLibrary.simpleMessage("Reflection"),
        "reg_code": MessageLookupByLibrary.simpleMessage("Registration code"),
        "reg_const":
            MessageLookupByLibrary.simpleMessage("Registration construction"),
        "reg_date": MessageLookupByLibrary.simpleMessage("Registration date"),
        "reg_date_not_after_now": MessageLookupByLibrary.simpleMessage(
            "Registration day is not beefore now"),
        "reg_day_not_empty": MessageLookupByLibrary.simpleMessage(
            "Registration date can be not empty"),
        "reg_deliver":
            MessageLookupByLibrary.simpleMessage("Register delivery"),
        "reg_missing_obj": MessageLookupByLibrary.simpleMessage(
            "Register find missing object"),
        "reg_num": MessageLookupByLibrary.simpleMessage("Register number"),
        "reg_pet": MessageLookupByLibrary.simpleMessage("Pet registration"),
        "reg_pet_info":
            MessageLookupByLibrary.simpleMessage("registration pet infomation"),
        "reg_pet_list":
            MessageLookupByLibrary.simpleMessage("Pet registration list"),
        "reg_service":
            MessageLookupByLibrary.simpleMessage("Registration service"),
        "reg_service_a": m9,
        "reg_time": MessageLookupByLibrary.simpleMessage("Time registration"),
        "reg_trans_photos": MessageLookupByLibrary.simpleMessage(
            "Register transportation photos (2 side)"),
        "region": MessageLookupByLibrary.simpleMessage("Region"),
        "register_code": MessageLookupByLibrary.simpleMessage("Register code"),
        "register_res_card":
            MessageLookupByLibrary.simpleMessage("Đăng ký thẻ cư dân"),
        "register_trans_card": MessageLookupByLibrary.simpleMessage(
            "Register transportation card"),
        "regulations": MessageLookupByLibrary.simpleMessage("regulations"),
        "reject_card": MessageLookupByLibrary.simpleMessage("Reject card"),
        "reject_reason": MessageLookupByLibrary.simpleMessage("Reject reason"),
        "related_doc_photo":
            MessageLookupByLibrary.simpleMessage("Related document photos"),
        "related_image_not_empty": MessageLookupByLibrary.simpleMessage(
            "Related document image can not empty"),
        "related_photo":
            MessageLookupByLibrary.simpleMessage("Related document photos"),
        "relation_with_owner":
            MessageLookupByLibrary.simpleMessage("Relationship with owner"),
        "release_to_load":
            MessageLookupByLibrary.simpleMessage("Release to load more"),
        "remember_acc": MessageLookupByLibrary.simpleMessage("Remember me"),
        "renew_drawing_not_empty": MessageLookupByLibrary.simpleMessage(
            "Renew drawing can not be empty"),
        "renewal_drawing":
            MessageLookupByLibrary.simpleMessage("Renewal drawing"),
        "report_not_empty":
            MessageLookupByLibrary.simpleMessage("Report is not empty"),
        "res_card": MessageLookupByLibrary.simpleMessage("Residence card"),
        "res_card_details":
            MessageLookupByLibrary.simpleMessage("Resident card details"),
        "res_card_register":
            MessageLookupByLibrary.simpleMessage("Resident card register"),
        "res_image_not_empty": MessageLookupByLibrary.simpleMessage(
            "Resident image can not empty"),
        "res_photo": MessageLookupByLibrary.simpleMessage("Resident photos"),
        "res_reaction":
            MessageLookupByLibrary.simpleMessage("Resident reaction"),
        "resend": MessageLookupByLibrary.simpleMessage("Resend"),
        "reset_pass": MessageLookupByLibrary.simpleMessage("Reset password"),
        "reset_pass_success": MessageLookupByLibrary.simpleMessage(
            "Reset Password successfully, please Sign in again"),
        "resgiter_vehicle_back_image_not_empty":
            MessageLookupByLibrary.simpleMessage(
                "Resgiter vehicle card back site  image can not be empty"),
        "resgiter_vehicle_front_image_not_empty":
            MessageLookupByLibrary.simpleMessage(
                "Resgiter vehicle card front site  image can not be empty"),
        "residence_news":
            MessageLookupByLibrary.simpleMessage("Residence news"),
        "resident_address":
            MessageLookupByLibrary.simpleMessage("Resident address"),
        "resident_info":
            MessageLookupByLibrary.simpleMessage("Resident information"),
        "resident_reg":
            MessageLookupByLibrary.simpleMessage("Resident registration"),
        "resident_type": MessageLookupByLibrary.simpleMessage("Resident type"),
        "retry": MessageLookupByLibrary.simpleMessage("Please try again."),
        "return_image": MessageLookupByLibrary.simpleMessage("Returned images"),
        "returned": MessageLookupByLibrary.simpleMessage("Returned"),
        "rgstr_code_0": MessageLookupByLibrary.simpleMessage(
            "Register successfully, please sign in"),
        "rgstr_code_1":
            MessageLookupByLibrary.simpleMessage("Missing required field"),
        "rgstr_code_2":
            MessageLookupByLibrary.simpleMessage("Password not match"),
        "rgstr_code_3": MessageLookupByLibrary.simpleMessage(
            "Password is at least 8 character. Including 1 uppercase, 1 lowercase, 1 number và 1 special symbol"),
        "rgstr_code_4": MessageLookupByLibrary.simpleMessage(
            "Account is existed,  please sign in"),
        "rgstr_code_5": MessageLookupByLibrary.simpleMessage(
            "User\'s Information is not available, please contact to Admin."),
        "rgstr_code_7":
            MessageLookupByLibrary.simpleMessage("OTP code is invalid"),
        "rgstr_code_8": MessageLookupByLibrary.simpleMessage("System error"),
        "rgstr_code_9":
            MessageLookupByLibrary.simpleMessage("Account is not activated"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "scuccess_participation": m10,
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "search_aparment":
            MessageLookupByLibrary.simpleMessage("Search apartment"),
        "search_project":
            MessageLookupByLibrary.simpleMessage("Search project"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "select_cons_type":
            MessageLookupByLibrary.simpleMessage("Select construction type"),
        "select_surface":
            MessageLookupByLibrary.simpleMessage("Select surface"),
        "send_letter": MessageLookupByLibrary.simpleMessage("Send letter"),
        "send_otp_to": MessageLookupByLibrary.simpleMessage(
            "Send OTP reset password code to"),
        "send_reflection":
            MessageLookupByLibrary.simpleMessage("Send feedback "),
        "send_request": MessageLookupByLibrary.simpleMessage("Send request"),
        "send_to_email":
            MessageLookupByLibrary.simpleMessage("Send OTP to email"),
        "send_to_phone":
            MessageLookupByLibrary.simpleMessage("Send OTP to phone number"),
        "send_verify": MessageLookupByLibrary.simpleMessage("Send verify"),
        "service_bill": MessageLookupByLibrary.simpleMessage("Service bill"),
        "service_name": m11,
        "service_reflection":
            MessageLookupByLibrary.simpleMessage("Service_reflection"),
        "services": MessageLookupByLibrary.simpleMessage("Service"),
        "setting": MessageLookupByLibrary.simpleMessage("Setting"),
        "sex": MessageLookupByLibrary.simpleMessage("Sex"),
        "shopping_online":
            MessageLookupByLibrary.simpleMessage("Shopping online"),
        "shopping_represent":
            MessageLookupByLibrary.simpleMessage("Shopping represent"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Sign in"),
        "sign_out": MessageLookupByLibrary.simpleMessage("Sign out"),
        "sign_out_msg":
            MessageLookupByLibrary.simpleMessage("Do you want to sign out?"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
        "social_media":
            MessageLookupByLibrary.simpleMessage("Link personal social media"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "start_chat":
            MessageLookupByLibrary.simpleMessage("Start conversation!"),
        "start_date": MessageLookupByLibrary.simpleMessage("Start date"),
        "start_date_after_now": MessageLookupByLibrary.simpleMessage(
            "Start date can not be greater than now"),
        "start_date_after_now_equal": MessageLookupByLibrary.simpleMessage(
            "Start date must be greater than now"),
        "start_date_not_empty":
            MessageLookupByLibrary.simpleMessage("Start date can not be empty"),
        "start_time": MessageLookupByLibrary.simpleMessage("Start time"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "status_cons":
            MessageLookupByLibrary.simpleMessage("Construction code"),
        "status_letter": MessageLookupByLibrary.simpleMessage("Status letter"),
        "step1": MessageLookupByLibrary.simpleMessage("Step 1"),
        "step2": MessageLookupByLibrary.simpleMessage("Step 2"),
        "step3": MessageLookupByLibrary.simpleMessage("Step 3"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "success_accept":
            MessageLookupByLibrary.simpleMessage("Accepted successfully"),
        "success_add_dependence": m12,
        "success_add_ticket": MessageLookupByLibrary.simpleMessage(
            "Add new reflection successfully"),
        "success_can_req":
            MessageLookupByLibrary.simpleMessage("Cancel letter successfully"),
        "success_confirm":
            MessageLookupByLibrary.simpleMessage("Success confirm"),
        "success_cr_new":
            MessageLookupByLibrary.simpleMessage("Add new successfully"),
        "success_edit":
            MessageLookupByLibrary.simpleMessage("Edit successfully"),
        "success_find": MessageLookupByLibrary.simpleMessage(
            "change status item successfully"),
        "success_found": MessageLookupByLibrary.simpleMessage("Found"),
        "success_lock_card":
            MessageLookupByLibrary.simpleMessage("Lock card successfully"),
        "success_opt":
            MessageLookupByLibrary.simpleMessage("Send OTP code successfully"),
        "success_payment": m13,
        "success_remove":
            MessageLookupByLibrary.simpleMessage("Remove successfully"),
        "success_returned": MessageLookupByLibrary.simpleMessage(
            "change status item successfully"),
        "success_send_letter":
            MessageLookupByLibrary.simpleMessage("Send letter successfully"),
        "success_send_req": MessageLookupByLibrary.simpleMessage(
            "Send to approve request letter successfully"),
        "success_send_ticket": MessageLookupByLibrary.simpleMessage(
            "Send reflection successfully"),
        "success_sign_up":
            MessageLookupByLibrary.simpleMessage("Sign up successfully"),
        "surface": MessageLookupByLibrary.simpleMessage("Surface"),
        "system_notification":
            MessageLookupByLibrary.simpleMessage("System_notification"),
        "take_place_time":
            MessageLookupByLibrary.simpleMessage("Take place time"),
        "terms_services":
            MessageLookupByLibrary.simpleMessage("Terms services"),
        "terms_services_msg": MessageLookupByLibrary.simpleMessage(
            "Registering for a resident account means consenting to "),
        "this_trans_letter":
            MessageLookupByLibrary.simpleMessage("Transportation letter"),
        "time_event_happening":
            MessageLookupByLibrary.simpleMessage("Time event happening"),
        "time_happening":
            MessageLookupByLibrary.simpleMessage("Time happening"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "to_money": MessageLookupByLibrary.simpleMessage("Money"),
        "total": MessageLookupByLibrary.simpleMessage("Total"),
        "total_bill": MessageLookupByLibrary.simpleMessage("Total bill"),
        "total_money": MessageLookupByLibrary.simpleMessage("Total money"),
        "total_pay": MessageLookupByLibrary.simpleMessage("Total payment"),
        "tranfer_in": MessageLookupByLibrary.simpleMessage("Tranfer in"),
        "tranfer_in_reg":
            MessageLookupByLibrary.simpleMessage("Register tranfer in"),
        "tranfer_out": MessageLookupByLibrary.simpleMessage("Tranfer out"),
        "tranfer_out_reg":
            MessageLookupByLibrary.simpleMessage("Register tranfer out"),
        "trans_card":
            MessageLookupByLibrary.simpleMessage("Transportation card"),
        "trans_card_details":
            MessageLookupByLibrary.simpleMessage("Transportation card details"),
        "trans_cer":
            MessageLookupByLibrary.simpleMessage("Registration certificate"),
        "trans_info":
            MessageLookupByLibrary.simpleMessage("Transportation information"),
        "trans_letter":
            MessageLookupByLibrary.simpleMessage("Transportation letter"),
        "trans_type":
            MessageLookupByLibrary.simpleMessage("Transportation type"),
        "transfer_list": MessageLookupByLibrary.simpleMessage("Transfer list"),
        "transfer_type": MessageLookupByLibrary.simpleMessage("Transfer type"),
        "transportation":
            MessageLookupByLibrary.simpleMessage("Transportation"),
        "type": MessageLookupByLibrary.simpleMessage("Type"),
        "unpaid": MessageLookupByLibrary.simpleMessage("Unpaid"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "upload": MessageLookupByLibrary.simpleMessage("Upload"),
        "use_elevator": MessageLookupByLibrary.simpleMessage("Use elevator"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "value": MessageLookupByLibrary.simpleMessage("Value"),
        "vat": MessageLookupByLibrary.simpleMessage("VAT"),
        "verify": MessageLookupByLibrary.simpleMessage("Verify"),
        "vew_records": MessageLookupByLibrary.simpleMessage("View records"),
        "vi": MessageLookupByLibrary.simpleMessage("Vietnamese"),
        "view_record": MessageLookupByLibrary.simpleMessage("View record"),
        "violation_record":
            MessageLookupByLibrary.simpleMessage("Violation record"),
        "violation_records":
            MessageLookupByLibrary.simpleMessage("Violation records"),
        "w":
            MessageLookupByLibrary.simpleMessage("Home Community Smart Living"),
        "wait_approve": MessageLookupByLibrary.simpleMessage("Waiting approve"),
        "wait_execute": MessageLookupByLibrary.simpleMessage("Wait execute"),
        "wait_find": MessageLookupByLibrary.simpleMessage("Wait to find"),
        "wait_hand_over":
            MessageLookupByLibrary.simpleMessage("Wait to hand over"),
        "wait_receipt": MessageLookupByLibrary.simpleMessage("Waiting"),
        "wait_return": MessageLookupByLibrary.simpleMessage("Wait return"),
        "ward": MessageLookupByLibrary.simpleMessage("Distric/ward"),
        "water": MessageLookupByLibrary.simpleMessage("Water"),
        "water_bill": MessageLookupByLibrary.simpleMessage("Water bill"),
        "way_send_otp": MessageLookupByLibrary.simpleMessage(
            "How would you like to receive a code to reset your password?"),
        "we_send_to": m14,
        "weight": MessageLookupByLibrary.simpleMessage("Weight"),
        "weight_not_15":
            MessageLookupByLibrary.simpleMessage("Weight is not larger 15kg"),
        "weight_not_zero":
            MessageLookupByLibrary.simpleMessage("Weight can not be zero"),
        "wellcome_back": MessageLookupByLibrary.simpleMessage("Welcome back"),
        "width": MessageLookupByLibrary.simpleMessage("Width"),
        "work_description":
            MessageLookupByLibrary.simpleMessage("Work description"),
        "worker_num": MessageLookupByLibrary.simpleMessage("Worker amount"),
        "year": MessageLookupByLibrary.simpleMessage("Year"),
        "zone": MessageLookupByLibrary.simpleMessage("Zone"),
        "zone_type": MessageLookupByLibrary.simpleMessage("Zone type")
      };
}
