$(document).ready(function()
{
var updateBtns = document.getElementsByClassName('update-cart')

for(var i=0; i< updateBtns.length ; i++)
{
    updateBtns[i].addEventListener('click',function(){
        var productId = this.dataset.product
        var action = this.dataset.action
        noofuser = $('#noofusers'+productId).val()
        print('noofuser', noofuser)
        if(noofuser == undefined)
        {
            noofuser = 0
        }
        console.log(productId)
        console.log(action)

        if (user == 'AnonymousUser'){
            addCookieItems(productId, action)
           // alert('Please login first to continue...!')
        }
        else
        {
            updateOrder(productId, action, noofuser)
        }
    })
}

function addCookieItems(productId, action)
{
    console.log('User No')
    console.log(action)
    console.log(productId)
    if(action == 'add')
    {
        console.log(cart[productId])
        if(cart[productId] == undefined)
        {
            console.log('Inside undefined')
            cart[productId] = {'Quantity' : 1}
            console.log(cart[productId])
        }
        else
        {
         console.log('Outside undefined')
            cart[productId]['Quantity'] += 1
        }
    }

    if(action == 'remove')
    {
        cart[productId]['Quantity'] -= 1
        if(cart[productId]['Quantity'] <= 0)
        {
            console.log('remove item')
            delete cart[productId]
        }
    }
    console.log('cart:', cart)
    document.cookie = 'cart=' + JSON.stringify(cart) + ";domain=;path=/"
    location.reload()
}

function updateOrder(productId, action, noofuser)
{
    var url = '/updateItem/'
//    Send fetch Data
    fetch(url, {
        method:'POST',
        headers:{
            'Content-Type': 'application/json',
            'X-CSRFToken' : csrftoken
        },
        body:JSON.stringify({'ProductId' : productId, 'action' : action, 'noofuser': noofuser})
    })

    .then((response) => {
        console.log('res: ', response)
        return response.json()
    })

    .then((data) => {
        console.log('data: ', data)
        location.reload()
    })

}

});