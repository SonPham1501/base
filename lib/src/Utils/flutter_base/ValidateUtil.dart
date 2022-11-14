import 'package:base/src/Model/export_model.dart';
class ValidateUtil {
  static bool isValidEmail(String value) {
    var pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  static bool isValidSpecialCharacters(String value) {
    List<String> convert8 = "!|@|%|^|*|(|)|+|=|<|>|?|/|,|.|:|;|'|\"|&|#|[|]|~|\$|_|`|-|{|}|||\\".split('|')..add('|');
    for (int i = 0; i < value.length; i++) {
      if (convert8.contains(value[i])) {
        return false;
      }
    }
    return true;
  }

  static bool isValidPhone(String value) {
    RegExp regex = RegExp(r'(^(?:[+])?[0-9]{10,12}$)');
    return regex.hasMatch(value);
  }

  static bool isValidUrl(String url) {
    bool _validURL = Uri.parse(url).isAbsolute;
    return _validURL;
  }

  static InputOptionObject validatePhoneNumber(String phoneNumber, {bool isPrimary = true}) {
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

          option.isError = true;
          option.message = "Số điện thoại không đúng định dạng";
          return option;
        }
      }
      var phone = double.tryParse(phoneNumber);
      if (phone == null) {


        option.isError = true;
        option.message = "Số điện thoại không đúng định dạng";
      } else if (phoneNumber.length != 10) {
        option.isError = true;
        option.message = "Số điện thoại không đúng định dạng";
      } else {
        option.isError = false;
      }
    }

    return option;
  }

  static InputOptionObject validateEmail(String email) {

     var  option = InputOptionObject();
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

  static InputOptionObject validateEmailOptional(String email, InputOptionObject option) {
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
    String pattern = r"^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static InputOptionObject validatePassword(String password, InputOptionObject option) {
    if (password.length < 8) {
      option.isError = true;
      option.message = "Mật khẩu phải lớn hơn 8 ký tự!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateUserName(String userName, InputOptionObject option) {
    if (userName.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập tên đăng nhập!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateUserNameEmail(String userName, InputOptionObject option) {
    if (userName.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập email hoặc tên đăng nhập!";
    } else {
      option.isError = false;
    }
    return option;
  }


  static InputOptionObject validatePasswordLogin(String password,) {
    var  option = InputOptionObject();
    if (password.isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập mật khẩu!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateReNewPassword(String password, String newPassword) {
    var  option = InputOptionObject();
    if (password != newPassword) {
      option.isError = true;
      option.message = "Nhập lại xác nhận mật khẩu phải giống với mật khẩu!";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateFullName(String fullName) {
    var option = InputOptionObject();
    final isNotSpeccialCharacter = !isValidSpecialCharacters(fullName);
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = "Trường này là bắt buộc!";
    } else if (fullName.trim().isNotEmpty && !fullName.trim().contains(" ")) {
      option.isError = true;
      option.message = "Tên phải bao gồm họ và tên";
    } else if (isNotSpeccialCharacter) {
      option.isError = true;
      option.message = 'Tên không được chứa ký tự đặc biệt';
    } else {
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

  static InputOptionObject validateCMT(String fullName, InputOptionObject option) {
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = "Trường này là bắt buộc!";
    } else {
      option.isError = false;
    }
    return option;
  }
  static InputOptionObject validateEmailAndPhone(String fullName,) {
    var  option = InputOptionObject();
    if (fullName.trim().isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập Số điện thoại/Email";
    } else {
      option.isError = false;
    }
    return option;
  }

  static InputOptionObject validateNewPassword(String password,) {
    var  option = InputOptionObject();
    if (password.isEmpty) {
      option.isError = true;
      option.message = "Bạn chưa nhập mật khẩu!";
    } else {
      bool validatePassword = requiredPassword(password);
      if(!validatePassword) {
        option.isError = true;
        option.message = "Mật khẩu phải bao gồm ký tự số từ ('0'-'9') và tối thiểu 6 ký tự";
      }else{
        option.isError = false;
      }
    }
    return option;
  }
   static bool requiredPassword(String value) {
    var pattern =r'^(?=.*?[0-9]).{6,}$';

    // var pattern =
    //     '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}\$';

    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

}
