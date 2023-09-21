// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message(
      'Sign in',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get wellcome_back {
    return Intl.message(
      'Welcome back',
      name: 'wellcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Account name`
  String get account_name {
    return Intl.message(
      'Account name',
      name: 'account_name',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_acc {
    return Intl.message(
      'Remember me',
      name: 'remember_acc',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any account`
  String get no_acc {
    return Intl.message(
      'You don\'t have any account',
      name: 'no_acc',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_num {
    return Intl.message(
      'Phone number',
      name: 'phone_num',
      desc: '',
      args: [],
    );
  }

  /// `Enter email /phone`
  String get enter_email_phone {
    return Intl.message(
      'Enter email /phone',
      name: 'enter_email_phone',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enter_pas {
    return Intl.message(
      'Enter password',
      name: 'enter_pas',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_pass {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_pass',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get create_acc {
    return Intl.message(
      'Create an account',
      name: 'create_acc',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get create_acc_1 {
    return Intl.message(
      'Create an account',
      name: 'create_acc_1',
      desc: '',
      args: [],
    );
  }

  /// `already have an account `
  String get have_acc {
    return Intl.message(
      'already have an account ',
      name: 'have_acc',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enter_name {
    return Intl.message(
      'Enter name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter username`
  String get enter_username {
    return Intl.message(
      'Enter username',
      name: 'enter_username',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_pass {
    return Intl.message(
      'Confirm password',
      name: 'confirm_pass',
      desc: '',
      args: [],
    );
  }

  /// `Can not empty`
  String get can_not_empty {
    return Intl.message(
      'Can not empty',
      name: 'can_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Terms services`
  String get terms_services {
    return Intl.message(
      'Terms services',
      name: 'terms_services',
      desc: '',
      args: [],
    );
  }

  /// `OTP verify`
  String get otp_verify {
    return Intl.message(
      'OTP verify',
      name: 'otp_verify',
      desc: '',
      args: [],
    );
  }

  /// `Verify security code`
  String get code_verify {
    return Intl.message(
      'Verify security code',
      name: 'code_verify',
      desc: '',
      args: [],
    );
  }

  /// `We have sent OTP code to your registered phone number or email. Please enter the OTP code to perform authentication.`
  String get otp_msg {
    return Intl.message(
      'We have sent OTP code to your registered phone number or email. Please enter the OTP code to perform authentication.',
      name: 'otp_msg',
      desc: '',
      args: [],
    );
  }

  /// `We have sent OTP code to your registered email. Please enter the OTP code to perform authentication.`
  String get otp_msg_email {
    return Intl.message(
      'We have sent OTP code to your registered email. Please enter the OTP code to perform authentication.',
      name: 'otp_msg_email',
      desc: '',
      args: [],
    );
  }

  /// `We have sent OTP code to your registered phone number. Please enter the OTP code to perform authentication.`
  String get otp_msg_phone {
    return Intl.message(
      'We have sent OTP code to your registered phone number. Please enter the OTP code to perform authentication.',
      name: 'otp_msg_phone',
      desc: '',
      args: [],
    );
  }

  /// `Did not receive OTP?`
  String get not_get_otp {
    return Intl.message(
      'Did not receive OTP?',
      name: 'not_get_otp',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Personal Infomation`
  String get personal_info {
    return Intl.message(
      'Personal Infomation',
      name: 'personal_info',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_pass {
    return Intl.message(
      'Change password',
      name: 'change_pass',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get sign_out {
    return Intl.message(
      'Sign out',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to sign out?`
  String get sign_out_msg {
    return Intl.message(
      'Do you want to sign out?',
      name: 'sign_out_msg',
      desc: '',
      args: [],
    );
  }

  /// `App version`
  String get app_version {
    return Intl.message(
      'App version',
      name: 'app_version',
      desc: '',
      args: [],
    );
  }

  /// `Infomation`
  String get info {
    return Intl.message(
      'Infomation',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vi {
    return Intl.message(
      'Vietnamese',
      name: 'vi',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get current_pass {
    return Intl.message(
      'Current password',
      name: 'current_pass',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_pass {
    return Intl.message(
      'New Password',
      name: 'new_pass',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter new password`
  String get c_new_pass {
    return Intl.message(
      'Re-enter new password',
      name: 'c_new_pass',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Choice`
  String get choices {
    return Intl.message(
      'Choice',
      name: 'choices',
      desc: '',
      args: [],
    );
  }

  /// `Enter Number`
  String get enter_num {
    return Intl.message(
      'Enter Number',
      name: 'enter_num',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get prev {
    return Intl.message(
      'Previous',
      name: 'prev',
      desc: '',
      args: [],
    );
  }

  /// `Add new`
  String get add_new {
    return Intl.message(
      'Add new',
      name: 'add_new',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_pass {
    return Intl.message(
      'Reset password',
      name: 'reset_pass',
      desc: '',
      args: [],
    );
  }

  /// `Send verify`
  String get send_verify {
    return Intl.message(
      'Send verify',
      name: 'send_verify',
      desc: '',
      args: [],
    );
  }

  /// `No comment`
  String get no_comment {
    return Intl.message(
      'No comment',
      name: 'no_comment',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Failure`
  String get failure {
    return Intl.message(
      'Failure',
      name: 'failure',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Error Connection`
  String get err_conn {
    return Intl.message(
      'Error Connection',
      name: 'err_conn',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Error`
  String get err_unknown {
    return Intl.message(
      'Unknown Error',
      name: 'err_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Can not connect to server`
  String get err_internet {
    return Intl.message(
      'Can not connect to server',
      name: 'err_internet',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Other gender`
  String get other_gender {
    return Intl.message(
      'Other gender',
      name: 'other_gender',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enter_phone {
    return Intl.message(
      'Enter phone number',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Registering for a resident account means consenting to `
  String get terms_services_msg {
    return Intl.message(
      'Registering for a resident account means consenting to ',
      name: 'terms_services_msg',
      desc: '',
      args: [],
    );
  }

  /// `Phone number/Email or password is not correct.`
  String get incorrect_usn_pass {
    return Intl.message(
      'Phone number/Email or password is not correct.',
      name: 'incorrect_usn_pass',
      desc: '',
      args: [],
    );
  }

  /// `Please try again.`
  String get retry {
    return Intl.message(
      'Please try again.',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Error: {message}`
  String err_x(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'err_x',
      desc: '',
      args: [message],
    );
  }

  /// `Enter email`
  String get enter_email {
    return Intl.message(
      'Enter email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Register successfully, please sign in`
  String get rgstr_code_0 {
    return Intl.message(
      'Register successfully, please sign in',
      name: 'rgstr_code_0',
      desc: '',
      args: [],
    );
  }

  /// `Missing required field`
  String get rgstr_code_1 {
    return Intl.message(
      'Missing required field',
      name: 'rgstr_code_1',
      desc: '',
      args: [],
    );
  }

  /// `Password not match`
  String get rgstr_code_2 {
    return Intl.message(
      'Password not match',
      name: 'rgstr_code_2',
      desc: '',
      args: [],
    );
  }

  /// `Password is at least 8 character. Including 1 uppercase, 1 lowercase, 1 number và 1 special symbol`
  String get rgstr_code_3 {
    return Intl.message(
      'Password is at least 8 character. Including 1 uppercase, 1 lowercase, 1 number và 1 special symbol',
      name: 'rgstr_code_3',
      desc: '',
      args: [],
    );
  }

  /// `Account is existed,  please sign in`
  String get rgstr_code_4 {
    return Intl.message(
      'Account is existed,  please sign in',
      name: 'rgstr_code_4',
      desc: '',
      args: [],
    );
  }

  /// `User's Information is not available, please contact to Admin.`
  String get rgstr_code_5 {
    return Intl.message(
      'User\'s Information is not available, please contact to Admin.',
      name: 'rgstr_code_5',
      desc: '',
      args: [],
    );
  }

  /// `OTP code is invalid`
  String get rgstr_code_7 {
    return Intl.message(
      'OTP code is invalid',
      name: 'rgstr_code_7',
      desc: '',
      args: [],
    );
  }

  /// `System error`
  String get rgstr_code_8 {
    return Intl.message(
      'System error',
      name: 'rgstr_code_8',
      desc: '',
      args: [],
    );
  }

  /// `Account is not activated`
  String get rgstr_code_9 {
    return Intl.message(
      'Account is not activated',
      name: 'rgstr_code_9',
      desc: '',
      args: [],
    );
  }

  /// `Choose a project`
  String get choose_a_project {
    return Intl.message(
      'Choose a project',
      name: 'choose_a_project',
      desc: '',
      args: [],
    );
  }

  /// `Choose an apartment`
  String get choose_an_apartment {
    return Intl.message(
      'Choose an apartment',
      name: 'choose_an_apartment',
      desc: '',
      args: [],
    );
  }

  /// `Search apartment`
  String get search_aparment {
    return Intl.message(
      'Search apartment',
      name: 'search_aparment',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bills {
    return Intl.message(
      'Bill',
      name: 'bills',
      desc: '',
      args: [],
    );
  }

  /// `Electricity`
  String get electricity {
    return Intl.message(
      'Electricity',
      name: 'electricity',
      desc: '',
      args: [],
    );
  }

  /// `Water`
  String get water {
    return Intl.message(
      'Water',
      name: 'water',
      desc: '',
      args: [],
    );
  }

  /// `Internet`
  String get internet {
    return Intl.message(
      'Internet',
      name: 'internet',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get services {
    return Intl.message(
      'Service',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Parking card`
  String get parking_card {
    return Intl.message(
      'Parking card',
      name: 'parking_card',
      desc: '',
      args: [],
    );
  }

  /// `Elevator card`
  String get elevator_card {
    return Intl.message(
      'Elevator card',
      name: 'elevator_card',
      desc: '',
      args: [],
    );
  }

  /// `Gym service`
  String get gym_card {
    return Intl.message(
      'Gym service',
      name: 'gym_card',
      desc: '',
      args: [],
    );
  }

  /// `Covenient service`
  String get covenient_service {
    return Intl.message(
      'Covenient service',
      name: 'covenient_service',
      desc: '',
      args: [],
    );
  }

  /// `Shopping represent`
  String get shopping_represent {
    return Intl.message(
      'Shopping represent',
      name: 'shopping_represent',
      desc: '',
      args: [],
    );
  }

  /// `Shopping online`
  String get shopping_online {
    return Intl.message(
      'Shopping online',
      name: 'shopping_online',
      desc: '',
      args: [],
    );
  }

  /// `Housework`
  String get housework {
    return Intl.message(
      'Housework',
      name: 'housework',
      desc: '',
      args: [],
    );
  }

  /// `Event`
  String get event {
    return Intl.message(
      'Event',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Residence news`
  String get residence_news {
    return Intl.message(
      'Residence news',
      name: 'residence_news',
      desc: '',
      args: [],
    );
  }

  /// `Follow events by date/month`
  String get event_msg {
    return Intl.message(
      'Follow events by date/month',
      name: 'event_msg',
      desc: '',
      args: [],
    );
  }

  /// `Refection`
  String get reflection {
    return Intl.message(
      'Refection',
      name: 'reflection',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Complain`
  String get complain {
    return Intl.message(
      'Complain',
      name: 'complain',
      desc: '',
      args: [],
    );
  }

  /// `Forum`
  String get forum {
    return Intl.message(
      'Forum',
      name: 'forum',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Register service history`
  String get his_reg_service {
    return Intl.message(
      'Register service history',
      name: 'his_reg_service',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Residence card`
  String get res_card {
    return Intl.message(
      'Residence card',
      name: 'res_card',
      desc: '',
      args: [],
    );
  }

  /// `Pet`
  String get pet {
    return Intl.message(
      'Pet',
      name: 'pet',
      desc: '',
      args: [],
    );
  }

  /// `Pool`
  String get pool {
    return Intl.message(
      'Pool',
      name: 'pool',
      desc: '',
      args: [],
    );
  }

  /// `How would you like to receive a code to reset your password?`
  String get way_send_otp {
    return Intl.message(
      'How would you like to receive a code to reset your password?',
      name: 'way_send_otp',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP to phone number`
  String get send_to_phone {
    return Intl.message(
      'Send OTP to phone number',
      name: 'send_to_phone',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP to email`
  String get send_to_email {
    return Intl.message(
      'Send OTP to email',
      name: 'send_to_email',
      desc: '',
      args: [],
    );
  }

  /// `Can not be empty`
  String get not_blank {
    return Intl.message(
      'Can not be empty',
      name: 'not_blank',
      desc: '',
      args: [],
    );
  }

  /// `Parcel`
  String get parcel {
    return Intl.message(
      'Parcel',
      name: 'parcel',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP reset password code to`
  String get send_otp_to {
    return Intl.message(
      'Send OTP reset password code to',
      name: 'send_otp_to',
      desc: '',
      args: [],
    );
  }

  /// `Register code`
  String get register_code {
    return Intl.message(
      'Register code',
      name: 'register_code',
      desc: '',
      args: [],
    );
  }

  /// `Card status`
  String get card_status {
    return Intl.message(
      'Card status',
      name: 'card_status',
      desc: '',
      args: [],
    );
  }

  /// `Letter status`
  String get letter_status {
    return Intl.message(
      'Letter status',
      name: 'letter_status',
      desc: '',
      args: [],
    );
  }

  /// `Card number`
  String get card_num {
    return Intl.message(
      'Card number',
      name: 'card_num',
      desc: '',
      args: [],
    );
  }

  /// `Apartment`
  String get apartment {
    return Intl.message(
      'Apartment',
      name: 'apartment',
      desc: '',
      args: [],
    );
  }

  /// `Send request`
  String get send_request {
    return Intl.message(
      'Send request',
      name: 'send_request',
      desc: '',
      args: [],
    );
  }

  /// `Delete letter`
  String get delete_letter {
    return Intl.message(
      'Delete letter',
      name: 'delete_letter',
      desc: '',
      args: [],
    );
  }

  /// `Cancel register`
  String get cancel_register {
    return Intl.message(
      'Cancel register',
      name: 'cancel_register',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Lock`
  String get lock {
    return Intl.message(
      'Lock',
      name: 'lock',
      desc: '',
      args: [],
    );
  }

  /// `Extend`
  String get extend {
    return Intl.message(
      'Extend',
      name: 'extend',
      desc: '',
      args: [],
    );
  }

  /// `Missing Report`
  String get missing_report {
    return Intl.message(
      'Missing Report',
      name: 'missing_report',
      desc: '',
      args: [],
    );
  }

  /// `Reject card`
  String get reject_card {
    return Intl.message(
      'Reject card',
      name: 'reject_card',
      desc: '',
      args: [],
    );
  }

  /// `Resident card register`
  String get res_card_register {
    return Intl.message(
      'Resident card register',
      name: 'res_card_register',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get photos {
    return Intl.message(
      'Photos',
      name: 'photos',
      desc: '',
      args: [],
    );
  }

  /// `Identity card/ passport photos (2 sides)`
  String get identity_photo {
    return Intl.message(
      'Identity card/ passport photos (2 sides)',
      name: 'identity_photo',
      desc: '',
      args: [],
    );
  }

  /// `Add photos`
  String get add_photo {
    return Intl.message(
      'Add photos',
      name: 'add_photo',
      desc: '',
      args: [],
    );
  }

  /// `Resident photos`
  String get res_photo {
    return Intl.message(
      'Resident photos',
      name: 'res_photo',
      desc: '',
      args: [],
    );
  }

  /// `Related document photos`
  String get related_doc_photo {
    return Intl.message(
      'Related document photos',
      name: 'related_doc_photo',
      desc: '',
      args: [],
    );
  }

  /// `Resident card details`
  String get res_card_details {
    return Intl.message(
      'Resident card details',
      name: 'res_card_details',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Timeline`
  String get history {
    return Intl.message(
      'Timeline',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get expired {
    return Intl.message(
      'Expired',
      name: 'expired',
      desc: '',
      args: [],
    );
  }

  /// `Reject_reason`
  String get cancel_reason {
    return Intl.message(
      'Reject_reason',
      name: 'cancel_reason',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `edit resident card`
  String get edit_res_card {
    return Intl.message(
      'edit resident card',
      name: 'edit_res_card',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message(
      'Approved',
      name: 'approved',
      desc: '',
      args: [],
    );
  }

  /// `Waiting approve`
  String get wait_approve {
    return Intl.message(
      'Waiting approve',
      name: 'wait_approve',
      desc: '',
      args: [],
    );
  }

  /// `Phone/ Email`
  String get phone_email {
    return Intl.message(
      'Phone/ Email',
      name: 'phone_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number or email`
  String get enter_phone_email {
    return Intl.message(
      'Enter phone number or email',
      name: 'enter_phone_email',
      desc: '',
      args: [],
    );
  }

  /// `Not found account Information`
  String get not_found_account {
    return Intl.message(
      'Not found account Information',
      name: 'not_found_account',
      desc: '',
      args: [],
    );
  }

  /// `We sent otp code to :{to}`
  String we_send_to(Object to) {
    return Intl.message(
      'We sent otp code to :$to',
      name: 'we_send_to',
      desc: '',
      args: [to],
    );
  }

  /// `Send OTP code successfully`
  String get success_opt {
    return Intl.message(
      'Send OTP code successfully',
      name: 'success_opt',
      desc: '',
      args: [],
    );
  }

  /// `OTP code is invalid`
  String get otp_invalid {
    return Intl.message(
      'OTP code is invalid',
      name: 'otp_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password successfully, please Sign in again`
  String get reset_pass_success {
    return Intl.message(
      'Reset Password successfully, please Sign in again',
      name: 'reset_pass_success',
      desc: '',
      args: [],
    );
  }

  /// `Please sign in again`
  String get re_sign_in {
    return Intl.message(
      'Please sign in again',
      name: 're_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign up successfully`
  String get success_sign_up {
    return Intl.message(
      'Sign up successfully',
      name: 'success_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `No have transportation card`
  String get no_trans_card {
    return Intl.message(
      'No have transportation card',
      name: 'no_trans_card',
      desc: '',
      args: [],
    );
  }

  /// `Resister new card`
  String get add_trans_card {
    return Intl.message(
      'Resister new card',
      name: 'add_trans_card',
      desc: '',
      args: [],
    );
  }

  /// `No have transportation letter`
  String get no_trans_letter {
    return Intl.message(
      'No have transportation letter',
      name: 'no_trans_letter',
      desc: '',
      args: [],
    );
  }

  /// `Transportation`
  String get transportation {
    return Intl.message(
      'Transportation',
      name: 'transportation',
      desc: '',
      args: [],
    );
  }

  /// `Licene plate`
  String get licene_plate {
    return Intl.message(
      'Licene plate',
      name: 'licene_plate',
      desc: '',
      args: [],
    );
  }

  /// `Lock card`
  String get lock_card {
    return Intl.message(
      'Lock card',
      name: 'lock_card',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get l_new {
    return Intl.message(
      'New',
      name: 'l_new',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete [{delete}]?`
  String confirm_delete_service(Object delete) {
    return Intl.message(
      'Do you want to delete [$delete]?',
      name: 'confirm_delete_service',
      desc: '',
      args: [delete],
    );
  }

  /// `Do you want to delete letter [{letter}]?`
  String confirm_delete_letter(Object letter) {
    return Intl.message(
      'Do you want to delete letter [$letter]?',
      name: 'confirm_delete_letter',
      desc: '',
      args: [letter],
    );
  }

  /// `Do you want to lock transportation card?`
  String get confirm_lock_trans_card {
    return Intl.message(
      'Do you want to lock transportation card?',
      name: 'confirm_lock_trans_card',
      desc: '',
      args: [],
    );
  }

  /// `Transportation letter`
  String get trans_letter {
    return Intl.message(
      'Transportation letter',
      name: 'trans_letter',
      desc: '',
      args: [],
    );
  }

  /// `Transportation letter`
  String get this_trans_letter {
    return Intl.message(
      'Transportation letter',
      name: 'this_trans_letter',
      desc: '',
      args: [],
    );
  }

  /// `Transportation card`
  String get trans_card {
    return Intl.message(
      'Transportation card',
      name: 'trans_card',
      desc: '',
      args: [],
    );
  }

  /// `Transportation card details`
  String get trans_card_details {
    return Intl.message(
      'Transportation card details',
      name: 'trans_card_details',
      desc: '',
      args: [],
    );
  }

  /// `Transportation registration card details`
  String get trans_reg_card_details {
    return Intl.message(
      'Transportation registration card details',
      name: 'trans_reg_card_details',
      desc: '',
      args: [],
    );
  }

  /// `Resident information`
  String get resident_info {
    return Intl.message(
      'Resident information',
      name: 'resident_info',
      desc: '',
      args: [],
    );
  }

  /// `Transportation information`
  String get trans_info {
    return Intl.message(
      'Transportation information',
      name: 'trans_info',
      desc: '',
      args: [],
    );
  }

  /// `Transportation type`
  String get trans_type {
    return Intl.message(
      'Transportation type',
      name: 'trans_type',
      desc: '',
      args: [],
    );
  }

  /// `Register number`
  String get reg_num {
    return Intl.message(
      'Register number',
      name: 'reg_num',
      desc: '',
      args: [],
    );
  }

  /// `Reject reason`
  String get reject_reason {
    return Intl.message(
      'Reject reason',
      name: 'reject_reason',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactive {
    return Intl.message(
      'Inactive',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `Register transportation card`
  String get register_trans_card {
    return Intl.message(
      'Register transportation card',
      name: 'register_trans_card',
      desc: '',
      args: [],
    );
  }

  /// `Register transportation card`
  String get edit_trans_card {
    return Intl.message(
      'Register transportation card',
      name: 'edit_trans_card',
      desc: '',
      args: [],
    );
  }

  /// `Register transportation photos (2 side)`
  String get reg_trans_photos {
    return Intl.message(
      'Register transportation photos (2 side)',
      name: 'reg_trans_photos',
      desc: '',
      args: [],
    );
  }

  /// `Related document photos`
  String get related_photo {
    return Intl.message(
      'Related document photos',
      name: 'related_photo',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `File selection`
  String get file_selection {
    return Intl.message(
      'File selection',
      name: 'file_selection',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied`
  String get permission_denied {
    return Intl.message(
      'Permission denied',
      name: 'permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission`
  String get permission_denied_msg {
    return Intl.message(
      'You don\'t have permission',
      name: 'permission_denied_msg',
      desc: '',
      args: [],
    );
  }

  /// `Add new successfully`
  String get success_cr_new {
    return Intl.message(
      'Add new successfully',
      name: 'success_cr_new',
      desc: '',
      args: [],
    );
  }

  /// `Send to approve request letter successfully`
  String get success_send_req {
    return Intl.message(
      'Send to approve request letter successfully',
      name: 'success_send_req',
      desc: '',
      args: [],
    );
  }

  /// `Edit successfully`
  String get success_edit {
    return Intl.message(
      'Edit successfully',
      name: 'success_edit',
      desc: '',
      args: [],
    );
  }

  /// `Remove successfully`
  String get success_remove {
    return Intl.message(
      'Remove successfully',
      name: 'success_remove',
      desc: '',
      args: [],
    );
  }

  /// `Lock card successfully`
  String get success_lock_card {
    return Intl.message(
      'Lock card successfully',
      name: 'success_lock_card',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to send to approve [{approved}]?`
  String confirm_send_request(Object approved) {
    return Intl.message(
      'Do you want to send to approve [$approved]?',
      name: 'confirm_send_request',
      desc: '',
      args: [approved],
    );
  }

  /// `Not empty front side photo`
  String get not_empty_front {
    return Intl.message(
      'Not empty front side photo',
      name: 'not_empty_front',
      desc: '',
      args: [],
    );
  }

  /// `Not empty back side photo`
  String get not_empty_back {
    return Intl.message(
      'Not empty back side photo',
      name: 'not_empty_back',
      desc: '',
      args: [],
    );
  }

  /// `Photo front size`
  String get photo_front_side {
    return Intl.message(
      'Photo front size',
      name: 'photo_front_side',
      desc: '',
      args: [],
    );
  }

  /// `Photo back size`
  String get photo_back_side {
    return Intl.message(
      'Photo back size',
      name: 'photo_back_side',
      desc: '',
      args: [],
    );
  }

  /// `Registration certificate`
  String get trans_cer {
    return Intl.message(
      'Registration certificate',
      name: 'trans_cer',
      desc: '',
      args: [],
    );
  }

  /// `Registration construction`
  String get reg_const {
    return Intl.message(
      'Registration construction',
      name: 'reg_const',
      desc: '',
      args: [],
    );
  }

  /// `Construction`
  String get construction {
    return Intl.message(
      'Construction',
      name: 'construction',
      desc: '',
      args: [],
    );
  }

  /// `Missing object`
  String get missing_obj {
    return Intl.message(
      'Missing object',
      name: 'missing_obj',
      desc: '',
      args: [],
    );
  }

  /// `Information reception`
  String get info_reception {
    return Intl.message(
      'Information reception',
      name: 'info_reception',
      desc: '',
      args: [],
    );
  }

  /// `Follow services`
  String get follow_ser {
    return Intl.message(
      'Follow services',
      name: 'follow_ser',
      desc: '',
      args: [],
    );
  }

  /// `Register delivery`
  String get reg_deliver {
    return Intl.message(
      'Register delivery',
      name: 'reg_deliver',
      desc: '',
      args: [],
    );
  }

  /// `Tranfer out`
  String get tranfer_out {
    return Intl.message(
      'Tranfer out',
      name: 'tranfer_out',
      desc: '',
      args: [],
    );
  }

  /// `Tranfer in`
  String get tranfer_in {
    return Intl.message(
      'Tranfer in',
      name: 'tranfer_in',
      desc: '',
      args: [],
    );
  }

  /// `Register tranfer out`
  String get tranfer_out_reg {
    return Intl.message(
      'Register tranfer out',
      name: 'tranfer_out_reg',
      desc: '',
      args: [],
    );
  }

  /// `Register tranfer in`
  String get tranfer_in_reg {
    return Intl.message(
      'Register tranfer in',
      name: 'tranfer_in_reg',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get start_time {
    return Intl.message(
      'Start time',
      name: 'start_time',
      desc: '',
      args: [],
    );
  }

  /// `End time`
  String get end_time {
    return Intl.message(
      'End time',
      name: 'end_time',
      desc: '',
      args: [],
    );
  }

  /// `Cancel register`
  String get cancel_reg {
    return Intl.message(
      'Cancel register',
      name: 'cancel_reg',
      desc: '',
      args: [],
    );
  }

  /// `Add package`
  String get add_package {
    return Intl.message(
      'Add package',
      name: 'add_package',
      desc: '',
      args: [],
    );
  }

  /// `Add package need transfer`
  String get add_package_need_transfer {
    return Intl.message(
      'Add package need transfer',
      name: 'add_package_need_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Package`
  String get package {
    return Intl.message(
      'Package',
      name: 'package',
      desc: '',
      args: [],
    );
  }

  /// `Package infomation`
  String get package_info {
    return Intl.message(
      'Package infomation',
      name: 'package_info',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get hour {
    return Intl.message(
      'Time',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Need protection support`
  String get need_support {
    return Intl.message(
      'Need protection support',
      name: 'need_support',
      desc: '',
      args: [],
    );
  }

  /// `Transfer list`
  String get transfer_list {
    return Intl.message(
      'Transfer list',
      name: 'transfer_list',
      desc: '',
      args: [],
    );
  }

  /// `Dimention`
  String get dimention {
    return Intl.message(
      'Dimention',
      name: 'dimention',
      desc: '',
      args: [],
    );
  }

  /// `Package Name`
  String get package_name {
    return Intl.message(
      'Package Name',
      name: 'package_name',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Transfer type`
  String get transfer_type {
    return Intl.message(
      'Transfer type',
      name: 'transfer_type',
      desc: '',
      args: [],
    );
  }

  /// `Tranfer information`
  String get delivery_info {
    return Intl.message(
      'Tranfer information',
      name: 'delivery_info',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any package`
  String get no_delivery {
    return Intl.message(
      'Don\'t have any package',
      name: 'no_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Length x width x elevation`
  String get l_w_e {
    return Intl.message(
      'Length x width x elevation',
      name: 'l_w_e',
      desc: '',
      args: [],
    );
  }

  /// `Edit register delivery`
  String get edit_reg_deliver {
    return Intl.message(
      'Edit register delivery',
      name: 'edit_reg_deliver',
      desc: '',
      args: [],
    );
  }

  /// `Item list can not be empty`
  String get item_list_not_empty {
    return Intl.message(
      'Item list can not be empty',
      name: 'item_list_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cancel request letter [{code}]`
  String confirm_cancel_request(Object code) {
    return Intl.message(
      'Do you want to cancel request letter [$code]',
      name: 'confirm_cancel_request',
      desc: '',
      args: [code],
    );
  }

  /// `Cancel letter successfully`
  String get success_can_req {
    return Intl.message(
      'Cancel letter successfully',
      name: 'success_can_req',
      desc: '',
      args: [],
    );
  }

  /// `Cancel letter`
  String get cancel_request {
    return Intl.message(
      'Cancel letter',
      name: 'cancel_request',
      desc: '',
      args: [],
    );
  }

  /// `Đăng ký thẻ cư dân`
  String get register_res_card {
    return Intl.message(
      'Đăng ký thẻ cư dân',
      name: 'register_res_card',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any card`
  String get no_card {
    return Intl.message(
      'Don\'t have any card',
      name: 'no_card',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any letter`
  String get no_letter {
    return Intl.message(
      'Don\'t have any letter',
      name: 'no_letter',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to lock card [{card}]?`
  String confirm_lock_card(Object card) {
    return Intl.message(
      'Do you want to lock card [$card]?',
      name: 'confirm_lock_card',
      desc: '',
      args: [card],
    );
  }

  /// `Home Community Smart Living`
  String get w {
    return Intl.message(
      'Home Community Smart Living',
      name: 'w',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle type can not be empty`
  String get not_empty_vehicle_type {
    return Intl.message(
      'Vehicle type can not be empty',
      name: 'not_empty_vehicle_type',
      desc: '',
      args: [],
    );
  }

  /// `Delivery_letter`
  String get delivery_letter {
    return Intl.message(
      'Delivery_letter',
      name: 'delivery_letter',
      desc: '',
      args: [],
    );
  }

  /// `Front side`
  String get front_side {
    return Intl.message(
      'Front side',
      name: 'front_side',
      desc: '',
      args: [],
    );
  }

  /// `Back side`
  String get back_side {
    return Intl.message(
      'Back side',
      name: 'back_side',
      desc: '',
      args: [],
    );
  }

  /// `Start date can not be empty`
  String get start_date_not_empty {
    return Intl.message(
      'Start date can not be empty',
      name: 'start_date_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `End date can not be empty`
  String get end_date_not_empty {
    return Intl.message(
      'End date can not be empty',
      name: 'end_date_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Start date can not be greater than now`
  String get start_date_after_now {
    return Intl.message(
      'Start date can not be greater than now',
      name: 'start_date_after_now',
      desc: '',
      args: [],
    );
  }

  /// `End date can not be less than now`
  String get end_date_after_now {
    return Intl.message(
      'End date can not be less than now',
      name: 'end_date_after_now',
      desc: '',
      args: [],
    );
  }

  /// `End date can not be less than start date`
  String get end_date_after_start_date {
    return Intl.message(
      'End date can not be less than start date',
      name: 'end_date_after_start_date',
      desc: '',
      args: [],
    );
  }

  /// `Package items can not be empty`
  String get package_items_not_empty {
    return Intl.message(
      'Package items can not be empty',
      name: 'package_items_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Letter code`
  String get letter_num {
    return Intl.message(
      'Letter code',
      name: 'letter_num',
      desc: '',
      args: [],
    );
  }

  /// `Can not contain Vietnamese letter`
  String get not_vietnamese {
    return Intl.message(
      'Can not contain Vietnamese letter',
      name: 'not_vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `Can not contain special symbol`
  String get not_special_char {
    return Intl.message(
      'Can not contain special symbol',
      name: 'not_special_char',
      desc: '',
      args: [],
    );
  }

  /// `Identity card front side image can not be empty`
  String get identity_front_not_empty {
    return Intl.message(
      'Identity card front side image can not be empty',
      name: 'identity_front_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Identity card back side image can not be empty`
  String get identity_back_not_empty {
    return Intl.message(
      'Identity card back side image can not be empty',
      name: 'identity_back_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Resident image can not empty`
  String get res_image_not_empty {
    return Intl.message(
      'Resident image can not empty',
      name: 'res_image_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Related document image can not empty`
  String get related_image_not_empty {
    return Intl.message(
      'Related document image can not empty',
      name: 'related_image_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Resgiter vehicle card front site  image can not be empty`
  String get resgiter_vehicle_front_image_not_empty {
    return Intl.message(
      'Resgiter vehicle card front site  image can not be empty',
      name: 'resgiter_vehicle_front_image_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Resgiter vehicle card back site  image can not be empty`
  String get resgiter_vehicle_back_image_not_empty {
    return Intl.message(
      'Resgiter vehicle card back site  image can not be empty',
      name: 'resgiter_vehicle_back_image_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Edit package`
  String get edit_package {
    return Intl.message(
      'Edit package',
      name: 'edit_package',
      desc: '',
      args: [],
    );
  }

  /// `Not enter only zero!`
  String get not_zero {
    return Intl.message(
      'Not enter only zero!',
      name: 'not_zero',
      desc: '',
      args: [],
    );
  }

  /// `Password length can not less than 8 letter`
  String get pass_min_length {
    return Intl.message(
      'Password length can not less than 8 letter',
      name: 'pass_min_length',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least 1 special character`
  String get pass_special {
    return Intl.message(
      'Password must contain at least 1 special character',
      name: 'pass_special',
      desc: '',
      args: [],
    );
  }

  /// `Not is email.`
  String get not_email {
    return Intl.message(
      'Not is email.',
      name: 'not_email',
      desc: '',
      args: [],
    );
  }

  /// `Search project`
  String get search_project {
    return Intl.message(
      'Search project',
      name: 'search_project',
      desc: '',
      args: [],
    );
  }

  /// `Not be dimention`
  String get not_dimention {
    return Intl.message(
      'Not be dimention',
      name: 'not_dimention',
      desc: '',
      args: [],
    );
  }

  /// `Service {service}`
  String service_name(Object service) {
    return Intl.message(
      'Service $service',
      name: 'service_name',
      desc: '',
      args: [service],
    );
  }

  /// `Registration code`
  String get reg_code {
    return Intl.message(
      'Registration code',
      name: 'reg_code',
      desc: '',
      args: [],
    );
  }

  /// `Payment circle`
  String get payment_circle {
    return Intl.message(
      'Payment circle',
      name: 'payment_circle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any service registration`
  String get no_service_regitration {
    return Intl.message(
      'Don\'t have any service registration',
      name: 'no_service_regitration',
      desc: '',
      args: [],
    );
  }

  /// `Registration date`
  String get reg_date {
    return Intl.message(
      'Registration date',
      name: 'reg_date',
      desc: '',
      args: [],
    );
  }

  /// `Expired_date`
  String get expired_date {
    return Intl.message(
      'Expired_date',
      name: 'expired_date',
      desc: '',
      args: [],
    );
  }

  /// `Registration service`
  String get reg_service {
    return Intl.message(
      'Registration service',
      name: 'reg_service',
      desc: '',
      args: [],
    );
  }

  /// `Registration service {nameser}`
  String reg_service_a(Object nameser) {
    return Intl.message(
      'Registration service $nameser',
      name: 'reg_service_a',
      desc: '',
      args: [nameser],
    );
  }

  /// `Edit registration service {nameser}`
  String edit_service_a(Object nameser) {
    return Intl.message(
      'Edit registration service $nameser',
      name: 'edit_service_a',
      desc: '',
      args: [nameser],
    );
  }

  /// `Maximum payment date`
  String get max_day_pay {
    return Intl.message(
      'Maximum payment date',
      name: 'max_day_pay',
      desc: '',
      args: [],
    );
  }

  /// `You need to choose payment cycle and register date first`
  String get need_choose_cylce_regdate {
    return Intl.message(
      'You need to choose payment cycle and register date first',
      name: 'need_choose_cylce_regdate',
      desc: '',
      args: [],
    );
  }

  /// `Payment circle can be not empty`
  String get payment_cycle_not_empty {
    return Intl.message(
      'Payment circle can be not empty',
      name: 'payment_cycle_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Registration date can be not empty`
  String get reg_day_not_empty {
    return Intl.message(
      'Registration date can be not empty',
      name: 'reg_day_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Can not upload file larger 15MB`
  String get not_upload_15mb {
    return Intl.message(
      'Can not upload file larger 15MB',
      name: 'not_upload_15mb',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Maximum payment date can not be empty`
  String get max_pay_day_not_empty {
    return Intl.message(
      'Maximum payment date can not be empty',
      name: 'max_pay_day_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Free service`
  String get free_service {
    return Intl.message(
      'Free service',
      name: 'free_service',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get project {
    return Intl.message(
      'Project',
      name: 'project',
      desc: '',
      args: [],
    );
  }

  /// `read`
  String get al_read {
    return Intl.message(
      'read',
      name: 'al_read',
      desc: '',
      args: [],
    );
  }

  /// `Unread`
  String get not_read {
    return Intl.message(
      'Unread',
      name: 'not_read',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any news`
  String get no_news {
    return Intl.message(
      'Don\'t have any news',
      name: 'no_news',
      desc: '',
      args: [],
    );
  }

  /// `Happenning`
  String get happening {
    return Intl.message(
      'Happenning',
      name: 'happening',
      desc: '',
      args: [],
    );
  }

  /// `Comming soon`
  String get coming_soon {
    return Intl.message(
      'Comming soon',
      name: 'coming_soon',
      desc: '',
      args: [],
    );
  }

  /// `Happened`
  String get happened {
    return Intl.message(
      'Happened',
      name: 'happened',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any event`
  String get no_event {
    return Intl.message(
      'Don\'t have any event',
      name: 'no_event',
      desc: '',
      args: [],
    );
  }

  /// `End registration time`
  String get end_time_reg {
    return Intl.message(
      'End registration time',
      name: 'end_time_reg',
      desc: '',
      args: [],
    );
  }

  /// `Time event happening`
  String get time_event_happening {
    return Intl.message(
      'Time event happening',
      name: 'time_event_happening',
      desc: '',
      args: [],
    );
  }

  /// `Details view`
  String get detail_view {
    return Intl.message(
      'Details view',
      name: 'detail_view',
      desc: '',
      args: [],
    );
  }

  /// `Participate`
  String get participate {
    return Intl.message(
      'Participate',
      name: 'participate',
      desc: '',
      args: [],
    );
  }

  /// `Time happening`
  String get time_happening {
    return Intl.message(
      'Time happening',
      name: 'time_happening',
      desc: '',
      args: [],
    );
  }

  /// `Happening location`
  String get happening_location {
    return Intl.message(
      'Happening location',
      name: 'happening_location',
      desc: '',
      args: [],
    );
  }

  /// `Confirm participate event`
  String get confirm_participate_event {
    return Intl.message(
      'Confirm participate event',
      name: 'confirm_participate_event',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to participate in [{eventName}]?`
  String confirm_par_ques_event(Object eventName) {
    return Intl.message(
      'Do you want to participate in [$eventName]?',
      name: 'confirm_par_ques_event',
      desc: '',
      args: [eventName],
    );
  }

  /// `Paticipate event [{eName}] successfully`
  String scuccess_participation(Object eName) {
    return Intl.message(
      'Paticipate event [$eName] successfully',
      name: 'scuccess_participation',
      desc: '',
      args: [eName],
    );
  }

  /// `Time registration`
  String get reg_time {
    return Intl.message(
      'Time registration',
      name: 'reg_time',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get pay {
    return Intl.message(
      'Payment',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid`
  String get unpaid {
    return Intl.message(
      'Unpaid',
      name: 'unpaid',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any bill`
  String get no_bill {
    return Intl.message(
      'Don\'t have any bill',
      name: 'no_bill',
      desc: '',
      args: [],
    );
  }

  /// `Registration day is not beefore now`
  String get reg_date_not_after_now {
    return Intl.message(
      'Registration day is not beefore now',
      name: 'reg_date_not_after_now',
      desc: '',
      args: [],
    );
  }

  /// `Water bill`
  String get water_bill {
    return Intl.message(
      'Water bill',
      name: 'water_bill',
      desc: '',
      args: [],
    );
  }

  /// `Electricity bill`
  String get elcetric_bill {
    return Intl.message(
      'Electricity bill',
      name: 'elcetric_bill',
      desc: '',
      args: [],
    );
  }

  /// `Parking bill`
  String get parking_bill {
    return Intl.message(
      'Parking bill',
      name: 'parking_bill',
      desc: '',
      args: [],
    );
  }

  /// `Other bill`
  String get other_bill {
    return Intl.message(
      'Other bill',
      name: 'other_bill',
      desc: '',
      args: [],
    );
  }

  /// `Service bill`
  String get service_bill {
    return Intl.message(
      'Service bill',
      name: 'service_bill',
      desc: '',
      args: [],
    );
  }

  /// `Apartment bill`
  String get apartment_bill {
    return Intl.message(
      'Apartment bill',
      name: 'apartment_bill',
      desc: '',
      args: [],
    );
  }

  /// `Due date`
  String get due_bill {
    return Intl.message(
      'Due date',
      name: 'due_bill',
      desc: '',
      args: [],
    );
  }

  /// `Bill details`
  String get bill_details {
    return Intl.message(
      'Bill details',
      name: 'bill_details',
      desc: '',
      args: [],
    );
  }

  /// `Bill name`
  String get bill_name {
    return Intl.message(
      'Bill name',
      name: 'bill_name',
      desc: '',
      args: [],
    );
  }

  /// `Bill code`
  String get bill_code {
    return Intl.message(
      'Bill code',
      name: 'bill_code',
      desc: '',
      args: [],
    );
  }

  /// `VAT`
  String get vat {
    return Intl.message(
      'VAT',
      name: 'vat',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Money`
  String get to_money {
    return Intl.message(
      'Money',
      name: 'to_money',
      desc: '',
      args: [],
    );
  }

  /// `Pay date`
  String get pay_date {
    return Intl.message(
      'Pay date',
      name: 'pay_date',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message(
      'Content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get payment_method {
    return Intl.message(
      'Payment method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Enter payment password`
  String get enter_payment_pass {
    return Intl.message(
      'Enter payment password',
      name: 'enter_payment_pass',
      desc: '',
      args: [],
    );
  }

  /// `Make payment for {p} successfully`
  String success_payment(Object p) {
    return Intl.message(
      'Make payment for $p successfully',
      name: 'success_payment',
      desc: '',
      args: [p],
    );
  }

  /// `Long`
  String get long {
    return Intl.message(
      'Long',
      name: 'long',
      desc: '',
      args: [],
    );
  }

  /// `Width`
  String get width {
    return Intl.message(
      'Width',
      name: 'width',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Take place time`
  String get take_place_time {
    return Intl.message(
      'Take place time',
      name: 'take_place_time',
      desc: '',
      args: [],
    );
  }

  /// `Total money`
  String get total_money {
    return Intl.message(
      'Total money',
      name: 'total_money',
      desc: '',
      args: [],
    );
  }

  /// `Waiting`
  String get wait_receipt {
    return Intl.message(
      'Waiting',
      name: 'wait_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Receipted`
  String get receipted {
    return Intl.message(
      'Receipted',
      name: 'receipted',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any parcel`
  String get no_parcel {
    return Intl.message(
      'Don\'t have any parcel',
      name: 'no_parcel',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Parcel code`
  String get parcel_code {
    return Intl.message(
      'Parcel code',
      name: 'parcel_code',
      desc: '',
      args: [],
    );
  }

  /// `Arrived date`
  String get arrived_date {
    return Intl.message(
      'Arrived date',
      name: 'arrived_date',
      desc: '',
      args: [],
    );
  }

  /// `Receipted date`
  String get receipt_date {
    return Intl.message(
      'Receipted date',
      name: 'receipt_date',
      desc: '',
      args: [],
    );
  }

  /// `Parcel details`
  String get parcel_details {
    return Intl.message(
      'Parcel details',
      name: 'parcel_details',
      desc: '',
      args: [],
    );
  }

  /// `Parcel informations`
  String get parcel_info {
    return Intl.message(
      'Parcel informations',
      name: 'parcel_info',
      desc: '',
      args: [],
    );
  }

  /// `Parcel name`
  String get parcel_name {
    return Intl.message(
      'Parcel name',
      name: 'parcel_name',
      desc: '',
      args: [],
    );
  }

  /// `Missing object`
  String get missing_object {
    return Intl.message(
      'Missing object',
      name: 'missing_object',
      desc: '',
      args: [],
    );
  }

  /// `Found object`
  String get found_object {
    return Intl.message(
      'Found object',
      name: 'found_object',
      desc: '',
      args: [],
    );
  }

  /// `History find object`
  String get history_find_obj {
    return Intl.message(
      'History find object',
      name: 'history_find_obj',
      desc: '',
      args: [],
    );
  }

  /// `Object details`
  String get object_details {
    return Intl.message(
      'Object details',
      name: 'object_details',
      desc: '',
      args: [],
    );
  }

  /// `Object information`
  String get object_info {
    return Intl.message(
      'Object information',
      name: 'object_info',
      desc: '',
      args: [],
    );
  }

  /// `Object code`
  String get object_code {
    return Intl.message(
      'Object code',
      name: 'object_code',
      desc: '',
      args: [],
    );
  }

  /// `Object name`
  String get object_name {
    return Intl.message(
      'Object name',
      name: 'object_name',
      desc: '',
      args: [],
    );
  }

  /// `Missing time`
  String get missing_time {
    return Intl.message(
      'Missing time',
      name: 'missing_time',
      desc: '',
      args: [],
    );
  }

  /// `Found place`
  String get found_place {
    return Intl.message(
      'Found place',
      name: 'found_place',
      desc: '',
      args: [],
    );
  }

  /// `Found time`
  String get found_time {
    return Intl.message(
      'Found time',
      name: 'found_time',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any missing object`
  String get no_missing_obj {
    return Intl.message(
      'Don\'t have any missing object',
      name: 'no_missing_obj',
      desc: '',
      args: [],
    );
  }

  /// `Register find missing object`
  String get reg_missing_obj {
    return Intl.message(
      'Register find missing object',
      name: 'reg_missing_obj',
      desc: '',
      args: [],
    );
  }

  /// `Wait to confirm`
  String get found {
    return Intl.message(
      'Wait to confirm',
      name: 'found',
      desc: '',
      args: [],
    );
  }

  /// `Found`
  String get i_found {
    return Intl.message(
      'Found',
      name: 'i_found',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message(
      'Confirmed',
      name: 'confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Returned`
  String get returned {
    return Intl.message(
      'Returned',
      name: 'returned',
      desc: '',
      args: [],
    );
  }

  /// `Send letter`
  String get send_letter {
    return Intl.message(
      'Send letter',
      name: 'send_letter',
      desc: '',
      args: [],
    );
  }

  /// `Wait return`
  String get wait_return {
    return Intl.message(
      'Wait return',
      name: 'wait_return',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any picked object`
  String get no_pick_obj {
    return Intl.message(
      'Don\'t have any picked object',
      name: 'no_pick_obj',
      desc: '',
      args: [],
    );
  }

  /// `Pet registration list`
  String get reg_pet_list {
    return Intl.message(
      'Pet registration list',
      name: 'reg_pet_list',
      desc: '',
      args: [],
    );
  }

  /// `Pet name`
  String get pet_name {
    return Intl.message(
      'Pet name',
      name: 'pet_name',
      desc: '',
      args: [],
    );
  }

  /// `Pet type`
  String get pet_type {
    return Intl.message(
      'Pet type',
      name: 'pet_type',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any pet registration`
  String get no_pet {
    return Intl.message(
      'Don\'t have any pet registration',
      name: 'no_pet',
      desc: '',
      args: [],
    );
  }

  /// `Pet origin`
  String get pet_origin {
    return Intl.message(
      'Pet origin',
      name: 'pet_origin',
      desc: '',
      args: [],
    );
  }

  /// `Sex`
  String get sex {
    return Intl.message(
      'Sex',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `Certification of rabies vaccination`
  String get cer_vacxin_doc {
    return Intl.message(
      'Certification of rabies vaccination',
      name: 'cer_vacxin_doc',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `I agree with`
  String get i_agree {
    return Intl.message(
      'I agree with',
      name: 'i_agree',
      desc: '',
      args: [],
    );
  }

  /// `regulations`
  String get regulations {
    return Intl.message(
      'regulations',
      name: 'regulations',
      desc: '',
      args: [],
    );
  }

  /// `of building management`
  String get of_building_management {
    return Intl.message(
      'of building management',
      name: 'of_building_management',
      desc: '',
      args: [],
    );
  }

  /// `registration pet infomation`
  String get reg_pet_info {
    return Intl.message(
      'registration pet infomation',
      name: 'reg_pet_info',
      desc: '',
      args: [],
    );
  }

  /// `Pet registration`
  String get reg_pet {
    return Intl.message(
      'Pet registration',
      name: 'reg_pet',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get pet_female {
    return Intl.message(
      'Female',
      name: 'pet_female',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get pet_male {
    return Intl.message(
      'Male',
      name: 'pet_male',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Dog`
  String get dog {
    return Intl.message(
      'Dog',
      name: 'dog',
      desc: '',
      args: [],
    );
  }

  /// `Cat`
  String get cat {
    return Intl.message(
      'Cat',
      name: 'cat',
      desc: '',
      args: [],
    );
  }

  /// `Edit registration pet`
  String get edit_reg_pet {
    return Intl.message(
      'Edit registration pet',
      name: 'edit_reg_pet',
      desc: '',
      args: [],
    );
  }

  /// `Pet information`
  String get pet_info {
    return Intl.message(
      'Pet information',
      name: 'pet_info',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Weight is not larger 15kg`
  String get weight_not_15 {
    return Intl.message(
      'Weight is not larger 15kg',
      name: 'weight_not_15',
      desc: '',
      args: [],
    );
  }

  /// `You need to agree to comply with the regulations on pet registration`
  String get pet_agree {
    return Intl.message(
      'You need to agree to comply with the regulations on pet registration',
      name: 'pet_agree',
      desc: '',
      args: [],
    );
  }

  /// `change status item successfully`
  String get success_returned {
    return Intl.message(
      'change status item successfully',
      name: 'success_returned',
      desc: '',
      args: [],
    );
  }

  /// `change status item successfully`
  String get success_find {
    return Intl.message(
      'change status item successfully',
      name: 'success_find',
      desc: '',
      args: [],
    );
  }

  /// `Lost time not after now day`
  String get lost_time_now {
    return Intl.message(
      'Lost time not after now day',
      name: 'lost_time_now',
      desc: '',
      args: [],
    );
  }

  /// `Found time not after now day`
  String get find_time_now {
    return Intl.message(
      'Found time not after now day',
      name: 'find_time_now',
      desc: '',
      args: [],
    );
  }

  /// `Invalid date`
  String get invalid_data {
    return Intl.message(
      'Invalid date',
      name: 'invalid_data',
      desc: '',
      args: [],
    );
  }

  /// `Send letter successfully`
  String get success_send_letter {
    return Intl.message(
      'Send letter successfully',
      name: 'success_send_letter',
      desc: '',
      args: [],
    );
  }

  /// `Certificate is not empty`
  String get certificate_not_empty {
    return Intl.message(
      'Certificate is not empty',
      name: 'certificate_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Report is not empty`
  String get report_not_empty {
    return Intl.message(
      'Report is not empty',
      name: 'report_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Construction list`
  String get cons_list {
    return Intl.message(
      'Construction list',
      name: 'cons_list',
      desc: '',
      args: [],
    );
  }

  /// `Construction registration`
  String get cons_reg {
    return Intl.message(
      'Construction registration',
      name: 'cons_reg',
      desc: '',
      args: [],
    );
  }

  /// `Construction file`
  String get cons_file {
    return Intl.message(
      'Construction file',
      name: 'cons_file',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any construction registration`
  String get no_reg_cons {
    return Intl.message(
      'Don\'t have any construction registration',
      name: 'no_reg_cons',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any construction file`
  String get no_cons_file {
    return Intl.message(
      'Don\'t have any construction file',
      name: 'no_cons_file',
      desc: '',
      args: [],
    );
  }

  /// `Construction code`
  String get cons_code {
    return Intl.message(
      'Construction code',
      name: 'cons_code',
      desc: '',
      args: [],
    );
  }

  /// `Construction fee`
  String get cons_fee {
    return Intl.message(
      'Construction fee',
      name: 'cons_fee',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get deposit {
    return Intl.message(
      'Deposit',
      name: 'deposit',
      desc: '',
      args: [],
    );
  }

  /// `Status letter`
  String get status_letter {
    return Intl.message(
      'Status letter',
      name: 'status_letter',
      desc: '',
      args: [],
    );
  }

  /// `Construction code`
  String get status_cons {
    return Intl.message(
      'Construction code',
      name: 'status_cons',
      desc: '',
      args: [],
    );
  }

  /// `File code`
  String get code_file {
    return Intl.message(
      'File code',
      name: 'code_file',
      desc: '',
      args: [],
    );
  }

  /// `Step 1`
  String get step1 {
    return Intl.message(
      'Step 1',
      name: 'step1',
      desc: '',
      args: [],
    );
  }

  /// `Step 2`
  String get step2 {
    return Intl.message(
      'Step 2',
      name: 'step2',
      desc: '',
      args: [],
    );
  }

  /// `Step 3`
  String get step3 {
    return Intl.message(
      'Step 3',
      name: 'step3',
      desc: '',
      args: [],
    );
  }

  /// `Construction information`
  String get cons_info {
    return Intl.message(
      'Construction information',
      name: 'cons_info',
      desc: '',
      args: [],
    );
  }

  /// `deposit paid`
  String get paid_deposit {
    return Intl.message(
      'deposit paid',
      name: 'paid_deposit',
      desc: '',
      args: [],
    );
  }

  /// `Construction day`
  String get cons_day {
    return Intl.message(
      'Construction day',
      name: 'cons_day',
      desc: '',
      args: [],
    );
  }

  /// `Off day`
  String get off_day {
    return Intl.message(
      'Off day',
      name: 'off_day',
      desc: '',
      args: [],
    );
  }

  /// `Work description`
  String get work_description {
    return Intl.message(
      'Work description',
      name: 'work_description',
      desc: '',
      args: [],
    );
  }

  /// `The limit for each upload file does not exceed 15MB`
  String get limit_15mb {
    return Intl.message(
      'The limit for each upload file does not exceed 15MB',
      name: 'limit_15mb',
      desc: '',
      args: [],
    );
  }

  /// `I confirm that I will comply with the regulations on construction and will compensate for all losses, complaints, costs incurred from this construction and repair work.See more`
  String get i_confirm {
    return Intl.message(
      'I confirm that I will comply with the regulations on construction and will compensate for all losses, complaints, costs incurred from this construction and repair work.See more',
      name: 'i_confirm',
      desc: '',
      args: [],
    );
  }

  /// `tại đây`
  String get here {
    return Intl.message(
      'tại đây',
      name: 'here',
      desc: '',
      args: [],
    );
  }

  /// `Construction drawing`
  String get cons_drawing {
    return Intl.message(
      'Construction drawing',
      name: 'cons_drawing',
      desc: '',
      args: [],
    );
  }

  /// `Existing drawing`
  String get exist_drawing {
    return Intl.message(
      'Existing drawing',
      name: 'exist_drawing',
      desc: '',
      args: [],
    );
  }

  /// `Renewal drawing`
  String get renewal_drawing {
    return Intl.message(
      'Renewal drawing',
      name: 'renewal_drawing',
      desc: '',
      args: [],
    );
  }

  /// `Violation record`
  String get violation_record {
    return Intl.message(
      'Violation record',
      name: 'violation_record',
      desc: '',
      args: [],
    );
  }

  /// `View record`
  String get view_record {
    return Intl.message(
      'View record',
      name: 'view_record',
      desc: '',
      args: [],
    );
  }

  /// `Construction registration letter`
  String get cons_reg_letter {
    return Intl.message(
      'Construction registration letter',
      name: 'cons_reg_letter',
      desc: '',
      args: [],
    );
  }

  /// `Start date`
  String get start_date {
    return Intl.message(
      'Start date',
      name: 'start_date',
      desc: '',
      args: [],
    );
  }

  /// `End date`
  String get end_date {
    return Intl.message(
      'End date',
      name: 'end_date',
      desc: '',
      args: [],
    );
  }

  /// `Approved date`
  String get approved_date {
    return Intl.message(
      'Approved date',
      name: 'approved_date',
      desc: '',
      args: [],
    );
  }

  /// `File status`
  String get file_status {
    return Intl.message(
      'File status',
      name: 'file_status',
      desc: '',
      args: [],
    );
  }

  /// `File information`
  String get file_info {
    return Intl.message(
      'File information',
      name: 'file_info',
      desc: '',
      args: [],
    );
  }

  /// `Plan`
  String get surface {
    return Intl.message(
      'Plan',
      name: 'surface',
      desc: '',
      args: [],
    );
  }

  /// `Construction type`
  String get cons_type {
    return Intl.message(
      'Construction type',
      name: 'cons_type',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Construction registration details`
  String get cons_reg_detail {
    return Intl.message(
      'Construction registration details',
      name: 'cons_reg_detail',
      desc: '',
      args: [],
    );
  }

  /// `Worker amount`
  String get worker_num {
    return Intl.message(
      'Worker amount',
      name: 'worker_num',
      desc: '',
      args: [],
    );
  }

  /// `Construction regulation`
  String get cons_regulation {
    return Intl.message(
      'Construction regulation',
      name: 'cons_regulation',
      desc: '',
      args: [],
    );
  }

  /// `Construction unit`
  String get cons_unit {
    return Intl.message(
      'Construction unit',
      name: 'cons_unit',
      desc: '',
      args: [],
    );
  }

  /// `Construction unit information`
  String get cons_unit_info {
    return Intl.message(
      'Construction unit information',
      name: 'cons_unit_info',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Deputy`
  String get deputy {
    return Intl.message(
      'Deputy',
      name: 'deputy',
      desc: '',
      args: [],
    );
  }

  /// `Phone of deputy`
  String get deputy_phone {
    return Intl.message(
      'Phone of deputy',
      name: 'deputy_phone',
      desc: '',
      args: [],
    );
  }

  /// `CMND/ CCCD/ Passport`
  String get cmnd {
    return Intl.message(
      'CMND/ CCCD/ Passport',
      name: 'cmnd',
      desc: '',
      args: [],
    );
  }

  /// `Construction document details`
  String get cons_file_details {
    return Intl.message(
      'Construction document details',
      name: 'cons_file_details',
      desc: '',
      args: [],
    );
  }

  /// `Document code`
  String get file_code {
    return Intl.message(
      'Document code',
      name: 'file_code',
      desc: '',
      args: [],
    );
  }

  /// `Login session is invalid, please sign in again`
  String get expired_login {
    return Intl.message(
      'Login session is invalid, please sign in again',
      name: 'expired_login',
      desc: '',
      args: [],
    );
  }

  /// `Pet regulation`
  String get pet_regulation {
    return Intl.message(
      'Pet regulation',
      name: 'pet_regulation',
      desc: '',
      args: [],
    );
  }

  /// `Select surface`
  String get select_surface {
    return Intl.message(
      'Select surface',
      name: 'select_surface',
      desc: '',
      args: [],
    );
  }

  /// `Select construction type`
  String get select_cons_type {
    return Intl.message(
      'Select construction type',
      name: 'select_cons_type',
      desc: '',
      args: [],
    );
  }

  /// `Fee paid`
  String get fee_paid {
    return Intl.message(
      'Fee paid',
      name: 'fee_paid',
      desc: '',
      args: [],
    );
  }

  /// `Enter construction uint name`
  String get enter_cons_unit_name {
    return Intl.message(
      'Enter construction uint name',
      name: 'enter_cons_unit_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter address`
  String get enter_address {
    return Intl.message(
      'Enter address',
      name: 'enter_address',
      desc: '',
      args: [],
    );
  }

  /// `Enter worker amount`
  String get enter_worker_num {
    return Intl.message(
      'Enter worker amount',
      name: 'enter_worker_num',
      desc: '',
      args: [],
    );
  }

  /// `Enter identity`
  String get enter_identity {
    return Intl.message(
      'Enter identity',
      name: 'enter_identity',
      desc: '',
      args: [],
    );
  }

  /// `Enter deputy name`
  String get enter_deputy_name {
    return Intl.message(
      'Enter deputy name',
      name: 'enter_deputy_name',
      desc: '',
      args: [],
    );
  }

  /// `Add file`
  String get add_file {
    return Intl.message(
      'Add file',
      name: 'add_file',
      desc: '',
      args: [],
    );
  }

  /// `Existed drawing can not be empty`
  String get existed_drawing_not_empty {
    return Intl.message(
      'Existed drawing can not be empty',
      name: 'existed_drawing_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Renew drawing can not be empty`
  String get renew_drawing_not_empty {
    return Intl.message(
      'Renew drawing can not be empty',
      name: 'renew_drawing_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `You need to agree to comply with the regulations on construction registration`
  String get cons_agree {
    return Intl.message(
      'You need to agree to comply with the regulations on construction registration',
      name: 'cons_agree',
      desc: '',
      args: [],
    );
  }

  /// `Start date must be greater than now`
  String get start_date_after_now_equal {
    return Intl.message(
      'Start date must be greater than now',
      name: 'start_date_after_now_equal',
      desc: '',
      args: [],
    );
  }

  /// `Weight can not be zero`
  String get weight_not_zero {
    return Intl.message(
      'Weight can not be zero',
      name: 'weight_not_zero',
      desc: '',
      args: [],
    );
  }

  /// `Upload file is not supported`
  String get file_not_support {
    return Intl.message(
      'Upload file is not supported',
      name: 'file_not_support',
      desc: '',
      args: [],
    );
  }

  /// `Found`
  String get success_found {
    return Intl.message(
      'Found',
      name: 'success_found',
      desc: '',
      args: [],
    );
  }

  /// `Image can not be empty`
  String get image_not_empty {
    return Intl.message(
      'Image can not be empty',
      name: 'image_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `You can only upload file jpeg, jpg, png, pdf, doc, docx, xls, xlsx`
  String get pick_file_error {
    return Intl.message(
      'You can only upload file jpeg, jpg, png, pdf, doc, docx, xls, xlsx',
      name: 'pick_file_error',
      desc: '',
      args: [],
    );
  }

  /// `You can only upload file jpeg, jpg, png`
  String get pick_image_error {
    return Intl.message(
      'You can only upload file jpeg, jpg, png',
      name: 'pick_image_error',
      desc: '',
      args: [],
    );
  }

  /// `Edit construction regitration`
  String get edit_reg_const {
    return Intl.message(
      'Edit construction regitration',
      name: 'edit_reg_const',
      desc: '',
      args: [],
    );
  }

  /// `Violation records`
  String get violation_records {
    return Intl.message(
      'Violation records',
      name: 'violation_records',
      desc: '',
      args: [],
    );
  }

  /// `View records`
  String get vew_records {
    return Intl.message(
      'View records',
      name: 'vew_records',
      desc: '',
      args: [],
    );
  }

  /// `Not found`
  String get not_found {
    return Intl.message(
      'Not found',
      name: 'not_found',
      desc: '',
      args: [],
    );
  }

  /// `Wait to find`
  String get wait_find {
    return Intl.message(
      'Wait to find',
      name: 'wait_find',
      desc: '',
      args: [],
    );
  }

  /// `Pull to load`
  String get pull_to_load {
    return Intl.message(
      'Pull to load',
      name: 'pull_to_load',
      desc: '',
      args: [],
    );
  }

  /// `Load Failed!Click retry!`
  String get pull_load_failed {
    return Intl.message(
      'Load Failed!Click retry!',
      name: 'pull_load_failed',
      desc: '',
      args: [],
    );
  }

  /// `Release to load more`
  String get release_to_load {
    return Intl.message(
      'Release to load more',
      name: 'release_to_load',
      desc: '',
      args: [],
    );
  }

  /// `No more data`
  String get no_more_data {
    return Intl.message(
      'No more data',
      name: 'no_more_data',
      desc: '',
      args: [],
    );
  }

  /// `Discount type`
  String get discount_type {
    return Intl.message(
      'Discount type',
      name: 'discount_type',
      desc: '',
      args: [],
    );
  }

  /// `Percent`
  String get percent {
    return Intl.message(
      'Percent',
      name: 'percent',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get value {
    return Intl.message(
      'Value',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Event_notification`
  String get event_notification {
    return Intl.message(
      'Event_notification',
      name: 'event_notification',
      desc: '',
      args: [],
    );
  }

  /// `System_notification`
  String get system_notification {
    return Intl.message(
      'System_notification',
      name: 'system_notification',
      desc: '',
      args: [],
    );
  }

  /// `Service_reflection`
  String get service_reflection {
    return Intl.message(
      'Service_reflection',
      name: 'service_reflection',
      desc: '',
      args: [],
    );
  }

  /// `Birthday Congratulaion`
  String get birthday_congratulaion {
    return Intl.message(
      'Birthday Congratulaion',
      name: 'birthday_congratulaion',
      desc: '',
      args: [],
    );
  }

  /// `New resident`
  String get new_resident {
    return Intl.message(
      'New resident',
      name: 'new_resident',
      desc: '',
      args: [],
    );
  }

  /// `Notification type`
  String get notification_type {
    return Intl.message(
      'Notification type',
      name: 'notification_type',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any notification`
  String get no_notification {
    return Intl.message(
      'Don\'t have any notification',
      name: 'no_notification',
      desc: '',
      args: [],
    );
  }

  /// `General notification`
  String get general_notification {
    return Intl.message(
      'General notification',
      name: 'general_notification',
      desc: '',
      args: [],
    );
  }

  /// `Payment, debt remind`
  String get debt {
    return Intl.message(
      'Payment, debt remind',
      name: 'debt',
      desc: '',
      args: [],
    );
  }

  /// `Hand over`
  String get hand_over {
    return Intl.message(
      'Hand over',
      name: 'hand_over',
      desc: '',
      args: [],
    );
  }

  /// `Wait execute`
  String get wait_execute {
    return Intl.message(
      'Wait execute',
      name: 'wait_execute',
      desc: '',
      args: [],
    );
  }

  /// `Executing`
  String get executed {
    return Intl.message(
      'Executing',
      name: 'executed',
      desc: '',
      args: [],
    );
  }

  /// `No hand over`
  String get no_hand_over {
    return Intl.message(
      'No hand over',
      name: 'no_hand_over',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get booking {
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Booking hand over`
  String get booking_hand_over {
    return Intl.message(
      'Booking hand over',
      name: 'booking_hand_over',
      desc: '',
      args: [],
    );
  }

  /// `Schedual booking hand over`
  String get booking_hand_over_0 {
    return Intl.message(
      'Schedual booking hand over',
      name: 'booking_hand_over_0',
      desc: '',
      args: [],
    );
  }

  /// `Booking history`
  String get booking_his {
    return Intl.message(
      'Booking history',
      name: 'booking_his',
      desc: '',
      args: [],
    );
  }

  /// `Hand over date`
  String get hand_date {
    return Intl.message(
      'Hand over date',
      name: 'hand_date',
      desc: '',
      args: [],
    );
  }

  /// `Hand over time`
  String get hand_time {
    return Intl.message(
      'Hand over time',
      name: 'hand_time',
      desc: '',
      args: [],
    );
  }

  /// `Hand over date`
  String get hand_over_date {
    return Intl.message(
      'Hand over date',
      name: 'hand_over_date',
      desc: '',
      args: [],
    );
  }

  /// `Hand over time`
  String get hand_over_time {
    return Intl.message(
      'Hand over time',
      name: 'hand_over_time',
      desc: '',
      args: [],
    );
  }

  /// `Hand over employee`
  String get hand_over_employee {
    return Intl.message(
      'Hand over employee',
      name: 'hand_over_employee',
      desc: '',
      args: [],
    );
  }

  /// `General information`
  String get general_info {
    return Intl.message(
      'General information',
      name: 'general_info',
      desc: '',
      args: [],
    );
  }

  /// `Hand over asset list`
  String get hand_over_asset_list {
    return Intl.message(
      'Hand over asset list',
      name: 'hand_over_asset_list',
      desc: '',
      args: [],
    );
  }

  /// `Not pass reason`
  String get not_pass_reason {
    return Intl.message(
      'Not pass reason',
      name: 'not_pass_reason',
      desc: '',
      args: [],
    );
  }

  /// `Asset name`
  String get asset_name {
    return Intl.message(
      'Asset name',
      name: 'asset_name',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `Material`
  String get material {
    return Intl.message(
      'Material',
      name: 'material',
      desc: '',
      args: [],
    );
  }

  /// `Pass`
  String get pass {
    return Intl.message(
      'Pass',
      name: 'pass',
      desc: '',
      args: [],
    );
  }

  /// `Not pass`
  String get not_pass {
    return Intl.message(
      'Not pass',
      name: 'not_pass',
      desc: '',
      args: [],
    );
  }

  /// `Accept hand over`
  String get accept_hand_over {
    return Intl.message(
      'Accept hand over',
      name: 'accept_hand_over',
      desc: '',
      args: [],
    );
  }

  /// `Hand over list has {numAsset} assets not pass`
  String not_pass_list(Object numAsset) {
    return Intl.message(
      'Hand over list has $numAsset assets not pass',
      name: 'not_pass_list',
      desc: '',
      args: [numAsset],
    );
  }

  /// `Are you sure accept to hand over.`
  String get confirm_hand_over {
    return Intl.message(
      'Are you sure accept to hand over.',
      name: 'confirm_hand_over',
      desc: '',
      args: [],
    );
  }

  /// `Assets was handed over fully`
  String get pass_list {
    return Intl.message(
      'Assets was handed over fully',
      name: 'pass_list',
      desc: '',
      args: [],
    );
  }

  /// `Asset list`
  String get asset_list {
    return Intl.message(
      'Asset list',
      name: 'asset_list',
      desc: '',
      args: [],
    );
  }

  /// `Material list`
  String get material_list {
    return Intl.message(
      'Material list',
      name: 'material_list',
      desc: '',
      args: [],
    );
  }

  /// `Need to pay`
  String get need_pay {
    return Intl.message(
      'Need to pay',
      name: 'need_pay',
      desc: '',
      args: [],
    );
  }

  /// `Payment paid`
  String get paid_payment {
    return Intl.message(
      'Payment paid',
      name: 'paid_payment',
      desc: '',
      args: [],
    );
  }

  /// `Inprocess hand over`
  String get handing_over {
    return Intl.message(
      'Inprocess hand over',
      name: 'handing_over',
      desc: '',
      args: [],
    );
  }

  /// `Wait to hand over`
  String get wait_hand_over {
    return Intl.message(
      'Wait to hand over',
      name: 'wait_hand_over',
      desc: '',
      args: [],
    );
  }

  /// `Handed over`
  String get handed_over {
    return Intl.message(
      'Handed over',
      name: 'handed_over',
      desc: '',
      args: [],
    );
  }

  /// `Re book`
  String get re_book {
    return Intl.message(
      'Re book',
      name: 're_book',
      desc: '',
      args: [],
    );
  }

  /// `Asset details`
  String get asset_details {
    return Intl.message(
      'Asset details',
      name: 'asset_details',
      desc: '',
      args: [],
    );
  }

  /// `Material details`
  String get material_details {
    return Intl.message(
      'Material details',
      name: 'material_details',
      desc: '',
      args: [],
    );
  }

  /// `Customer care`
  String get customer_care {
    return Intl.message(
      'Customer care',
      name: 'customer_care',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get error {
    return Intl.message(
      'Something went wrong',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Total bill`
  String get total_bill {
    return Intl.message(
      'Total bill',
      name: 'total_bill',
      desc: '',
      args: [],
    );
  }

  /// `Total payment`
  String get total_pay {
    return Intl.message(
      'Total payment',
      name: 'total_pay',
      desc: '',
      args: [],
    );
  }

  /// `File is downloading`
  String get file_downloading {
    return Intl.message(
      'File is downloading',
      name: 'file_downloading',
      desc: '',
      args: [],
    );
  }

  /// `Start conversation!`
  String get start_chat {
    return Intl.message(
      'Start conversation!',
      name: 'start_chat',
      desc: '',
      args: [],
    );
  }

  /// `End conversation!`
  String get end_chat {
    return Intl.message(
      'End conversation!',
      name: 'end_chat',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to end this conversation.`
  String get confirm_end_chat {
    return Intl.message(
      'Do you want to end this conversation.',
      name: 'confirm_end_chat',
      desc: '',
      args: [],
    );
  }

  /// `Reflection`
  String get reflex {
    return Intl.message(
      'Reflection',
      name: 'reflex',
      desc: '',
      args: [],
    );
  }

  /// `Resident registration`
  String get resident_reg {
    return Intl.message(
      'Resident registration',
      name: 'resident_reg',
      desc: '',
      args: [],
    );
  }

  /// `Executing`
  String get executing {
    return Intl.message(
      'Executing',
      name: 'executing',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newl {
    return Intl.message(
      'New',
      name: 'newl',
      desc: '',
      args: [],
    );
  }

  /// `No have any feedback`
  String get no_reflection {
    return Intl.message(
      'No have any feedback',
      name: 'no_reflection',
      desc: '',
      args: [],
    );
  }

  /// `Created date`
  String get created_date {
    return Intl.message(
      'Created date',
      name: 'created_date',
      desc: '',
      args: [],
    );
  }

  /// `Create feedback`
  String get add_reflection {
    return Intl.message(
      'Create feedback',
      name: 'add_reflection',
      desc: '',
      args: [],
    );
  }

  /// `Reflection reason`
  String get reflection_reason {
    return Intl.message(
      'Reflection reason',
      name: 'reflection_reason',
      desc: '',
      args: [],
    );
  }

  /// `Complain reason`
  String get complain_reason {
    return Intl.message(
      'Complain reason',
      name: 'complain_reason',
      desc: '',
      args: [],
    );
  }

  /// `Send feedback `
  String get send_reflection {
    return Intl.message(
      'Send feedback ',
      name: 'send_reflection',
      desc: '',
      args: [],
    );
  }

  /// `reflection reason can't not be empty`
  String get reflection_reason_not_empty {
    return Intl.message(
      'reflection reason can\'t not be empty',
      name: 'reflection_reason_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Letter infomation`
  String get letter_info {
    return Intl.message(
      'Letter infomation',
      name: 'letter_info',
      desc: '',
      args: [],
    );
  }

  /// `Send date`
  String get date_send {
    return Intl.message(
      'Send date',
      name: 'date_send',
      desc: '',
      args: [],
    );
  }

  /// `Processing result`
  String get processing_result {
    return Intl.message(
      'Processing result',
      name: 'processing_result',
      desc: '',
      args: [],
    );
  }

  /// `Processing Content`
  String get processing_content {
    return Intl.message(
      'Processing Content',
      name: 'processing_content',
      desc: '',
      args: [],
    );
  }

  /// `Reflection type`
  String get reflection_type {
    return Intl.message(
      'Reflection type',
      name: 'reflection_type',
      desc: '',
      args: [],
    );
  }

  /// `Reflection details`
  String get reflection_details {
    return Intl.message(
      'Reflection details',
      name: 'reflection_details',
      desc: '',
      args: [],
    );
  }

  /// `Zone`
  String get zone {
    return Intl.message(
      'Zone',
      name: 'zone',
      desc: '',
      args: [],
    );
  }

  /// `Zone type`
  String get zone_type {
    return Intl.message(
      'Zone type',
      name: 'zone_type',
      desc: '',
      args: [],
    );
  }

  /// `Resident reaction`
  String get res_reaction {
    return Intl.message(
      'Resident reaction',
      name: 'res_reaction',
      desc: '',
      args: [],
    );
  }

  /// `Add new reflection successfully`
  String get success_add_ticket {
    return Intl.message(
      'Add new reflection successfully',
      name: 'success_add_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Send reflection successfully`
  String get success_send_ticket {
    return Intl.message(
      'Send reflection successfully',
      name: 'success_send_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Pin`
  String get pin {
    return Intl.message(
      'Pin',
      name: 'pin',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get building {
    return Intl.message(
      'Building',
      name: 'building',
      desc: '',
      args: [],
    );
  }

  /// `Attachment file`
  String get attachment_file {
    return Intl.message(
      'Attachment file',
      name: 'attachment_file',
      desc: '',
      args: [],
    );
  }

  /// `Cancel reflection`
  String get cancel_reflection {
    return Intl.message(
      'Cancel reflection',
      name: 'cancel_reflection',
      desc: '',
      args: [],
    );
  }

  /// `Accepted successfully`
  String get success_accept {
    return Intl.message(
      'Accepted successfully',
      name: 'success_accept',
      desc: '',
      args: [],
    );
  }

  /// `Add dependent person `
  String get add_dependent_person {
    return Intl.message(
      'Add dependent person ',
      name: 'add_dependent_person',
      desc: '',
      args: [],
    );
  }

  /// `Relationship with owner`
  String get relation_with_owner {
    return Intl.message(
      'Relationship with owner',
      name: 'relation_with_owner',
      desc: '',
      args: [],
    );
  }

  /// `Register code`
  String get red_code {
    return Intl.message(
      'Register code',
      name: 'red_code',
      desc: '',
      args: [],
    );
  }

  /// `Existed dependent person`
  String get dependence_has_info {
    return Intl.message(
      'Existed dependent person',
      name: 'dependence_has_info',
      desc: '',
      args: [],
    );
  }

  /// `Non-Existed dependent person`
  String get dependence_not_info {
    return Intl.message(
      'Non-Existed dependent person',
      name: 'dependence_not_info',
      desc: '',
      args: [],
    );
  }

  /// `Dependent apartment`
  String get dependent_apartment {
    return Intl.message(
      'Dependent apartment',
      name: 'dependent_apartment',
      desc: '',
      args: [],
    );
  }

  /// `Dependent person`
  String get dependent_person {
    return Intl.message(
      'Dependent person',
      name: 'dependent_person',
      desc: '',
      args: [],
    );
  }

  /// `You has already add {person} into apartment {build}. Please wait management's approval`
  String success_add_dependence(Object person, Object build) {
    return Intl.message(
      'You has already add $person into apartment $build. Please wait management\'s approval',
      name: 'success_add_dependence',
      desc: '',
      args: [person, build],
    );
  }

  /// `General information`
  String get base_info {
    return Intl.message(
      'General information',
      name: 'base_info',
      desc: '',
      args: [],
    );
  }

  /// `Other information`
  String get other_info {
    return Intl.message(
      'Other information',
      name: 'other_info',
      desc: '',
      args: [],
    );
  }

  /// `Add residence apartment`
  String get apartment_add_resident {
    return Intl.message(
      'Add residence apartment',
      name: 'apartment_add_resident',
      desc: '',
      args: [],
    );
  }

  /// `Issue place`
  String get place_issue {
    return Intl.message(
      'Issue place',
      name: 'place_issue',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Resident address`
  String get resident_address {
    return Intl.message(
      'Resident address',
      name: 'resident_address',
      desc: '',
      args: [],
    );
  }

  /// `Province/City`
  String get prov_city {
    return Intl.message(
      'Province/City',
      name: 'prov_city',
      desc: '',
      args: [],
    );
  }

  /// `Distric/ward`
  String get ward {
    return Intl.message(
      'Distric/ward',
      name: 'ward',
      desc: '',
      args: [],
    );
  }

  /// `Education level`
  String get education_level {
    return Intl.message(
      'Education level',
      name: 'education_level',
      desc: '',
      args: [],
    );
  }

  /// `Link personal social media`
  String get social_media {
    return Intl.message(
      'Link personal social media',
      name: 'social_media',
      desc: '',
      args: [],
    );
  }

  /// `Job`
  String get job {
    return Intl.message(
      'Job',
      name: 'job',
      desc: '',
      args: [],
    );
  }

  /// `Ethnic`
  String get ethnic {
    return Intl.message(
      'Ethnic',
      name: 'ethnic',
      desc: '',
      args: [],
    );
  }

  /// `Resident type`
  String get resident_type {
    return Intl.message(
      'Resident type',
      name: 'resident_type',
      desc: '',
      args: [],
    );
  }

  /// `Lost time`
  String get lost_time {
    return Intl.message(
      'Lost time',
      name: 'lost_time',
      desc: '',
      args: [],
    );
  }

  /// `Success confirm`
  String get success_confirm {
    return Intl.message(
      'Success confirm',
      name: 'success_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Returned images`
  String get return_image {
    return Intl.message(
      'Returned images',
      name: 'return_image',
      desc: '',
      args: [],
    );
  }

  /// `Use elevator`
  String get use_elevator {
    return Intl.message(
      'Use elevator',
      name: 'use_elevator',
      desc: '',
      args: [],
    );
  }

  /// `Pet images`
  String get pet_images {
    return Intl.message(
      'Pet images',
      name: 'pet_images',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bill {
    return Intl.message(
      'Bill',
      name: 'bill',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dob {
    return Intl.message(
      'Date of birth',
      name: 'dob',
      desc: '',
      args: [],
    );
  }

  /// `block /village`
  String get block {
    return Intl.message(
      'block /village',
      name: 'block',
      desc: '',
      args: [],
    );
  }

  /// `Additional file`
  String get additional_file {
    return Intl.message(
      'Additional file',
      name: 'additional_file',
      desc: '',
      args: [],
    );
  }

  /// `Pet image can not be empty`
  String get pet_image_not_empty {
    return Intl.message(
      'Pet image can not be empty',
      name: 'pet_image_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Phone nunmber length can not less than 10 character`
  String get phone_less_10 {
    return Intl.message(
      'Phone nunmber length can not less than 10 character',
      name: 'phone_less_10',
      desc: '',
      args: [],
    );
  }

  /// `Edit reflection`
  String get edit_reflection {
    return Intl.message(
      'Edit reflection',
      name: 'edit_reflection',
      desc: '',
      args: [],
    );
  }

  /// `Update reflection successfully`
  String get success_edit_reflection {
    return Intl.message(
      'Update reflection successfully',
      name: 'success_edit_reflection',
      desc: '',
      args: [],
    );
  }

  /// `Temporary resident`
  String get temp_res {
    return Intl.message(
      'Temporary resident',
      name: 'temp_res',
      desc: '',
      args: [],
    );
  }

  /// `Permanent resident`
  String get per_res {
    return Intl.message(
      'Permanent resident',
      name: 'per_res',
      desc: '',
      args: [],
    );
  }

  /// `Temporary resident for foreigner`
  String get temp_res_foreigner {
    return Intl.message(
      'Temporary resident for foreigner',
      name: 'temp_res_foreigner',
      desc: '',
      args: [],
    );
  }

  /// `Resident images can not be empty`
  String get res_images_not_empty {
    return Intl.message(
      'Resident images can not be empty',
      name: 'res_images_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Register dependent person successfully`
  String get success_register_dependence {
    return Intl.message(
      'Register dependent person successfully',
      name: 'success_register_dependence',
      desc: '',
      args: [],
    );
  }

  /// `Cancel register dependent person successfully`
  String get success_cancel_dependence {
    return Intl.message(
      'Cancel register dependent person successfully',
      name: 'success_cancel_dependence',
      desc: '',
      args: [],
    );
  }

  /// `College degree`
  String get college_degree {
    return Intl.message(
      'College degree',
      name: 'college_degree',
      desc: '',
      args: [],
    );
  }

  /// `Master degree`
  String get master_degree {
    return Intl.message(
      'Master degree',
      name: 'master_degree',
      desc: '',
      args: [],
    );
  }

  /// `High school degree`
  String get high_school_degree {
    return Intl.message(
      'High school degree',
      name: 'high_school_degree',
      desc: '',
      args: [],
    );
  }

  /// `Going master`
  String get post_graduate {
    return Intl.message(
      'Going master',
      name: 'post_graduate',
      desc: '',
      args: [],
    );
  }

  /// `Going university`
  String get go_university {
    return Intl.message(
      'Going university',
      name: 'go_university',
      desc: '',
      args: [],
    );
  }

  /// `going high school`
  String get go_high_school {
    return Intl.message(
      'going high school',
      name: 'go_high_school',
      desc: '',
      args: [],
    );
  }

  /// `Doctor degree`
  String get doctor_degree {
    return Intl.message(
      'Doctor degree',
      name: 'doctor_degree',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unkhown {
    return Intl.message(
      'Unknown',
      name: 'unkhown',
      desc: '',
      args: [],
    );
  }

  /// `Single`
  String get fa {
    return Intl.message(
      'Single',
      name: 'fa',
      desc: '',
      args: [],
    );
  }

  /// `Married`
  String get married {
    return Intl.message(
      'Married',
      name: 'married',
      desc: '',
      args: [],
    );
  }

  /// `Have baby`
  String get have_baby {
    return Intl.message(
      'Have baby',
      name: 'have_baby',
      desc: '',
      args: [],
    );
  }

  /// `Qualification level`
  String get qualification_level {
    return Intl.message(
      'Qualification level',
      name: 'qualification_level',
      desc: '',
      args: [],
    );
  }

  /// `Matial status`
  String get matial_status {
    return Intl.message(
      'Matial status',
      name: 'matial_status',
      desc: '',
      args: [],
    );
  }

  /// `Resident name`
  String get res_name {
    return Intl.message(
      'Resident name',
      name: 'res_name',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any dependence registration letter`
  String get no_dependence {
    return Intl.message(
      'Don\'t have any dependence registration letter',
      name: 'no_dependence',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message(
      'Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Zalo`
  String get zalo {
    return Intl.message(
      'Zalo',
      name: 'zalo',
      desc: '',
      args: [],
    );
  }

  /// `Instagram`
  String get instagram {
    return Intl.message(
      'Instagram',
      name: 'instagram',
      desc: '',
      args: [],
    );
  }

  /// `Linkedin`
  String get linkedin {
    return Intl.message(
      'Linkedin',
      name: 'linkedin',
      desc: '',
      args: [],
    );
  }

  /// `Tiktok`
  String get tiktok {
    return Intl.message(
      'Tiktok',
      name: 'tiktok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel letter`
  String get cancel_letter {
    return Intl.message(
      'Cancel letter',
      name: 'cancel_letter',
      desc: '',
      args: [],
    );
  }

  /// `Add person to apartment`
  String get add_dependent_person_to_apartment {
    return Intl.message(
      'Add person to apartment',
      name: 'add_dependent_person_to_apartment',
      desc: '',
      args: [],
    );
  }

  /// `Apartment can not be empty`
  String get apartment_not_empty {
    return Intl.message(
      'Apartment can not be empty',
      name: 'apartment_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Resident can not be empty`
  String get resident_not_empty {
    return Intl.message(
      'Resident can not be empty',
      name: 'resident_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Plan infomation`
  String get plan_info {
    return Intl.message(
      'Plan infomation',
      name: 'plan_info',
      desc: '',
      args: [],
    );
  }

  /// `Bill history`
  String get bill_history {
    return Intl.message(
      'Bill history',
      name: 'bill_history',
      desc: '',
      args: [],
    );
  }

  /// `Lịch sử thông báo`
  String get noti_history {
    return Intl.message(
      'Lịch sử thông báo',
      name: 'noti_history',
      desc: '',
      args: [],
    );
  }

  /// `Abbreviation`
  String get abrv {
    return Intl.message(
      'Abbreviation',
      name: 'abrv',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Free resident card`
  String get free_res_card {
    return Intl.message(
      'Free resident card',
      name: 'free_res_card',
      desc: '',
      args: [],
    );
  }

  /// `Issued resident card`
  String get issue_res_card {
    return Intl.message(
      'Issued resident card',
      name: 'issue_res_card',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card_unit {
    return Intl.message(
      'Card',
      name: 'card_unit',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card_unit2 {
    return Intl.message(
      'Card',
      name: 'card_unit2',
      desc: '',
      args: [],
    );
  }

  /// `Plan name`
  String get plan_name {
    return Intl.message(
      'Plan name',
      name: 'plan_name',
      desc: '',
      args: [],
    );
  }

  /// `Permanent resident address`
  String get per_res_address {
    return Intl.message(
      'Permanent resident address',
      name: 'per_res_address',
      desc: '',
      args: [],
    );
  }

  /// `Renter`
  String get renter {
    return Intl.message(
      'Renter',
      name: 'renter',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get buyer {
    return Intl.message(
      'Owner',
      name: 'buyer',
      desc: '',
      args: [],
    );
  }

  /// `Dependent host`
  String get dependent_host {
    return Intl.message(
      'Dependent host',
      name: 'dependent_host',
      desc: '',
      args: [],
    );
  }

  /// `Dependent rent`
  String get dependent_rent {
    return Intl.message(
      'Dependent rent',
      name: 'dependent_rent',
      desc: '',
      args: [],
    );
  }

  /// `Relation with owner`
  String get relation_owner {
    return Intl.message(
      'Relation with owner',
      name: 'relation_owner',
      desc: '',
      args: [],
    );
  }

  /// `Change password successfully, please re log in with new password`
  String get success_change_pass {
    return Intl.message(
      'Change password successfully, please re log in with new password',
      name: 'success_change_pass',
      desc: '',
      args: [],
    );
  }

  /// `New password can not be same old password`
  String get pass_not_same {
    return Intl.message(
      'New password can not be same old password',
      name: 'pass_not_same',
      desc: '',
      args: [],
    );
  }

  /// `Relationship can not be empty`
  String get relation_not_empty {
    return Intl.message(
      'Relationship can not be empty',
      name: 'relation_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Add email`
  String get add_email {
    return Intl.message(
      'Add email',
      name: 'add_email',
      desc: '',
      args: [],
    );
  }

  /// `Email can not be empty`
  String get email_not_empty {
    return Intl.message(
      'Email can not be empty',
      name: 'email_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Add email successfully`
  String get success_add_email {
    return Intl.message(
      'Add email successfully',
      name: 'success_add_email',
      desc: '',
      args: [],
    );
  }

  /// `Update email successfully`
  String get success_update_email {
    return Intl.message(
      'Update email successfully',
      name: 'success_update_email',
      desc: '',
      args: [],
    );
  }

  /// `Possessed apartments`
  String get possessed_apartment {
    return Intl.message(
      'Possessed apartments',
      name: 'possessed_apartment',
      desc: '',
      args: [],
    );
  }

  /// `Registed resident`
  String get registed_resident {
    return Intl.message(
      'Registed resident',
      name: 'registed_resident',
      desc: '',
      args: [],
    );
  }

  /// `resident confirmed by manager department`
  String get confirmed_by_manager_resident {
    return Intl.message(
      'resident confirmed by manager department',
      name: 'confirmed_by_manager_resident',
      desc: '',
      args: [],
    );
  }

  /// `Menber number`
  String get member_num {
    return Intl.message(
      'Menber number',
      name: 'member_num',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any apartment`
  String get no_home {
    return Intl.message(
      'Don\'t have any apartment',
      name: 'no_home',
      desc: '',
      args: [],
    );
  }

  /// `Card list`
  String get card_list {
    return Intl.message(
      'Card list',
      name: 'card_list',
      desc: '',
      args: [],
    );
  }

  /// `Cancel reflection successfully`
  String get success_cancel_reflection {
    return Intl.message(
      'Cancel reflection successfully',
      name: 'success_cancel_reflection',
      desc: '',
      args: [],
    );
  }

  /// `Not less than 9 characters`
  String get cmnd_length_9 {
    return Intl.message(
      'Not less than 9 characters',
      name: 'cmnd_length_9',
      desc: '',
      args: [],
    );
  }

  /// `Not greater than today`
  String get not_greater_than_today {
    return Intl.message(
      'Not greater than today',
      name: 'not_greater_than_today',
      desc: '',
      args: [],
    );
  }

  /// `Registered card`
  String get registered_card {
    return Intl.message(
      'Registered card',
      name: 'registered_card',
      desc: '',
      args: [],
    );
  }

  /// `Card confirmed by manager department`
  String get confirmed_card {
    return Intl.message(
      'Card confirmed by manager department',
      name: 'confirmed_card',
      desc: '',
      args: [],
    );
  }

  /// `Select card type`
  String get select_card_type {
    return Intl.message(
      'Select card type',
      name: 'select_card_type',
      desc: '',
      args: [],
    );
  }

  /// `Chart`
  String get chart {
    return Intl.message(
      'Chart',
      name: 'chart',
      desc: '',
      args: [],
    );
  }

  /// `Electricity index`
  String get elec_index {
    return Intl.message(
      'Electricity index',
      name: 'elec_index',
      desc: '',
      args: [],
    );
  }

  /// `Electricity details`
  String get elec_details {
    return Intl.message(
      'Electricity details',
      name: 'elec_details',
      desc: '',
      args: [],
    );
  }

  /// `Biểu đồ điện năng tiêu thụ`
  String get elect_consume_chart {
    return Intl.message(
      'Biểu đồ điện năng tiêu thụ',
      name: 'elect_consume_chart',
      desc: '',
      args: [],
    );
  }

  /// `Jan`
  String get th01 {
    return Intl.message(
      'Jan',
      name: 'th01',
      desc: '',
      args: [],
    );
  }

  /// `Fed`
  String get th02 {
    return Intl.message(
      'Fed',
      name: 'th02',
      desc: '',
      args: [],
    );
  }

  /// `Mar`
  String get th03 {
    return Intl.message(
      'Mar',
      name: 'th03',
      desc: '',
      args: [],
    );
  }

  /// `Apr`
  String get th04 {
    return Intl.message(
      'Apr',
      name: 'th04',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get th05 {
    return Intl.message(
      'May',
      name: 'th05',
      desc: '',
      args: [],
    );
  }

  /// `Jun`
  String get th06 {
    return Intl.message(
      'Jun',
      name: 'th06',
      desc: '',
      args: [],
    );
  }

  /// `Jul`
  String get th07 {
    return Intl.message(
      'Jul',
      name: 'th07',
      desc: '',
      args: [],
    );
  }

  /// `Aug`
  String get th08 {
    return Intl.message(
      'Aug',
      name: 'th08',
      desc: '',
      args: [],
    );
  }

  /// `Sep`
  String get th09 {
    return Intl.message(
      'Sep',
      name: 'th09',
      desc: '',
      args: [],
    );
  }

  /// `Oct`
  String get th10 {
    return Intl.message(
      'Oct',
      name: 'th10',
      desc: '',
      args: [],
    );
  }

  /// `Nov`
  String get th11 {
    return Intl.message(
      'Nov',
      name: 'th11',
      desc: '',
      args: [],
    );
  }

  /// `Dec`
  String get th12 {
    return Intl.message(
      'Dec',
      name: 'th12',
      desc: '',
      args: [],
    );
  }

  /// `Paid Bill from {f} to {t}`
  String bill_from_to(Object f, Object t) {
    return Intl.message(
      'Paid Bill from $f to $t',
      name: 'bill_from_to',
      desc: '',
      args: [f, t],
    );
  }

  /// `Meter code`
  String get meter_code {
    return Intl.message(
      'Meter code',
      name: 'meter_code',
      desc: '',
      args: [],
    );
  }

  /// `New index`
  String get new_index {
    return Intl.message(
      'New index',
      name: 'new_index',
      desc: '',
      args: [],
    );
  }

  /// `Old index`
  String get old_index {
    return Intl.message(
      'Old index',
      name: 'old_index',
      desc: '',
      args: [],
    );
  }

  /// `Consume electricity`
  String get consume_elec {
    return Intl.message(
      'Consume electricity',
      name: 'consume_elec',
      desc: '',
      args: [],
    );
  }

  /// `Unit price (VNĐ)`
  String get unit_price {
    return Intl.message(
      'Unit price (VNĐ)',
      name: 'unit_price',
      desc: '',
      args: [],
    );
  }

  /// `To money (VNĐ)`
  String get to_money_vnd {
    return Intl.message(
      'To money (VNĐ)',
      name: 'to_money_vnd',
      desc: '',
      args: [],
    );
  }

  /// `Total money payment`
  String get total_money_pay {
    return Intl.message(
      'Total money payment',
      name: 'total_money_pay',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get change_email {
    return Intl.message(
      'Change Email',
      name: 'change_email',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cancel {rCode}`
  String confirm_can_reflection(Object rCode) {
    return Intl.message(
      'Do you want to cancel $rCode',
      name: 'confirm_can_reflection',
      desc: '',
      args: [rCode],
    );
  }

  /// `System is sending to your email, please wait`
  String get send_email_wait {
    return Intl.message(
      'System is sending to your email, please wait',
      name: 'send_email_wait',
      desc: '',
      args: [],
    );
  }

  /// `New email is not same to old email`
  String get email_not_same {
    return Intl.message(
      'New email is not same to old email',
      name: 'email_not_same',
      desc: '',
      args: [],
    );
  }

  /// `Consumed electricity details`
  String get consumed_elec_details {
    return Intl.message(
      'Consumed electricity details',
      name: 'consumed_elec_details',
      desc: '',
      args: [],
    );
  }

  /// `Legend`
  String get legend {
    return Intl.message(
      'Legend',
      name: 'legend',
      desc: '',
      args: [],
    );
  }

  /// `Total money need to pay`
  String get total_money_to_pay {
    return Intl.message(
      'Total money need to pay',
      name: 'total_money_to_pay',
      desc: '',
      args: [],
    );
  }

  /// `Wait to pay`
  String get wait_pay {
    return Intl.message(
      'Wait to pay',
      name: 'wait_pay',
      desc: '',
      args: [],
    );
  }

  /// `Consumed water detail`
  String get consumed_water_detail {
    return Intl.message(
      'Consumed water detail',
      name: 'consumed_water_detail',
      desc: '',
      args: [],
    );
  }

  /// `Consumed water detail`
  String get consumed_water_detail1 {
    return Intl.message(
      'Consumed water detail',
      name: 'consumed_water_detail1',
      desc: '',
      args: [],
    );
  }

  /// `Details bill`
  String get details_bill {
    return Intl.message(
      'Details bill',
      name: 'details_bill',
      desc: '',
      args: [],
    );
  }

  /// `Total consumed water month {month}/{year}`
  String total_consumed_water_month(Object month, Object year) {
    return Intl.message(
      'Total consumed water month $month/$year',
      name: 'total_consumed_water_month',
      desc: '',
      args: [month, year],
    );
  }

  /// `Consumed water`
  String get consumed_water {
    return Intl.message(
      'Consumed water',
      name: 'consumed_water',
      desc: '',
      args: [],
    );
  }

  /// `Transportation card`
  String get transport_card {
    return Intl.message(
      'Transportation card',
      name: 'transport_card',
      desc: '',
      args: [],
    );
  }

  /// `Register transportation card`
  String get reg_transport_card {
    return Intl.message(
      'Register transportation card',
      name: 'reg_transport_card',
      desc: '',
      args: [],
    );
  }

  /// `Transportation list`
  String get transport_list {
    return Intl.message(
      'Transportation list',
      name: 'transport_list',
      desc: '',
      args: [],
    );
  }

  /// `Intergrate into existed resident card`
  String get intergrate_existed_resident_card {
    return Intl.message(
      'Intergrate into existed resident card',
      name: 'intergrate_existed_resident_card',
      desc: '',
      args: [],
    );
  }

  /// `Confirm obey regulation`
  String get confirm_obey_regulation {
    return Intl.message(
      'Confirm obey regulation',
      name: 'confirm_obey_regulation',
      desc: '',
      args: [],
    );
  }

  /// `Building regulation`
  String get building_regulation {
    return Intl.message(
      'Building regulation',
      name: 'building_regulation',
      desc: '',
      args: [],
    );
  }

  /// `Building regulation about transportation`
  String get building_regulation_trans {
    return Intl.message(
      'Building regulation about transportation',
      name: 'building_regulation_trans',
      desc: '',
      args: [],
    );
  }

  /// `Transportation`
  String get transport {
    return Intl.message(
      'Transportation',
      name: 'transport',
      desc: '',
      args: [],
    );
  }

  /// `Seat amount`
  String get num_seat {
    return Intl.message(
      'Seat amount',
      name: 'num_seat',
      desc: '',
      args: [],
    );
  }

  /// `Expired_date`
  String get used_expired_date {
    return Intl.message(
      'Expired_date',
      name: 'used_expired_date',
      desc: '',
      args: [],
    );
  }

  /// `Add transport`
  String get add_transport {
    return Intl.message(
      'Add transport',
      name: 'add_transport',
      desc: '',
      args: [],
    );
  }

  /// `Transportation information`
  String get transport_info {
    return Intl.message(
      'Transportation information',
      name: 'transport_info',
      desc: '',
      args: [],
    );
  }

  /// `Add new transportation`
  String get add_new_transport {
    return Intl.message(
      'Add new transportation',
      name: 'add_new_transport',
      desc: '',
      args: [],
    );
  }

  /// `Transportation register number`
  String get trans_reg_num {
    return Intl.message(
      'Transportation register number',
      name: 'trans_reg_num',
      desc: '',
      args: [],
    );
  }

  /// `Transportation images`
  String get trans_images {
    return Intl.message(
      'Transportation images',
      name: 'trans_images',
      desc: '',
      args: [],
    );
  }

  /// `Report lost`
  String get report_lost {
    return Intl.message(
      'Report lost',
      name: 'report_lost',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to report missing card {code}?`
  String confirm_missing_report(Object code) {
    return Intl.message(
      'Do you want to report missing card $code?',
      name: 'confirm_missing_report',
      desc: '',
      args: [code],
    );
  }

  /// `When report missing card , your card will be cancelled. if you want continue use service you need to register new card`
  String get when_missing {
    return Intl.message(
      'When report missing card , your card will be cancelled. if you want continue use service you need to register new card',
      name: 'when_missing',
      desc: '',
      args: [],
    );
  }

  /// `Report missing report successfully`
  String get success_report_missing {
    return Intl.message(
      'Report missing report successfully',
      name: 'success_report_missing',
      desc: '',
      args: [],
    );
  }

  /// `Report missing card`
  String get report_missing_card {
    return Intl.message(
      'Report missing card',
      name: 'report_missing_card',
      desc: '',
      args: [],
    );
  }

  /// `Report missing card`
  String get report_missing_card_res {
    return Intl.message(
      'Report missing card',
      name: 'report_missing_card_res',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to report missing card {code}?`
  String confirm_missing_report_res(Object code) {
    return Intl.message(
      'Do you want to report missing card $code?',
      name: 'confirm_missing_report_res',
      desc: '',
      args: [code],
    );
  }

  /// `Transport registration`
  String get transport_reg {
    return Intl.message(
      'Transport registration',
      name: 'transport_reg',
      desc: '',
      args: [],
    );
  }

  /// `Select transport`
  String get select_transport {
    return Intl.message(
      'Select transport',
      name: 'select_transport',
      desc: '',
      args: [],
    );
  }

  /// `Select number seat`
  String get select_seat_num {
    return Intl.message(
      'Select number seat',
      name: 'select_seat_num',
      desc: '',
      args: [],
    );
  }

  /// `Enter license number`
  String get enter_license_num {
    return Intl.message(
      'Enter license number',
      name: 'enter_license_num',
      desc: '',
      args: [],
    );
  }

  /// `Enter registration number`
  String get enter_reg_num {
    return Intl.message(
      'Enter registration number',
      name: 'enter_reg_num',
      desc: '',
      args: [],
    );
  }

  /// `Select expired time`
  String get select_expire {
    return Intl.message(
      'Select expired time',
      name: 'select_expire',
      desc: '',
      args: [],
    );
  }

  /// `Seat number can not be zero`
  String get num_seat_not_zero {
    return Intl.message(
      'Seat number can not be zero',
      name: 'num_seat_not_zero',
      desc: '',
      args: [],
    );
  }

  /// `Edit transportation`
  String get edit_transport {
    return Intl.message(
      'Edit transportation',
      name: 'edit_transport',
      desc: '',
      args: [],
    );
  }

  /// `Edit transportation registration`
  String get edit_reg_transport {
    return Intl.message(
      'Edit transportation registration',
      name: 'edit_reg_transport',
      desc: '',
      args: [],
    );
  }

  /// `Transportation list`
  String get list_transport {
    return Intl.message(
      'Transportation list',
      name: 'list_transport',
      desc: '',
      args: [],
    );
  }

  /// `Transportation details`
  String get trans_details {
    return Intl.message(
      'Transportation details',
      name: 'trans_details',
      desc: '',
      args: [],
    );
  }

  /// `Transportation status`
  String get trans_status {
    return Intl.message(
      'Transportation status',
      name: 'trans_status',
      desc: '',
      args: [],
    );
  }

  /// `Cancel transport`
  String get cancel_transport {
    return Intl.message(
      'Cancel transport',
      name: 'cancel_transport',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cancel transport {plate}?`
  String confirm_cancel_trans(Object plate) {
    return Intl.message(
      'Do you want to cancel transport $plate?',
      name: 'confirm_cancel_trans',
      desc: '',
      args: [plate],
    );
  }

  /// `Cancel transport successfully`
  String get success_cancel_trans {
    return Intl.message(
      'Cancel transport successfully',
      name: 'success_cancel_trans',
      desc: '',
      args: [],
    );
  }

  /// `Extend transportation successfully`
  String get succees_extend_trans {
    return Intl.message(
      'Extend transportation successfully',
      name: 'succees_extend_trans',
      desc: '',
      args: [],
    );
  }

  /// `Old expired date `
  String get expired_date_old {
    return Intl.message(
      'Old expired date ',
      name: 'expired_date_old',
      desc: '',
      args: [],
    );
  }

  /// `New expired date`
  String get expired_date_new {
    return Intl.message(
      'New expired date',
      name: 'expired_date_new',
      desc: '',
      args: [],
    );
  }

  /// `extended expired date`
  String get expired_date_create {
    return Intl.message(
      'extended expired date',
      name: 'expired_date_create',
      desc: '',
      args: [],
    );
  }

  /// `Add new extend request successfully`
  String get add_extend_request_successfull {
    return Intl.message(
      'Add new extend request successfully',
      name: 'add_extend_request_successfull',
      desc: '',
      args: [],
    );
  }

  /// `Card must have at least 1 transportation`
  String get trans_card_atleast_1 {
    return Intl.message(
      'Card must have at least 1 transportation',
      name: 'trans_card_atleast_1',
      desc: '',
      args: [],
    );
  }

  /// `Cancel transportation card`
  String get can_trans {
    return Intl.message(
      'Cancel transportation card',
      name: 'can_trans',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cancel transportation card?`
  String get confirm_can_trans_card {
    return Intl.message(
      'Do you want to cancel transportation card?',
      name: 'confirm_can_trans_card',
      desc: '',
      args: [],
    );
  }

  /// `Cancel resident card`
  String get can_trans_res {
    return Intl.message(
      'Cancel resident card',
      name: 'can_trans_res',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cancel resident card?`
  String get confirm_can_trans_card_res {
    return Intl.message(
      'Do you want to cancel resident card?',
      name: 'confirm_can_trans_card_res',
      desc: '',
      args: [],
    );
  }

  /// `Cancel transportation card successfully`
  String get success_can_trans_card {
    return Intl.message(
      'Cancel transportation card successfully',
      name: 'success_can_trans_card',
      desc: '',
      args: [],
    );
  }

  /// `Cancel resident card successfully`
  String get success_can_res_card {
    return Intl.message(
      'Cancel resident card successfully',
      name: 'success_can_res_card',
      desc: '',
      args: [],
    );
  }

  /// `Lock reason`
  String get lock_reason {
    return Intl.message(
      'Lock reason',
      name: 'lock_reason',
      desc: '',
      args: [],
    );
  }

  /// `Cancel registration`
  String get reg_cancel {
    return Intl.message(
      'Cancel registration',
      name: 'reg_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Identity photos`
  String get cmnd_photos {
    return Intl.message(
      'Identity photos',
      name: 'cmnd_photos',
      desc: '',
      args: [],
    );
  }

  /// `Resident registration details`
  String get resident_letter_details {
    return Intl.message(
      'Resident registration details',
      name: 'resident_letter_details',
      desc: '',
      args: [],
    );
  }

  /// `My letter`
  String get my_letter {
    return Intl.message(
      'My letter',
      name: 'my_letter',
      desc: '',
      args: [],
    );
  }

  /// `Wait confirm letter`
  String get wait_confirm_letter {
    return Intl.message(
      'Wait confirm letter',
      name: 'wait_confirm_letter',
      desc: '',
      args: [],
    );
  }

  /// `refuse`
  String get refuse {
    return Intl.message(
      'refuse',
      name: 'refuse',
      desc: '',
      args: [],
    );
  }

  /// `Refuse letter`
  String get refuse_letter {
    return Intl.message(
      'Refuse letter',
      name: 'refuse_letter',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to refuse letter [{code}] ?`
  String confirm_refuse_letter(Object code) {
    return Intl.message(
      'Do you want to refuse letter [$code] ?',
      name: 'confirm_refuse_letter',
      desc: '',
      args: [code],
    );
  }

  /// `Refuse letter successfully`
  String get success_refuse_letter {
    return Intl.message(
      'Refuse letter successfully',
      name: 'success_refuse_letter',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to accept letter [{code}] ?`
  String confirm_accept_letter(Object code) {
    return Intl.message(
      'Do you want to accept letter [$code] ?',
      name: 'confirm_accept_letter',
      desc: '',
      args: [code],
    );
  }

  /// `Accept letter successfully`
  String get success_accept_letter {
    return Intl.message(
      'Accept letter successfully',
      name: 'success_accept_letter',
      desc: '',
      args: [],
    );
  }

  /// `Refuse reason`
  String get reason_refuse {
    return Intl.message(
      'Refuse reason',
      name: 'reason_refuse',
      desc: '',
      args: [],
    );
  }

  /// `Enter refuse reason`
  String get enter_reason_refuse {
    return Intl.message(
      'Enter refuse reason',
      name: 'enter_reason_refuse',
      desc: '',
      args: [],
    );
  }

  /// `Owner refuse`
  String get owner_refuse {
    return Intl.message(
      'Owner refuse',
      name: 'owner_refuse',
      desc: '',
      args: [],
    );
  }

  /// `Cancel card`
  String get cancel_card {
    return Intl.message(
      'Cancel card',
      name: 'cancel_card',
      desc: '',
      args: [],
    );
  }

  /// `Can not extend transport in inactive card`
  String get not_extend_inactive_card {
    return Intl.message(
      'Can not extend transport in inactive card',
      name: 'not_extend_inactive_card',
      desc: '',
      args: [],
    );
  }

  /// `Transport image not be empty`
  String get trans_images_not_empty {
    return Intl.message(
      'Transport image not be empty',
      name: 'trans_images_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Registered image must be at least 2 photo`
  String get reg_images_not_empty {
    return Intl.message(
      'Registered image must be at least 2 photo',
      name: 'reg_images_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Update successfully`
  String get success_update {
    return Intl.message(
      'Update successfully',
      name: 'success_update',
      desc: '',
      args: [],
    );
  }

  /// `Registration letter code`
  String get reg_letter_num {
    return Intl.message(
      'Registration letter code',
      name: 'reg_letter_num',
      desc: '',
      args: [],
    );
  }

  /// `Register information`
  String get register_info {
    return Intl.message(
      'Register information',
      name: 'register_info',
      desc: '',
      args: [],
    );
  }

  /// `Note cancel reason`
  String get note_can_reason {
    return Intl.message(
      'Note cancel reason',
      name: 'note_can_reason',
      desc: '',
      args: [],
    );
  }

  /// `Transfer rules`
  String get tranfer_rule {
    return Intl.message(
      'Transfer rules',
      name: 'tranfer_rule',
      desc: '',
      args: [],
    );
  }

  /// `Identity images (2 sides)`
  String get cmnd_images {
    return Intl.message(
      'Identity images (2 sides)',
      name: 'cmnd_images',
      desc: '',
      args: [],
    );
  }

  /// `Identity images at less 2 Images`
  String get cmnd_images_not_less_2 {
    return Intl.message(
      'Identity images at less 2 Images',
      name: 'cmnd_images_not_less_2',
      desc: '',
      args: [],
    );
  }

  /// `You booked handover schedule successfully for apartment [{name}] .Please wait to building management department approve.`
  String success_book_schedule(Object name) {
    return Intl.message(
      'You booked handover schedule successfully for apartment [$name] .Please wait to building management department approve.',
      name: 'success_book_schedule',
      desc: '',
      args: [name],
    );
  }

  /// `Cancel schedule`
  String get can_schedule {
    return Intl.message(
      'Cancel schedule',
      name: 'can_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Change schedule`
  String get change_schedule {
    return Intl.message(
      'Change schedule',
      name: 'change_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to change schedule of handover, old  schedule for apartment [{name}] will be cancel?`
  String confirm_change_schedule(Object name) {
    return Intl.message(
      'Do you want to change schedule of handover, old  schedule for apartment [$name] will be cancel?',
      name: 'confirm_change_schedule',
      desc: '',
      args: [name],
    );
  }

  /// `New schedule`
  String get new_schedule {
    return Intl.message(
      'New schedule',
      name: 'new_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Cancel handover schedule`
  String get can_schedule_hand_over {
    return Intl.message(
      'Cancel handover schedule',
      name: 'can_schedule_hand_over',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cancel schedule of handover for apartment [{name}] ?`
  String confirm_can_schedule(Object name) {
    return Intl.message(
      'Do you want to cancel schedule of handover for apartment [$name] ?',
      name: 'confirm_can_schedule',
      desc: '',
      args: [name],
    );
  }

  /// `Cancel schedule of handover for apartment [{name}] successfully`
  String success_can_schedule(Object name) {
    return Intl.message(
      'Cancel schedule of handover for apartment [$name] successfully',
      name: 'success_can_schedule',
      desc: '',
      args: [name],
    );
  }

  /// `Usage area of apartment`
  String get s_usage_apartment {
    return Intl.message(
      'Usage area of apartment',
      name: 's_usage_apartment',
      desc: '',
      args: [],
    );
  }

  /// `Construction area of apartment`
  String get s_cons_apartment {
    return Intl.message(
      'Construction area of apartment',
      name: 's_cons_apartment',
      desc: '',
      args: [],
    );
  }

  /// `Time preparing handover `
  String get time_hanover {
    return Intl.message(
      'Time preparing handover ',
      name: 'time_hanover',
      desc: '',
      args: [],
    );
  }

  /// `Hand over employee`
  String get employee_handover {
    return Intl.message(
      'Hand over employee',
      name: 'employee_handover',
      desc: '',
      args: [],
    );
  }

  /// `Hand over rule`
  String get hand_over_rule {
    return Intl.message(
      'Hand over rule',
      name: 'hand_over_rule',
      desc: '',
      args: [],
    );
  }

  /// `Upload error`
  String get err_upload {
    return Intl.message(
      'Upload error',
      name: 'err_upload',
      desc: '',
      args: [],
    );
  }

  /// `To refer any option, please select bellow:`
  String get choose_subject {
    return Intl.message(
      'To refer any option, please select bellow:',
      name: 'choose_subject',
      desc: '',
      args: [],
    );
  }

  /// `It seam you didn't response any thing for a while. Do you want to continue conversation. The convsersation will be closed after several minute if you are not response.`
  String get wait_chat_response {
    return Intl.message(
      'It seam you didn\'t response any thing for a while. Do you want to continue conversation. The convsersation will be closed after several minute if you are not response.',
      name: 'wait_chat_response',
      desc: '',
      args: [],
    );
  }

  /// `Note cancel reason`
  String get note_cancel {
    return Intl.message(
      'Note cancel reason',
      name: 'note_cancel',
      desc: '',
      args: [],
    );
  }

  /// `First approve`
  String get approve_1 {
    return Intl.message(
      'First approve',
      name: 'approve_1',
      desc: '',
      args: [],
    );
  }

  /// `Second approve`
  String get approve_2 {
    return Intl.message(
      'Second approve',
      name: 'approve_2',
      desc: '',
      args: [],
    );
  }

  /// `Third approve`
  String get approve_3 {
    return Intl.message(
      'Third approve',
      name: 'approve_3',
      desc: '',
      args: [],
    );
  }

  /// `Pay done`
  String get pay_done {
    return Intl.message(
      'Pay done',
      name: 'pay_done',
      desc: '',
      args: [],
    );
  }

  /// `Create new`
  String get create_new {
    return Intl.message(
      'Create new',
      name: 'create_new',
      desc: '',
      args: [],
    );
  }

  /// `Performed person`
  String get perform_person {
    return Intl.message(
      'Performed person',
      name: 'perform_person',
      desc: '',
      args: [],
    );
  }

  /// `Drawing`
  String get drawing {
    return Intl.message(
      'Drawing',
      name: 'drawing',
      desc: '',
      args: [],
    );
  }

  /// `Error report`
  String get err_report {
    return Intl.message(
      'Error report',
      name: 'err_report',
      desc: '',
      args: [],
    );
  }

  /// `Error reason`
  String get err_reason {
    return Intl.message(
      'Error reason',
      name: 'err_reason',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `STT`
  String get stt {
    return Intl.message(
      'STT',
      name: 'stt',
      desc: '',
      args: [],
    );
  }

  /// `Floor`
  String get floor {
    return Intl.message(
      'Floor',
      name: 'floor',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit_count {
    return Intl.message(
      'Unit',
      name: 'unit_count',
      desc: '',
      args: [],
    );
  }

  /// `Material specification`
  String get material_specification {
    return Intl.message(
      'Material specification',
      name: 'material_specification',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Asset`
  String get asset {
    return Intl.message(
      'Asset',
      name: 'asset',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Report Handover successfully`
  String get success_report_handover {
    return Intl.message(
      'Report Handover successfully',
      name: 'success_report_handover',
      desc: '',
      args: [],
    );
  }

  /// `Not yet handover date`
  String get not_date_handover {
    return Intl.message(
      'Not yet handover date',
      name: 'not_date_handover',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Handover list has {c} item not pass .Do you want to confirm handover.`
  String count_err_handover(Object c) {
    return Intl.message(
      'Handover list has $c item not pass .Do you want to confirm handover.',
      name: 'count_err_handover',
      desc: '',
      args: [c],
    );
  }

  /// `You completed handover for apartment [{a}]`
  String complete_handover(Object a) {
    return Intl.message(
      'You completed handover for apartment [$a]',
      name: 'complete_handover',
      desc: '',
      args: [a],
    );
  }

  /// `Reality`
  String get reality {
    return Intl.message(
      'Reality',
      name: 'reality',
      desc: '',
      args: [],
    );
  }

  /// `Reality hand over date`
  String get reality_handover_date {
    return Intl.message(
      'Reality hand over date',
      name: 'reality_handover_date',
      desc: '',
      args: [],
    );
  }

  /// `Reality hand over hour`
  String get reality_handover_hour {
    return Intl.message(
      'Reality hand over hour',
      name: 'reality_handover_hour',
      desc: '',
      args: [],
    );
  }

  /// `File/ Image`
  String get file_image {
    return Intl.message(
      'File/ Image',
      name: 'file_image',
      desc: '',
      args: [],
    );
  }

  /// `You already hand over for {ap} successfully`
  String success_handover(Object ap) {
    return Intl.message(
      'You already hand over for $ap successfully',
      name: 'success_handover',
      desc: '',
      args: [ap],
    );
  }

  /// `Value is not greater than {s}`
  String not_larger(Object s) {
    return Intl.message(
      'Value is not greater than $s',
      name: 'not_larger',
      desc: '',
      args: [s],
    );
  }

  /// `Material`
  String get material0 {
    return Intl.message(
      'Material',
      name: 'material0',
      desc: '',
      args: [],
    );
  }

  /// `Category name`
  String get category_name {
    return Intl.message(
      'Category name',
      name: 'category_name',
      desc: '',
      args: [],
    );
  }

  /// `Under construction`
  String get under_construction {
    return Intl.message(
      'Under construction',
      name: 'under_construction',
      desc: '',
      args: [],
    );
  }

  /// `Wait acceptance`
  String get wait_acceptance {
    return Intl.message(
      'Wait acceptance',
      name: 'wait_acceptance',
      desc: '',
      args: [],
    );
  }

  /// `Under acceptance`
  String get under_acceptance {
    return Intl.message(
      'Under acceptance',
      name: 'under_acceptance',
      desc: '',
      args: [],
    );
  }

  /// `Violation Execution`
  String get violation_exe {
    return Intl.message(
      'Violation Execution',
      name: 'violation_exe',
      desc: '',
      args: [],
    );
  }

  /// `Pause construction`
  String get pause_construction {
    return Intl.message(
      'Pause construction',
      name: 'pause_construction',
      desc: '',
      args: [],
    );
  }

  /// `Continue construction`
  String get continue_construction {
    return Intl.message(
      'Continue construction',
      name: 'continue_construction',
      desc: '',
      args: [],
    );
  }

  /// `You need check all item. Please check again.`
  String get not_complete_check {
    return Intl.message(
      'You need check all item. Please check again.',
      name: 'not_complete_check',
      desc: '',
      args: [],
    );
  }

  /// `Plan code`
  String get plan_code {
    return Intl.message(
      'Plan code',
      name: 'plan_code',
      desc: '',
      args: [],
    );
  }

  /// `Select project`
  String get select_project {
    return Intl.message(
      'Select project',
      name: 'select_project',
      desc: '',
      args: [],
    );
  }

  /// `If you have not registered information yet, please click`
  String get if_not_resident {
    return Intl.message(
      'If you have not registered information yet, please click',
      name: 'if_not_resident',
      desc: '',
      args: [],
    );
  }

  /// `here`
  String get click_here {
    return Intl.message(
      'here',
      name: 'click_here',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any project`
  String get no_project {
    return Intl.message(
      'Don\'t have any project',
      name: 'no_project',
      desc: '',
      args: [],
    );
  }

  /// `Waiting Project Resistration`
  String get waiting_project_resistration {
    return Intl.message(
      'Waiting Project Resistration',
      name: 'waiting_project_resistration',
      desc: '',
      args: [],
    );
  }

  /// `Create new registration`
  String get create_reg_proj {
    return Intl.message(
      'Create new registration',
      name: 'create_reg_proj',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any registration`
  String get no_reg_proj {
    return Intl.message(
      'You don\'t have any registration',
      name: 'no_reg_proj',
      desc: '',
      args: [],
    );
  }

  /// `Registration information`
  String get reg_info {
    return Intl.message(
      'Registration information',
      name: 'reg_info',
      desc: '',
      args: [],
    );
  }

  /// `Sell contract number`
  String get sell_contract_num {
    return Intl.message(
      'Sell contract number',
      name: 'sell_contract_num',
      desc: '',
      args: [],
    );
  }

  /// `Enter sell contract number`
  String get enter_sell_contract_num {
    return Intl.message(
      'Enter sell contract number',
      name: 'enter_sell_contract_num',
      desc: '',
      args: [],
    );
  }

  /// `Search an apartment`
  String get search_apartment {
    return Intl.message(
      'Search an apartment',
      name: 'search_apartment',
      desc: '',
      args: [],
    );
  }

  /// `Register resident sucessfully`
  String get success_reg_res {
    return Intl.message(
      'Register resident sucessfully',
      name: 'success_reg_res',
      desc: '',
      args: [],
    );
  }

  /// `System suport`
  String get sys_support {
    return Intl.message(
      'System suport',
      name: 'sys_support',
      desc: '',
      args: [],
    );
  }

  /// `Approved status`
  String get appoved_status {
    return Intl.message(
      'Approved status',
      name: 'appoved_status',
      desc: '',
      args: [],
    );
  }

  /// `Result date`
  String get result_date {
    return Intl.message(
      'Result date',
      name: 'result_date',
      desc: '',
      args: [],
    );
  }

  /// `Note content`
  String get note_content {
    return Intl.message(
      'Note content',
      name: 'note_content',
      desc: '',
      args: [],
    );
  }

  /// `Account type`
  String get account_type {
    return Intl.message(
      'Account type',
      name: 'account_type',
      desc: '',
      args: [],
    );
  }

  /// `Resident account`
  String get resident_account {
    return Intl.message(
      'Resident account',
      name: 'resident_account',
      desc: '',
      args: [],
    );
  }

  /// `Guest account`
  String get guest_account {
    return Intl.message(
      'Guest account',
      name: 'guest_account',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message(
      'Owner',
      name: 'owner',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get guest {
    return Intl.message(
      'Guest',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Resident`
  String get resident {
    return Intl.message(
      'Resident',
      name: 'resident',
      desc: '',
      args: [],
    );
  }

  /// `Payment period`
  String get shelflife_money {
    return Intl.message(
      'Payment period',
      name: 'shelflife_money',
      desc: '',
      args: [],
    );
  }

  /// `Pay construction fee`
  String get pay_construction_fee {
    return Intl.message(
      'Pay construction fee',
      name: 'pay_construction_fee',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete your account`
  String get confirm_delete_account {
    return Intl.message(
      'Do you want to delete your account',
      name: 'confirm_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get delete_account {
    return Intl.message(
      'Delete account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `You have already deleted your account`
  String get already_delete_acc {
    return Intl.message(
      'You have already deleted your account',
      name: 'already_delete_acc',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Extend letter`
  String get extend_letter {
    return Intl.message(
      'Extend letter',
      name: 'extend_letter',
      desc: '',
      args: [],
    );
  }

  /// `don't have any extend letter`
  String get no_extend_letter {
    return Intl.message(
      'don\'t have any extend letter',
      name: 'no_extend_letter',
      desc: '',
      args: [],
    );
  }

  /// `Construction extension`
  String get construction_extend {
    return Intl.message(
      'Construction extension',
      name: 'construction_extend',
      desc: '',
      args: [],
    );
  }

  /// `Start date extension`
  String get start_date_extend {
    return Intl.message(
      'Start date extension',
      name: 'start_date_extend',
      desc: '',
      args: [],
    );
  }

  /// `End date extension`
  String get end_date_extend {
    return Intl.message(
      'End date extension',
      name: 'end_date_extend',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message(
      'Reason',
      name: 'reason',
      desc: '',
      args: [],
    );
  }

  /// `Send construction extension successfully`
  String get send_extension_success {
    return Intl.message(
      'Send construction extension successfully',
      name: 'send_extension_success',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cancel letter {c}`
  String confirm_cancel_cons_ext(Object c) {
    return Intl.message(
      'Do you want to cancel letter $c',
      name: 'confirm_cancel_cons_ext',
      desc: '',
      args: [c],
    );
  }

  /// `Cancel construcion extension letter successfully`
  String get success_cancel_cons_ext {
    return Intl.message(
      'Cancel construcion extension letter successfully',
      name: 'success_cancel_cons_ext',
      desc: '',
      args: [],
    );
  }

  /// `wait confirm extend letter`
  String get wait_extend_letter {
    return Intl.message(
      'wait confirm extend letter',
      name: 'wait_extend_letter',
      desc: '',
      args: [],
    );
  }

  /// `Start construcion date`
  String get cons_start_date {
    return Intl.message(
      'Start construcion date',
      name: 'cons_start_date',
      desc: '',
      args: [],
    );
  }

  /// `Finish construcion date`
  String get cons_end_date {
    return Intl.message(
      'Finish construcion date',
      name: 'cons_end_date',
      desc: '',
      args: [],
    );
  }

  /// `Environment fee`
  String get env_fee {
    return Intl.message(
      'Environment fee',
      name: 'env_fee',
      desc: '',
      args: [],
    );
  }

  /// `Receipt`
  String get receipt {
    return Intl.message(
      'Receipt',
      name: 'receipt',
      desc: '',
      args: [],
    );
  }

  /// `Revenues`
  String get revenues {
    return Intl.message(
      'Revenues',
      name: 'revenues',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from_date {
    return Intl.message(
      'From',
      name: 'from_date',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to_date {
    return Intl.message(
      'To',
      name: 'to_date',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any receipt`
  String get no_receipt {
    return Intl.message(
      'Don\'t have any receipt',
      name: 'no_receipt',
      desc: '',
      args: [],
    );
  }

  /// `transaction code`
  String get transaction_code {
    return Intl.message(
      'transaction code',
      name: 'transaction_code',
      desc: '',
      args: [],
    );
  }

  /// `Money`
  String get money {
    return Intl.message(
      'Money',
      name: 'money',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
