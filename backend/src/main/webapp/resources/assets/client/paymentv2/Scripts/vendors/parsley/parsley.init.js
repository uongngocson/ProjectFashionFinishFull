//====================PARSLEY INIT=================//
$(function () {
   var parsleyConfig = {
      errorsContainer: function (pEle) {
         var $err = pEle.$element.parents().closest('.form-group').find('.errorBlock');
         return $err;
      },
      trigger: 'keyup blur'
   }
   $('form').each(function(){
      $(this).parsley(parsleyConfig);
   })
});
$(document).ready(function () {
   $(document).on('change','[required]', function(){
      $(this).parsley().validate();
   });
});
Parsley.addValidator('bincode', {
    validateString: function (value, requirement) {
		var clearVal = $('#cardNumber').val();
		if(clearVal === undefined){
			clearVal = $('#card_number').val();
		}
        if (clearVal.length >= 6) {
			if (requirement === 'UPI') {
				return clearVal.substr(0, 1) === '6';
			}
			if (requirement === 'MASTERCARD') {
				return clearVal.substr(0, 1) === '5';
			}
			if (requirement === 'AMEX') {
				return clearVal.substr(0, 1) === '3';
			}
			if (requirement === 'JCB') {
				return clearVal.substr(0, 2) === '33' || clearVal.substr(0, 2) === '35';
			}
			if (requirement === 'VISA') {
				return clearVal.substr(0, 1) === '3' || clearVal.substr(0, 1) === '4' || clearVal.substr(0, 1) === '5';
			}
            return clearVal.substr(0, 6) === requirement.toString();
        }
    }
});
Parsley.addMessages('vi', {
  defaultMessage: "Nhập sai giá trị.",
  type: {
    email:        "Email không hợp lệ.",
    url:          "Đường dẫn không hợp lệ.",
    number:       "Định dạng này phải là số.",
    integer:      "Định dạng này phải là số.",
    digits:       "Định dạng này phải là số.",
    alphanum:     "Định dạng này phải là chữ.",
    password:     "Mật khẩu phải bao gồm số và chữ cái"
  },
  notblank:       "Trường bắt buộc.",
  required:       "Trường bắt buộc.",
  pattern:        "Nhập sai giá trị.",
  min:            "Giá trị này phải lớn hơn hoặc bằng %s.",
  max:            "Giá trị này phải nhỏ hơn hoặc bằng to %s.",
  range:          "Giá trị phải nằm trong khoảng %s và %s.",
  minlength:      "This value is too short. It should have %s characters or more.",
  maxlength:      "This value is too long. It should have %s characters or fewer.",
  length:         "This value length is invalid. It should be between %s and %s characters long.",
  mincheck:       "You must select at least %s choices.",
  maxcheck:       "You must select %s choices or fewer.",
  check:          "You must select between %s and %s choices.",
  equalto:        "This value should be the same.",
  euvatin:        "It's not a valid VAT Identification Number.",
});

Parsley.setLocale('vi');
//====================END PARSLEY INIT=================//