var interval;
var  otp;

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
        $("#loginFormContent").toggle();
        $("#loginOtpContent").toggle();

        $('#otp1').focus();
        clearInterval(interval);
        let otp = otpGenerater();
        startCountdown();
        otpValidation(otp);
    });

    $('#loginBack').click(function (e) {
        e.preventDefault();
        // Toggle the visibility of the two modal contents
        $("#loginFormContent").toggle();
        $("#loginOtpContent").toggle();
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
                url: "Components/nav_bar.cfc?method=signup",
                type: "post",
                data: {
                    loginNumber: phoneNumber
                },
                success: function (data) {
                    // console.log(data);
                    // alert("success")
                    $('#otpError').text("");
                    $('.jLBVFy').val("");
                    $("#loginFormContent").toggle();
                    $("#loginOtpContent").toggle();
                    $('#myModal').modal('hide')
                    document.location.href = 'demo.cfm';
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


