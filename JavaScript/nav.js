var interval;
var otp;

$(document).ready(function () {
    $("#loginOtpContent").hide();
    // $('#resent').hide();

    $("#loginclose").click(function () {
        $('#mobileNo').css('border-bottom-color', 'rgb(204, 204, 204)');
        $("#mobileNo").val("");

    });

    document.getElementById("countinue").setAttribute("disabled", "disabled");
    // allow only numbers when u try to  enter a value
    $("#mobileNo").on("keypress", function (e) {
        $('#mobileNo').css('border-bottom-color', 'rgb(248, 68, 100)');

        var x = e.which || e.keycode;
        if ((x >= 48 && x <= 57)) {
            $("#mobileNo").on("input", function () {
                let loginumber = $(this).val();
                let phonepatten = /^[6-9]\d{9}$/;
                if (phonepatten.test(loginumber)) {
                    $('#countinue').prop('disabled', false);
                    $('#countinue').css('background-color', 'rgb(248, 68, 100)');

                } else {
                    $('#countinue').prop('disabled', true);
                    $('#countinue').css('background-color', 'rgb(204, 204, 204)');
                }
            });
        }
        else {
            return false;
        }
    });

    document.getElementById("secCountinue").setAttribute("disabled", "disabled");
    $("#countinue").on("click", function (e) {
        e.preventDefault();
        // Toggle the visibility of the two modal contents

        $("#loginFormContent").hide();
        $("#loginOtpContent").show();
        // $("#loginFormContent").toggle();
        // $("#loginOtpContent").toggle();

        $('#otp1').focus();
        clearInterval(interval);
        let otp = otpGenerater();
        startCountdown();
        otpValidation(otp);
    });

    $('#loginBack').click(function (e) {
        e.preventDefault();
        // Toggle the visibility of the two modal contents
        // $("#loginFormContent").toggle();
        // $("#loginOtpContent").toggle();

        $("#loginOtpContent").hide();
        $("#loginFormContent").show();
        // Clear the interval
        clearInterval(interval);

        $("#mobileNo").val('');
        $('#countinue').prop('disabled', true);
        $('#countinue').css('background-color', 'rgb(204, 204, 204)');
    });

    $('#otpResend').on("click", function () {
        clearInterval(interval);
        $('#otp1').focus();
        let otp = otpGenerater();
        startCountdown();
        otpValidation(otp);
    });

    $("#secCountinue").on("click", function (e) {
        
        e.preventDefault();
        let inputOTP = $("#otp1").val() + $("#otp2").val() + $("#otp3").val() + $("#otp4").val() + $("#otp5").val() + $("#otp6").val();
        if (inputOTP.trim() == otp) {
            clearInterval(interval);
            let phoneNumber = $("#mobileNo").val();
            $.ajax({
                url: "Components/nav_bar.cfc?method=login",
                type: "post",
                data: {
                    loginNumber: phoneNumber
                },
                success: function (data) {
                    // console.log(data);
                    let result = $(data).find("string").text();
                    //alert(result);
                    
                    if (result == "true") {
                        $('#otpError').text("");
                        $('.jLBVFy').val("");
                        $("#loginFormContent").toggle();
                        $("#loginOtpContent").toggle();
                        $('#myModal').modal('hide');
                        // $('.admin-btn').css("display", "none");
                        // $('.userLoged').css("display", "block");
                        document.location.href = 'firstpage.cfm';
                    }
                    // else if (result == "2") {
                    //     $('#otpError').text("");
                    //     $('.jLBVFy').val("");
                    //     $("#loginFormContent").toggle();
                    //     $("#loginOtpContent").toggle();
                    //     $('#myModal').modal('hide');
                    //     $('.userLoged').css("display", "none");
                    //     $('.admin-btn').css("display", "block");
                    //     document.location.href = 'demo.cfm';
                    // }
                    else {
                        // alert("You ve");
                        // document.location.href = 'demo.cfm';
                        $('#myModal').modal('hide');
                        $('#otpError').text("");
                        $('.jLBVFy').val("");
                        $('#mobileNo').val("");
                        $("#loginFormContent").toggle();
                        $("#loginOtpContent").toggle();
                        $('#signInModal').modal('show');
                    }
                }
            });


        }
        else {
            $('.jLBVFy').val("");
            $('#secCountinue').prop('disabled', true);
            $('#otpError').text("Invalid OTP entered. Please try again");
            $("#secCountinue").css({
                'background-color': 'rgb(248, 68, 100)',
                'visibility': 'hidden'
            });
            clearInterval(interval);
            $('#timer').hide();
            $('#resent').show();
        }
    });

    $("#signInFrom").on("click", function (e) {
        var username = document.getElementById('signName').value.trim();
        var phone = document.getElementById('signphone').value.trim();
        var email = document.getElementById('sign').value.trim();
        var role = document.getElementById('roleid').value.trim();
        let valid = validateForm(e);
        if (valid == true) {
            
            $.ajax({
                url: "Components/nav_bar.cfc?method=signIn",
                type: "post",
                data: {
                    userName: username,
                    phoneNo: phone,
                    emailId: email,
                    roleId: role
                },
                success: function (data) {
                    // console.log(data);
                    let result = $(data).find("boolean").attr("value");
                    //alert(result);

                    if (result == "false") {
                        alert("User Registered Successfully....");
                    }
                    else {
                        alert("User Aleady Exist");
                    }
                }
            });
        }
        
    });


    //search operation
    $("#searchbox").keypress(function (e) {
        var key = e.which;
        if (key == 13)  // the enter key code
        {
            let search = $("#searchbox").val();
            console.log(search);
            $.ajax({
                url: "Components/eventfilter.cfc?method=search",
                type: "post",
                data: {
                    searchword: search
                },
                success: function (responce) {
                    
                    let result = $(responce).find("string").text();
                    // var intValue = parseInt(result);
                    console.log(result);
                    document.location.href = result;
                }
                // },
                // error: function (error) {
                //     alert("Something went wrong");
                // }
            });
        }
    })
    
});

