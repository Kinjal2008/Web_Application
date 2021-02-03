$(document).ready(function()
{

// To set the current date in Order Details Report

    var today = new Date();
    document.getElementById("dateFrom").value = ('0' + today.getDate()).slice(-2) + '/' + ('0' + (today.getMonth() + 1)).slice(-2) + '/' + today.getFullYear();
    document.getElementById("dateTo").value = ('0' + today.getDate()).slice(-2) + '/' + ('0' + (today.getMonth() + 1)).slice(-2) + '/' + today.getFullYear();


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

// Fetch records based on the client name
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


// Fetch records based on the product/ service name
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

});