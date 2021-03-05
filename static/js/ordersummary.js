$(document).ready(function()
{

$("#btnApplyServiceDiscount").click(function()
{
    discountCode = $("#discountCodeForService").val();
    totalServiceAmount = document.getElementById('lblTotalService').innerHTML;
    totalInitialSetupAmount = document.getElementById('lblTotalInitialSetupCharge').innerHTML;
    totalAmount = document.getElementById('lblTotalAmountFull').innerHTML;

    $.ajax({
        url : "/applyDiscountOnService/", // the endpoint
        type : "POST", // http method
        dataType : "json",
        data : { 'discountCode': discountCode, 'totalServiceAmount' : totalServiceAmount,
                  'totalInitialSetupAmount': totalInitialSetupAmount,
                   'totalAmount': totalAmount}, // data sent with the post request
        headers:{
                'X-CSRFToken' : csrftoken
            },
        // handle a successful response
        success : function(response) {
            $("#dvServiceDiscount").show();
            $("#spnDiscountFailForService").hide();
            $("#spnDiscountSuccessForService").show();
            $("#btnApplyServiceDiscount").hide();
            document.getElementById('lblServiceDiscount').innerHTML = response["discountCodeAmout"].toFixed(2)
            document.getElementById('lblTotalAmountFull').innerHTML = response["amountAfterDiscount"].toFixed(2)
            document.getElementById('lblServiceDiscountPercentage').innerHTML = response["discountPercentage"]
            document.getElementById('lblServiceDiscountId').innerHTML = response["id"]
        },

        // handle a non-successful response
        error : function(xhr,errmsg,err) {
             $("#spnDiscountSuccessForService").hide();
             $("#spnDiscountFailForService").show();
             $("#discountCodeForService").val('');
        }
    });
});

$("#btnApplyProductDiscount").click(function()
{
    discountCode = $("#discountCodeForProduct").val();
    totalProductAmount = document.getElementById('lblTotalProduct').innerHTML;
    totalAmount = document.getElementById('lblTotalAmountFull').innerHTML;

    $.ajax({
        url : "/applyDiscountOnProduct/", // the endpoint
        type : "POST", // http method
        dataType : "json",
        data : { 'discountCode': discountCode, 'totalAmount' : totalAmount, 'totalProductAmount': totalProductAmount  }, // data sent with the post request
        headers:{
                'X-CSRFToken' : csrftoken
            },
        // handle a successful response
        success : function(response) {
            $("#dvProductDiscount").show();
            $("#spnDiscountFailForProduct").hide();
            $("#spnDiscountSuccessForProduct").show();
            $("#btnApplyProductDiscount").hide();
            document.getElementById('lblProductDiscount').innerHTML = response["discountCodeAmout"].toFixed(2)
            document.getElementById('lblTotalAmountFull').innerHTML = response["amountAfterDiscount"].toFixed(2)
            document.getElementById('lblProductDiscountPercentage').innerHTML = response["discountPercentage"]
        },

        // handle a non-successful response
        error : function(xhr,errmsg,err) {
             $("#spnDiscountSuccessForProduct").hide();
             $("#spnDiscountFailForProduct").show();
             $("#discountCodeForProduct").val('');
        }
    });
});

});