$(document).ready(function()
{
/* $('input[name="paymentoption"]').change(function()
    {
        isPaybyCash = $('input[name="paymentoption"]:checked').val();
        if(isPaybyCash == "Cash")
        {
            document.getElementById('form-button').classList.remove('hidden')
            document.getElementById('cardPaymentDetails').classList.add('hidden')
        }
        else
        {
            document.getElementById('form-button').classList.remove('hidden')
            // document.getElementById('cardPaymentDetails').classList.remove('hidden')
        }
    });*/

$("#btnProceedToPayment").click(function()
{
    alert(1);
    submitFormData();
});

function ValidationBeforePayment()
{
    cardName = $("#cardName").val(); //document.getElementById('cardName').value
    cardNumber = $("#cardNumber").val(); //document.getElementById('cardNumber').value
    cardCvv = $("#cvv").val(); //document.getElementById('cvv').value
    ExpMonth = $("#month").val(); //document.getElementById('month').value
    ExpYear = $("#year").val(); //document.getElementById('year').value
    cashPayment = document.getElementById('rbtnBankTransfer').checked
    cardPayment = document.getElementById('rbtnCard').checked
    if(cardPayment == true)
    {
        if(cardName == "" || cardNumber == "" || cardNumber.length < 14 || cardCvv == "" || cardCvv.length < 3 || ExpMonth == 0 || ExpYear == 0)
        {
            alert('Please enter valid card details.')
            return false;
        }
    }
    return true;
}

function submitFormData()
{

    total =  document.getElementById('lblTotalAmountFull').innerHTML
    alert(total)
    var userInfo = {
        'name' : user,
        'email' : 'kinju1220@gmail.com', // $("#email").val(),
        'total' : parseFloat(total)
    }


    var paymentType
//    cashPayment = document.getElementById('rbtnBankTransfer').checked
//    cardPayment = document.getElementById('rbtnCard').checked
//    if(cashPayment)
//    {
//        paymentType = "Cash"
//    }
//    else if(cardPayment)
//    {
//        paymentType = "Card"
//    }
    paymentType = "Card"
    url = window.location.href;
    params = (new URL(url)).searchParams;

    var paymentInInstalment = params.get('data');
    var serviceDiscount =  document.getElementById('lblServiceDiscount').innerHTML
    var serviceDiscountPercentage = document.getElementById('lblServiceDiscountPercentage').innerHTML
    var serviceDiscountId = document.getElementById('lblServiceDiscountId').innerHTML
    var actualAmountToPay = document.getElementById('lblActualAmount').innerHTML

    var shippingInfo = {
       /* 'address' : form.address.value,
        'city' : form.city.value,
        'state' : form.state.value,
        'zipcode' : form.zipcode.value,
        'country' : form.country.value*/
    }
     $.ajax({
        url : "/placeOrder/", // the endpoint
        type : "POST", // http method
        dataType : "json",
        data : {    'User' : userInfo, 'Shipping' : shippingInfo,
                             'paymentType' : paymentType,
                             'paymentInInstalment': paymentInInstalment,
                             'serviceDiscount': serviceDiscount,
                             'serviceDiscountPercentage': serviceDiscountPercentage,
                             'serviceDiscountId': serviceDiscountId}, // data sent with the post request
        headers:{
                'X-CSRFToken' : csrftoken
            },
        // handle a successful response
        success : function(response) {
           console.log('res: ', response)
            alert('response')
            alert(response)
            cart = {}
            status = response["status"]
            if(status == "true")
                {
                    url = window.location.origin + "/Thankyou"
                    var href = window.location.href;
                    newurl = href.replace(href,url)
                    window.location.href = newurl
                }
            document.cookie = 'cart=' + JSON.stringify(cart) + ";domain=;path=/"
        },

        // handle a non-successful response
        error : function(xhr,errmsg,err) {
             alert(err)
             alert(errmsg)
             alert(xhr)
        }
    });
}

$("#btnApplyServiceDiscount").click(function()
{
    discountCode = $("#discountCodeForService").val();
    totalServiceAmount = document.getElementById('lblTotalService').innerHTML;
    totalInitialSetupAmount = document.getElementById('lblTotalInitialSetupCharge').innerHTML;
    totalAmount = document.getElementById('lblTotalAmountFull').innerHTML;

    $.ajax({
        url : "/applyDiscount/", // the endpoint
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