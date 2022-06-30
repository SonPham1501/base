import 'package:base/src/Extends/StringExtend.dart';
import 'package:base/src/Model/InputOptionObject.dart';
import 'package:base/src/Utils/flutter_base/Util.dart';

class BaseValidateUtil {
  static bool isValidEmail(String value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  static bool isValidPhone(String value) {
    RegExp regex = RegExp(r'(^(?:[+])?[0-9]{10,12}$)');
    return regex.hasMatch(value);
  }

  static bool isValidUrl(String url) {
    bool _validURL = Uri.parse(url).isAbsolute;
    return _validURL;
  }

  static InputOptionObject validatePhoneNumber(String phoneNumber,
      {bool isPrimary = true}) {
    var option = InputOptionObject();
    if (phoneNumber.isEmpty) {
      option.isError = true;
      option.message = "Số điện thoại không được để trống!";
    } else {
      if (phoneNumber.isNotEmpty) {
        var split = phoneNumber.substring(0, 1);
        if (split != "0") {
          option.isError = true;
          option.message = "Số điện thoại không đúng định dạng";
          return option;
        }
      }
      if (phoneNumber.length > 1) {
        var split = phoneNumber.substring(0, 2);
        if (split == "00" || split == "01" || split == "02" || split == "06") {
          print("split $split");
          option.isError = true;
          option.message = "Số điện thoại không đúng định dạng";
          return option;
        }
      }
      var phone = double.tryParse(phoneNumber);
      if (phone == null) {
        print("phone $phone");

        option.isError = true;
        option.message = "Số điện thoại không đúng định dạng";
      } else if (phoneNumber.length < 10) {
        option.isError = true;
        option.message = "Số điện thoại không đúng định dạng";
      } else {
        option.isError = false;
      }
    }
    return option;
  }

  static InputOptionObject validateEmail(String email) {
    var option = InputOptionObject();
    if (email.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập email!";
    } else {
      if (!isValidEmail(email.trim())) {
        option.isError = true;
        option.message = "Email không đúng định dạng!";
      } else {
        option.isError = false;
      }
    }
    return option;
  }

  static InputOptionObject validateEmailOptional(String email) {
    var option = InputOptionObject();
    if (email.trim().isEmpty) {
      option.isError = false;
      option.message = "";
    } else {
      if (!isValidEmail(email.trim())) {
        option.isError = true;
        option.message = "Email không đúng định dạng!";
      } else {
        option.isError = false;
      }
    }
    return option;
  }

  static bool _validateStructure(String value) {
    // Ít nhất một chữ cái viết hoa
    // Ít nhất một chữ cái viết thường
    // Ít nhất một chữ số
    // Ít nhất một nhân vật đặc biệt
    // Chiều dài tối thiểu tám
    String pattern =
        r"^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static InputOptionObject validatePassword(
      String password, InputOptionObject option) {
    if (password.length < 8) {
      option.isError = true;
      option.message = "Mật khẩu phải lớn hơn 8 ký tự!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateUserName(
      String userName, InputOptionObject option) {
    if (userName.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập tên đăng nhập!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateUserNameEmail(
      String userName, InputOptionObject option) {
    if (userName.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập email hoặc tên đăng nhập!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validatePasswordLogin(
    String password,
  ) {
    var option = InputOptionObject();
    if (password.isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập mật khẩu!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateReNewPassword(
      String password, String newPassword) {
    var option = InputOptionObject();

    if (password != newPassword) {
      option.isError = true;
      option.message = "Nhập lại mật khẩu mới phải giống với mật khẩu mới!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateFullName(String fullName) {
    var option = InputOptionObject();
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập họ và tên!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateContentReportChat(String content) {
    var option = InputOptionObject();
    if (content.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập nội dung!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateFirstName(String fullName) {
    var option = InputOptionObject();
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập tên!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateLastName(String fullName) {
    var option = InputOptionObject();
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập họ!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static fullNameValidate(String fullName) {
    String patttern = r'^[a-z ,.\-]+$';
    RegExp regExp = RegExp(patttern);
    var option = InputOptionObject();
    if (fullName.isEmpty) {
      option.message = 'Chưa nhập họ và tên';
      option.isError = true;
    }
    // else if (!regExp.hasMatch(fullName)) {
    //   option.message = 'Họ và tên không được bao gồm kí tự đặc biệt!';
    //   option.isError = true;
    // }
    else {
      option.message = "";
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateOTP(String otp, InputOptionObject option) {
    if (otp.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập mã xác thực";
    } else if (otp.trim().length < 6) {
      option.isError = true;
      option.message = "Mã xác thực không hợp lệ";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateTax(String otp, InputOptionObject option) {
    if (otp.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập tax!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateCMT(
      String fullName, InputOptionObject option) {
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = "Trường này là bắt buộc!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateNotEmpty(
      String fullName, InputOptionObject option) {
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = "Trường này là bắt buộc!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateNormalFeild(
      String fullName, InputOptionObject option, String errorName,
      {String? mess}) {
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = mess ?? "$errorName không được bỏ trống";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateEmailAndPhone(
    String fullName,
  ) {
    var option = InputOptionObject();
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập Số điện thoại/Email";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateNewPassword(
    String password,
  ) {
    var option = InputOptionObject();
    if (password.isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập mật khẩu!";
    } else {
      bool validatePassword = requiredPassword(password);
      if (!validatePassword) {
        option.isError = true;
        option.message =
            "Mật khẩu phải bao gồm ký tự số từ ('0'-'9') và tối thiểu 6 ký tự";
      } else {
        option.isError = false;
      }
    }
    return option;
  }

  static bool requiredPassword(String value) {
    var pattern = r'^(?=.*?[0-9]).{6,}$';

    // var pattern =
    //     '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}\$';

    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static InputOptionObject validatePricePayment(String value) {
    var option = InputOptionObject();
    if (value.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập số tiền";
    } else {
      value = value.replaceAll(",", "");
      if (value.toInt() == null) {
        option.isError = true;
        option.message = "Số tiền không đúng định dạng";
      } else if (value.toInt()! < 50000 || value.toInt()! > 50000000) {
        option.isError = true;
        option.message = "Số tiền từ 50,000 đến 50,000,000 đ";
      }
    }
    return option;
  }

  static InputOptionObject validateBankNumber(String value) {
    var option = InputOptionObject();
    if (value.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập số tài khoản";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateBankAccountHolder(String value) {
    var option = InputOptionObject();
    if (value.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập chủ tài khoản";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateBankBranch(String value) {
    var option = InputOptionObject();
    if (value.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập chi nhánh";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validatePriceWithDraw(String value, int maxPrice) {
    var option = InputOptionObject();
    if (value.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập số tiền";
    } else {
      if (value.toInt() == null) {
        option.isError = true;
        option.message = "Số tiền không đúng định dạng";
      } else if (value.toInt()! < 300000 || value.toInt()! > maxPrice) {
        option.isError = true;
        option.message =
            "Số tiền từ 300.000 đến ${Util.intToPriceDouble(maxPrice)} đ";
      } else if (value.toInt()! % 1000 != 0) {
        option.isError = true;
        option.message = "Số tiền phải là bội số của 1.000 đ";
      }
    }
    return option;
  }

  static InputOptionObject validateDienTich(String value) {
    value = value.replaceAll(",", "");
    var option = InputOptionObject();
    if (value.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập diện tích";
    } else {
      if (value.toDouble() == null) {
        option.isError = true;
        option.message = "Diện thích không đúng định dạng";
      }
    }
    return option;
  }

  static InputOptionObject validateChieuRong(String value) {
    value = value.replaceAll(",", "");
    var option = InputOptionObject();
    if (value.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập chiều rộng";
    } else {
      if (value.toDouble() == null) {
        option.isError = true;
        option.message = "Chiều rộng không đúng định dạng";
      }
    }
    return option;
  }

  static InputOptionObject validateChieuSau(String value) {
    value = value.replaceAll(",", "");
    var option = InputOptionObject();
    if (value.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập chiều sâu";
    } else {
      if (value.toDouble() == null) {
        option.isError = true;
        option.message = "Chiều sâu không đúng định dạng";
      }
    }
    return option;
  }

  static InputOptionObject validateSoPhongNgu(String value) {
    value = value.replaceAll(",", "");
    var option = InputOptionObject();
    if (value.trim().isEmpty) {
      option.isError = true;
      option.message = "Chưa nhập số phòng ngủ";
    } else {
      if (value.toInt() == null) {
        option.isError = true;
        option.message = "Số phòng ngủ không đúng định dạng";
      }
    }
    return option;
  }

  static InputOptionObject validateSoPhongTam(String value) {
    value = value.replaceAll(",", "");
    var option = InputOptionObject();
    if (value.trim().isNotEmpty) {
      if (value.toInt() == null) {
        option.isError = true;
        option.message = "Số phòng tắm không đúng định dạng";
      }
    }
    return option;
  }

  static bool isValidUrlYoutube(String url) {
    if (url.isEmpty) {
      return false;
    }
    final RegExp pattern = RegExp(
        r'^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$');
    final bool match = pattern.hasMatch(url);

    return match;
  }

  static InputOptionObject validateUrlYoutubeOptional(String value) {
    var option = InputOptionObject();
    if (value.trim().isNotEmpty) {
      if (!isValidUrlYoutube(value.trim())) {
        option.isError = true;
        option.message = "Link Youtube không đúng định dạng!";
      } else {
        option.isError = false;
      }
    }
    return option;
  }
}