function startCountdown() {
    $('#resent').hide();
    //clearInterval(interval);
    var countdown = 30; // 60 seconds = 1 minute
    var timeDisplay = document.getElementById("timer");

    function updateCountdown() {
        if (countdown > 0) {
            $('#timer').show();
            // timeDisplay.textContent = "Expect OTP in  " + countdown + " seconds";
            timeDisplay.innerHTML = "Expect OTP in <span style='font-weight: bold;'>" + countdown + "</span> seconds";
            countdown--;
        } else {
            timeDisplay.style.display = "none";
            clearInterval(interval);
            timeDisplay.style.width = "auto";
            timeDisplay.style.padding = "5px";
            $('#resent').show();
        }
    }

    updateCountdown();
    interval = setInterval(updateCountdown, 1000); // Update every second

    // Return the countdown value
    return countdown;
}

function otpValidation(genOtp) {

    $('.jLBVFy').on('input', function () {

        let inputOTP = $("#otp1").val() + $("#otp2").val() + $("#otp3").val() + $("#otp4").val() + $("#otp5").val() + $("#otp6").val();

        if (inputOTP.trim().length === 6) {
            $('#secCountinue').prop('disabled', false);
            $("#secCountinue").css({
                'background-color': 'rgb(248, 68, 100)',
                'visibility': 'visible'
            });
        }
        else if (inputOTP.length < 6) {
            $('#secCountinue').prop('disabled', true);
            $("#secCountinue").css({
                'background-color': 'rgb(248, 68, 100)',
                'visibility': 'hidden'
            });
        }
    });
}

function handleInput(currentInput) {
    var inputValue = currentInput.value.replace(/\D/g, '');

    // Check if input value is not empty
    if (inputValue.length === 1) {
        var nextInput = currentInput.nextElementSibling;

        // Check if there is a next input
        if (nextInput && nextInput.tagName === 'INPUT' && nextInput.type === 'tel') {
            nextInput.focus();
        }
    }
    // Clear the value if it's not a digit
    currentInput.value = inputValue;
}

function handleBackspace(currentInput, event) {
    // Clear the current input and move to the previous input on backspace
    if (event.code === 'Backspace') {
        currentInput.value = ''; // Clear the current input
        var previousInput = currentInput.previousElementSibling;
        if (previousInput) {
            //previousInput.value = ''; // Clear the previous input
            previousInput.focus(); // Move focus to the previous input
        }
    }
}

// function handleBackspace(currentInput, event) {
//     // Prevent backspace from moving to the previous input unless the current input is empty
//     if (event.code === 'Backspace' && currentInput.value.length === 0) {
//         var previousInput = currentInput.previousElementSibling;
//         if (previousInput) {
//             previousInput.focus();
//         }
//     }
// }

function otpGenerater() {
    otp = Math.floor(Math.random() * 900000) + 100000;
    alert(otp)
    return otp;
}

//Signup forms validation
function numberCheck(e) {
    var x = e.which || e.keyCode;

    // Allow backspace (8) and delete (46)
    if (x === 8 || x === 46) {
        return true;
    }

    // Allow numeric keys (0-9) from the main keyboard and numeric keypad
    if ((x >= 48 && x <= 57) || (x >= 96 && x <= 105)) {
        return true;
    } else {
        e.preventDefault();
        return false;
    }
}

function nameCheck(e) {
    var key = e.key;

    // Allow backspace (8) and delete (46)
    if (key === 'Backspace' || key === 'Delete') {
        return true;
    }

    // Allow letters (A-Z, both uppercase and lowercase) and space
    if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z') || key === ' ') {
        return true;
    } else {
        e.preventDefault();
        return false;
    }
}

function mailValidation(element) {
    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$/;

    if (emailRegex.test(element.value)) {
        $("#mailerror").text("");
        return true;
    } else {
        $("#mailerror").text("Invalid email address");
        return false;
    }
}

function nameValidation() {
    var username = document.getElementById('signName').value.trim();

    if (username == "") {
        $("#namerror").text("Name Required");
        return false
    }
    else {
        $("#namerror").text("");
        return true;
    }
}

function phoneValidation() {
    var phone = document.getElementById('signphone').value.trim();
    const phoneRegex = /^[6-9]\d{9}$/;
    if (phone == "") {
        $("#numberror").text("Phone Number Required");
        return false;
    }
    else if (!phoneRegex.test(phone)) {
        $("#numberror").text("Invalid phone number");
        return false;
    }
    else {
        $("#numberror").text("");
        return true;
    }
}

function mailIdValidation() {
    var email = document.getElementById('sign').value.trim();

    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$/;

    if (email == "") {
        $("#mailerror").text("Email address Required");
        return false;
    }
    else if (!emailRegex.test(email)) {
        $("#mailerror").text("Invalid email address");
        return false;
    }
    else {
        $("#mailerror").text("");
        return true;
    }
}

function validateForm(e) {
    


    var isname = nameValidation();
    var isphone = phoneValidation();
    var ismail = mailIdValidation();

    if (isname && isphone && ismail) {
        return true;
    }
    else {
        e.preventDefault();
        return false
    }
}







