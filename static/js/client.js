// Create a Stripe client.
var stripe = Stripe($('#hdnKey').val());
// Create an instance of Elements.
var elements = stripe.elements();

// Custom styling can be passed to options when creating an Element.
// (Note that this demo uses a wider set of styles than the guide below.)
var style = {
  base: {
    color: '#32325d',
    fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
    fontSmoothing: 'antialiased',
    fontSize: '16px',
    '::placeholder': {
      color: '#aab7c4'
    }
  },
  invalid: {
    color: '#fa755a',
    iconColor: '#fa755a'
  }
};

// Create an instance of the card Element.
var card = elements.create('card', {style: style});
// Add an instance of the card Element into the `card-element` <div>.

card.mount('#card-element');



// Handle real-time validation errors from the card Element.
card.on('change', function(event) {
  var displayError = document.getElementById('card-errors');
  if (event.error) {
    displayError.textContent = event.error.message;
  } else {
    displayError.textContent = '';
  }
});

// Handle form submission.
var form = document.getElementById('stripe-form');
if(form != null)
{
form.addEventListener('submit', function(event) {
  event.preventDefault();
  stripe.createToken(card).then(function(result) {
    if (result.error) {
      // Inform the user if there was an error.
      var errorElement = document.getElementById('card-errors');
      errorElement.textContent = result.error.message;
    } else {
      // Send the token to your server.
      stripeTokenHandler(result.token);
    }
  });
});
}

// Submit the form with the token ID.
function stripeTokenHandler(token) {
  // Insert the token ID into the form so it gets submitted to the server
  var form = document.getElementById('stripe-form');
  var hiddenInput = document.createElement('input');
  hiddenInput.setAttribute('type', 'hidden');
  hiddenInput.setAttribute('name', 'stripeToken');
  hiddenInput.setAttribute('value', token.id);
  form.appendChild(hiddenInput);
  $('#hdnTokenVal').val(token.id)
  paymentFrom = $('#hdnPaymentFrom').val()

    billingaddress1 = $('#billing_address1').val()
    billingaddress2 = $('#billing_address2').val()
    billingstate = $('#billing_state_county').val()
    billingpincode = $('#billing_postal').val()
    billingcountry = $('#id_billing_country').val()
    //$('#id_billing_country :selected').text()
    if($('#IsShipDifferentAddress').is(':checked'))
    {
        // Ship to another address
        shippingaddress1 = $('#shipping_address1').val()
        shippingaddress2 = $('#shipping_address2').val()
        shippingstate = $('#shipping_state_county').val()
        shippingpincode = $('#shipping_postal').val()
        shippingcountry = $('#id_shipping_country').val()

        validAddress = IsValidAddress(shippingaddress1, shippingstate, shippingpincode, shippingcountry)
        if (!validAddress)
        {
            alert('Please enter shipping to other address details')
            return false;
        }
    }
    else
    {
        validAddress = IsValidAddress(billingaddress1, billingstate, billingpincode, billingcountry)
        if (!validAddress)
        {
            alert('Please enter billing address details')
            return false;
        }
    }

  if(paymentFrom == 'instalmentpayment')
  {
    submitFormDataForInstalmentPayment($('#hdnTokenVal').val());
  }
  else
  {
    submitFormDataForPayment($('#hdnTokenVal').val());
  }
}

function IsValidAddress(address1, state, pincode, country){
    if(address1 != "" && state != "" && pincode != "" && country != "")
    {
        return true;
    }
    return false;
}

