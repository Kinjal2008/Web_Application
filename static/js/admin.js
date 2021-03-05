$(document).ready(function()
{
// Check validation before new client registration.
$('#btnSubmitRegistration').click(function()
{
    firstName = $('#first_name').val()
    lastName = $('#last_name').val()
    userName = $('#username').val()
    email = $('#email').val()
    password1 = $('#password1').val()
    password2 = $('#password2').val()
    address1 = $('#addressline1').val()
    address2 = $('#addressline2').val()
    state = $('#state').val()
    postalcode = $('#postalcode').val()
    country = $('#id_country :selected').text()
    countrycode = $('#id_country').val()
    var list = $("#registrationmessage");

    if(firstName == "")
    {
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter first name</li>');
        $('#registrationmessage').show()
        return false;
    }
    if(lastName == "")
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter last name</li>');
        $('#registrationmessage').show()
        return false;
    }
    if(userName == "")
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter user name</li>');
        $('#registrationmessage').show()
        return false;
    }
    if(email == "")
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter email</li>');
        $('#registrationmessage').show()
        return false;
    }
    if(password1 == "")
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter password</li>');
        $('#registrationmessage').show()
        return false;
    }
    if(address1 == "")
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter Address 1</li>');
        $('#registrationmessage').show()
        return false;
    }
    if(address2 == "")
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter Address 2</li>');
        $('#registrationmessage').show()
        return false;
    }
    if(state == "")
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter state</li>');
        $('#registrationmessage').show()
        return false;
    }
    if(postalcode == "")
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter Postal Code</li>');
        $('#registrationmessage').show()
        return false;
    }
    if(countrycode == "")
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please select country</li>');
        $('#registrationmessage').show()
        return false;
    }

    if(password1 != password2)
    {
        list.empty()
        var ul = list.append('<ul></ul>').find('ul');
        ul.append('<li>Please enter correct password.</li>');
        $('#registrationmessage').show()
        return false;
    }

    $('#registrationmessage').hide()
    return true;
});


// For Manage Orders / Manage Current Orders - by default hide the search textbox.
$('#txtSearchForManageOrder').hide()

// This is used to go to different views from the Admin Site.
// This is done by only SUPER ADMIN.

// Being a Super Admin, he can able to switch to other views as well.
// Based on the selection, it will redirect to particular landing page.
    var href = window.location.href;
    $('#groupview').change(function()
    {
        groupview= $('#groupview').val()
        $.ajax({
        url : "/changeViewBySuperAdmin/", // the endpoint
        type : "POST", // http method
        dataType : "json",
        data : { 'groupview': groupview }, // data sent with the post request
        headers:{
                'X-CSRFToken' : csrftoken
            },
        // handle a successful response
        success : function(response) {
            url = response["url"]
            newurl = href.replace(href,url)
            window.location.href = newurl
        },

        // handle a non-successful response
        error : function(xhr,errmsg,err) {

        }
    });


    });

// Search records based on the client name
// Navigation: Reports > Reports by Client
$('#btnSearchByClientNameOrderDetail').click(function()
{
    clientName = $('#txtSearchByClientName').val()

    $.ajax({
        url : "/searchClientOrders/", // the endpoint
        type : "POST", // http method
        dataType : "json",
        data : { 'clientName': clientName }, // data sent with the post request
        headers:{
                'X-CSRFToken' : csrftoken
            },
        // handle a successful response
        success : function(response) {
            alert(response)
            alert(response["result"])
            res = response["result"]
        },

        // handle a non-successful response
        error : function(xhr,errmsg,err) {
             alert(err)
        }
    });

});


// Search records based on the product/ service name
// Navigation: Reports > Reports by Product
$('#btnSearchByProductNameOrderDetail').click(function()
{
    alert('search clicked btnSearchByProductNameOrderDetail')
    productId = $('#searchByProduct').val()
    serviceId = $('#searchByService').val()
    alert(productId)
    alert(serviceId)
    $.ajax({
        url : "/searchProductOrders/", // the endpoint
        type : "POST", // http method
        dataType : "json",
        data : { 'productId': productId, 'serviceId': serviceId }, // data sent with the post request
        headers:{
                'X-CSRFToken' : csrftoken
            },
        // handle a successful response
        success : function(response) {
            alert(response)
        },

        // handle a non-successful response
        error : function(xhr,errmsg,err) {
            alert(err)
        }
    });
});

// Based on the criteria selection, display the search textbox.
// Navigation: Manage Orders > Manage Current Orders
$('#searchManageOrder').change(function()
{
    var category = $('#searchManageOrder').val();
    if(category == 'all')
    {
        $('#txtSearchForManageOrder').hide()
    }
    else{
        $('#txtSearchForManageOrder').show()
    }
});

// Search records based on the different criteria of (Order#, Order Status, Client Name, Postal code)
// Navigation: Manage Orders > Manage Current Orders
$("#txtSearchForManageOrder").keyup(function () {

var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("txtSearchForManageOrder");
  filter = input.value.toUpperCase();
  table = document.getElementById("tblManageOrderDetails");
  tr = table.getElementsByTagName("tr");
  var category = $('#searchManageOrder').val();

  for (i = 0; i < tr.length; i++) {
    if(category == 'ordernum')
    {
        td = tr[i].getElementsByTagName("td")[0];
    }
    else if(category == 'clientname')
    {
        td = tr[i].getElementsByTagName("td")[1];
    }
    else if(category == 'status')
    {
        td = tr[i].getElementsByTagName("td")[3];
    }
    else if(category == 'postalcode')
    {
        td = tr[i].getElementsByTagName("td")[2];
    }

    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }

});


// Based on the criteria selection, display the search textbox.
// Navigation: Reports > Shipped Orders
$('#searchShippedOrder').change(function()
{
    var category = $('#searchShippedOrder').val();
    if(category == 'all')
    {
        $('#txtSearchForShippedOrder').hide()
    }
    else{
        $('#txtSearchForShippedOrder').show()
    }
});

// Search records based on the different criteria of (Order#, Client Name, Postal code)
// Navigation: Reports > Shipped Orders
$("#txtSearchForShippedOrder").keyup(function () {

var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("txtSearchForShippedOrder");
  filter = input.value.toUpperCase();
  table = document.getElementById("tblShippedOrderDetails");
  tr = table.getElementsByTagName("tr");
  var category = $('#searchShippedOrder').val();

  for (i = 0; i < tr.length; i++) {
    if(category == 'ordernum')
    {
        td = tr[i].getElementsByTagName("td")[0];
    }
    else if(category == 'clientname')
    {
        td = tr[i].getElementsByTagName("td")[1];
    }
    else if(category == 'postalcode')
    {
        td = tr[i].getElementsByTagName("td")[2];
    }

    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }

});

// Based on the criteria selection, display the search textbox.
// Navigation: Client
$('#searchClient').change(function()
{
    var category = $('#searchClient').val();
    if(category == 'all')
    {
        $('#txtSearchClient').hide()
    }
    else{
        $('#txtSearchClient').show()
    }
});

// Search records based on the different criteria of (Order#, Client Name, Postal code)
// Navigation: Client
$("#txtSearchClient").keyup(function () {

var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("txtSearchClient");
  filter = input.value.toUpperCase();
  table = document.getElementById("tblClients");
  tr = table.getElementsByTagName("tr");
  var category = $('#searchClient').val();

  for (i = 0; i < tr.length; i++) {
    if(category == 'clientname')
    {
        td = tr[i].getElementsByTagName("td")[2];
    }
    else if(category == 'postalcode')
    {
        td = tr[i].getElementsByTagName("td")[4];
    }

    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }

});

});