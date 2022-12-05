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

  /// `We have sent OTP code to your registered phone number or email. Please enter the OTP code to perform authentication.`
  String get otp_msg {
    return Intl.message(
      'We have sent OTP code to your registered phone number or email. Please enter the OTP code to perform authentication.',
      name: 'otp_msg',
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

  /// `Identity card/ passport photos`
  String get identity_photo {
    return Intl.message(
      'Identity card/ passport photos',
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

  /// `Do you want to delete {delete}?`
  String confirm_delete_service(Object delete) {
    return Intl.message(
      'Do you want to delete $delete?',
      name: 'confirm_delete_service',
      desc: '',
      args: [delete],
    );
  }

  /// `Do you want to delete letter {letter}?`
  String confirm_delete_letter(Object letter) {
    return Intl.message(
      'Do you want to delete letter $letter?',
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

  /// `Send to approve request successfully`
  String get success_send_req {
    return Intl.message(
      'Send to approve request successfully',
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

  /// `Remove {del} successfully`
  String success_remove(Object del) {
    return Intl.message(
      'Remove $del successfully',
      name: 'success_remove',
      desc: '',
      args: [del],
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

  /// `Do you want to send to approve {approved}?`
  String confirm_send_request(Object approved) {
    return Intl.message(
      'Do you want to send to approve $approved?',
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

  /// `Do you want to cancel request letter {code}`
  String confirm_cancel_request(Object code) {
    return Intl.message(
      'Do you want to cancel request letter $code',
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

  /// `Do you want to lock card {card}?`
  String confirm_lock_card(Object card) {
    return Intl.message(
      'Do you want to lock card $card?',
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

  /// `Ngày bắt đầu không được để trống`
  String get start_date_not_empty {
    return Intl.message(
      'Ngày bắt đầu không được để trống',
      name: 'start_date_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Ngày kết thúc không được để trống`
  String get end_date_not_empty {
    return Intl.message(
      'Ngày kết thúc không được để trống',
      name: 'end_date_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Ngày bắt đầu không được nhỏ hơn ngày hiện tại`
  String get start_date_after_now {
    return Intl.message(
      'Ngày bắt đầu không được nhỏ hơn ngày hiện tại',
      name: 'start_date_after_now',
      desc: '',
      args: [],
    );
  }

  /// `Ngày kết thúc không được nhỏ hơn ngày hiện tại`
  String get end_date_after_now {
    return Intl.message(
      'Ngày kết thúc không được nhỏ hơn ngày hiện tại',
      name: 'end_date_after_now',
      desc: '',
      args: [],
    );
  }

  /// `Ngày kết thúc không được nhỏ hơn ngày bắt đầu`
  String get end_date_after_start_date {
    return Intl.message(
      'Ngày kết thúc không được nhỏ hơn ngày bắt đầu',
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
