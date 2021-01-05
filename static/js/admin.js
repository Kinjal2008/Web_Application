$(document).ready(function()
{
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


/*$("#toggleViews").click(function()
{

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
});*/

});