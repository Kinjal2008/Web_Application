$(document).ready(function()
{
    $("#btnSendReferralEmail").click(function()
    {
        email = $("#referralEmail").val();
        name = $("#referralName").val();

       $.ajax(
       {
            url : "/sendReferralEmail/", // the endpoint
            type : "POST", // http method
            dataType : "json",
            data : { 'email': email, 'name': name }, // data sent with the post request
            headers:{
                    'X-CSRFToken' : csrftoken
                },
            success : function(response) {
                $("#referModal").modal('hide')
            },

            // handle a non-successful response
            error : function(xhr,errmsg,err) {

            }
        });
    });

$('#category').change(function(){
    category=0

    if($('#category').val() == 1){
        category=1
    }
    else if ($('#category').val() == 2){
        category=2
    }

    $.ajax({
        url : "/shopByCategory/", // the endpoint
        type : "POST", // http method
        dataType : "json",
        data : { 'category': category }, // data sent with the post request
        headers:{
                'X-CSRFToken' : csrftoken
            },
        // handle a successful response
        success : function(response) {
            $('#dvProductServiceDetails').html(response);
            $('#category').val(category)
        },

        // handle a non-successful response
        error : function(xhr,errmsg,err) {
        }
    });
});

    $(".numbers").change(function()
    {
        var productId = this.dataset.product
        selectedValue = $('#noofusers'+productId).val()
        if(selectedValue == "1")
        {
            $("#noOfUserOne"+productId).show();
            $("#noOfUserTwo"+productId).hide();
            $("#TotalAmount"+productId).show();
            $("#TotalAmountForMultiplePerson"+productId).hide();

            document.getElementById('lblNoOfUser'+productId).innerHTML = '(For one client)'
        }
        else
        {
            $("#noOfUserOne"+productId).hide();
            $("#noOfUserTwo"+productId).show();
            $("#TotalAmount"+productId).hide();
            $("#TotalAmountForMultiplePerson"+productId).show();
            document.getElementById('lblNoOfUser'+productId).innerHTML = '(For two clients)'
        }
    });

    $('#menu li').on('click', function(){
        $('#menu li.active').removeClass('active');
        $(this).addClass('active');
    });

    $("#cartlistdropdown").hover(function(){
        $('.dropdown-menu').show();
        }, function(){

    });


$('.alert-close').on('click', function(c){
		$('.message').fadeOut('slow', function(c){
	  		$('.message').remove();
		});
	});

$("#toggleViews").click(function()
{
    // If the below condition is return False then this is in ADMIN rights page.
    // Else it will land on Client Dashboard page.
    // By default the view is ADMIN, so the value will be false.
    var href = window.location.href;
    if($('#toggleViews').prop('checked'))
    {
        // Land in CLIENT page.
        url = window.location.origin + "/index"
        $('#toggleViews').prop('checked', true);
    }
    else
    {
        // Land in ADMIN page.
        url = window.location.origin + "/home"
    }
    newurl = href.replace(href,url)
    window.location.href = newurl

});

});