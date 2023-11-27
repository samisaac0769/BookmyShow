$(document).ready(function () {
    //$("#loginOtpContent").hide();

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

    $("#countinue").on("click", function (e) {
        e.preventDefault();

        // $("#loginFormContent").hide();
        // $("#loginOtpContent").show();
        
        // Toggle the visibility of the two modal contents
        $("#loginFormContent").toggle();
        $("#loginOtpContent").toggle();
        let loginumber = $('#mobileNo').val(); 
        $.ajax({
            url: "Components/nav_bar.cfc?method=signup",
            type: "post",
            data: {
                loginNumber: loginumber
            },
            success: function (data) {
                //var value = $(data).find('string').text();
                //alert(value)
            }
        });
    });
});

function handleInput(currentInput, event) {
    var x = event.which || event.keyCode;
    if ((x >= 48 && x <= 57)) {
        if (currentInput.value.length === 1) {
            var nextInput = currentInput.nextElementSibling;
            if (nextInput) {
                nextInput.focus();
            }
        }
    }
    else {
        event.preventDefault();
        return false;
    }
        // Move to the next input when a character is entered
        
    }

    function handleBackspace(currentInput,event) {
        // Prevent backspace from moving to the previous input unless the current input is empty
        if (event.code === 'Backspace' && currentInput.value.length === 0) {
            var previousInput = currentInput.previousElementSibling;
            if (previousInput) {
                previousInput.focus();
            }
        }
    }




