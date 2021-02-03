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

  if(paymentFrom == 'instalmentpayment')
  {
    submitFormDataForInstalmentPayment($('#hdnTokenVal').val())
  }
  else
  {
    submitFormDataForPayment($('#hdnTokenVal').val());
  }

}

function submitFormDataForPayment(tkn)
{
    total =  document.getElementById('lblTotalAmountFull').innerHTML

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

    var url = '/placeOrder/'
//    Send fetch Data
    fetch(url, {
        method:'POST',
        headers:{
            'Content-Type': 'application/json',
            'X-CSRFToken' : csrftoken
        },
        body:JSON.stringify({'User' : userInfo, 'Shipping' : shippingInfo,
                             'paymentType' : paymentType,
                             'paymentInInstalment': paymentInInstalment,
                             'serviceDiscount': serviceDiscount,
                             'serviceDiscountPercentage': serviceDiscountPercentage,
                             'serviceDiscountId': serviceDiscountId,
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