function submitFormDataForPayment(tkn)
{
    total =  document.getElementById('lblTotalAmountFull').innerHTML
    var userInfo = {
        'name' : user,
        'email' : $("#email").val(),
        'total' : parseFloat(total)
    }

    var paymentType

    paymentType = "Card"
    url = window.location.href;
    params = (new URL(url)).searchParams;

    var paymentInInstalment = params.get('data');
    var serviceDiscount =  document.getElementById('lblServiceDiscount').innerHTML
    var serviceDiscountPercentage = document.getElementById('lblServiceDiscountPercentage').innerHTML
    var serviceDiscountId = document.getElementById('lblServiceDiscountId').innerHTML
    var actualAmountToPay = document.getElementById('lblActualAmount').innerHTML

    billingaddress1 = $('#billing_address1').val()
    billingaddress2 = $('#billing_address2').val()
    billingstate = $('#billing_state_county').val()
    billingpincode = $('#billing_postal').val()
    billingcountry = $('#id_billing_country :selected').text()
    billingcountrycode = $('#id_billing_country').val()

    shippingaddress1 = $('#shipping_address1').val()
    shippingaddress2 = $('#shipping_address2').val()
    shippingstate = $('#shipping_state_county').val()
    shippingpincode = $('#shipping_postal').val()
    shippingcountry = $('#id_shipping_country :selected').text()
    shippingcountrycode = $('#id_shipping_country').val()

    var shippingAddress = {
        'address' : shippingaddress1,
        'address2' : shippingaddress2,
        'state' : shippingstate,
        'zipcode' : shippingpincode,
        'country' : shippingcountry,
        'countrycode': shippingcountrycode
    }

    var billingAddress = {
        'address' : billingaddress1,
        'address2' : billingaddress2,
        'state' : billingstate,
        'zipcode' : billingpincode,
        'country' : billingcountry,
        'countrycode' : billingcountrycode
    }
    var url = '/placeOrder/'
//    Send fetch Data
    fetch(url, {
        method:'POST',
        headers:{
            'Content-Type': 'application/json',
            'X-CSRFToken' : csrftoken
        },
        body:JSON.stringify({'User' : userInfo, 'shippingAddress' : shippingAddress,
                             'billingAddress': billingAddress,
                             'paymentType' : paymentType,
                             'paymentInInstalment': paymentInInstalment,
                             'serviceDiscount': serviceDiscount,
                             'serviceDiscountPercentage': serviceDiscountPercentage,
                             'serviceDiscountId': serviceDiscountId,
                             'shippingAddress': shippingAddress,
                             'billingAddress': billingAddress,
                             'token': tkn
                             })
    })

    .then((response) => {
        console.log('res: ', response)
        return response.json()
    })

    .then((data) => {
        cart = {}
        console.log(data)
        status = data['status']
        orderId = data['OrderId']
        paymentId = data['PaymentId']
        errorMessage = '** ' + data['message']
        if(status == 'true')
        {
            url = window.location.origin + "/Thankyou"
            var href = window.location.href;
            newurl = href.replace(href,url)
            window.location.href = newurl
        }
        else
        {
            $('#card-errors').text(errorMessage);
        }

        document.cookie = 'cart=' + JSON.stringify(cart) + ";domain=;path=/"
    })
}

function submitFormDataForInstalmentPayment(token)
{
    total =  $('#amountToPay').text()
    orderid = $('#hdnOrderId').val()
    instalmentid = $('#hdnInatalmentDueId').val()
    instalmentNum = $('#hdnInstalmentNum').val()
    var url = '/payInstalmentDue/'
    fetch(url, {
        method:'POST',
        headers:{
            'Content-Type': 'application/json',
            'X-CSRFToken' : csrftoken
        },
        body:JSON.stringify({
                             'total': total,
                             'orderid': orderid,
                             'instalmentid': instalmentid,
                             'instalmentNum': instalmentNum,
                             'token': token
                             })
    })

    .then((response) => {
        console.log('res: ', response)
        return response.json()
    })

    .then((data) => {
        cart = {}
        console.log(data)
        status = data['status']
        errorMessage = '** ' + data['message']
        if(status == 'true')
        {
            alert('Thank you for your payment. It is successfully processed...!')
            url = window.location.origin + "/plandetail/" + orderid +"/"
            var href = window.location.href;
            newurl = href.replace(href,url)
            window.location.href = newurl
        }
        else
        {
            $('#card-errors').text(errorMessage);
        }

        document.cookie = 'cart=' + JSON.stringify(cart) + ";domain=;path=/"
    })
}