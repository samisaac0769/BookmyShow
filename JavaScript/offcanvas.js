$(document).ready(function () {
    
});

function logout() {
    $.ajax({
        url: "Components/offcanvas.cfc?method=logout",
        type: "post",
        success: function (data) {
            let result = $(data).find("boolean").attr("value");

            if (result === "true") {
                document.location.href = 'firstpage.cfm';
            }
        }
    });
}