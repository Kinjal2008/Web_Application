$(document).ready(function()
{

$(".ordertrack").on("click", function() {
  statusid = $(this).attr("data-id")
  if(statusid == 1)
   {
    $('#trackOrder1').show()
    $('#trackOrder2').hide()
    $('#trackOrder3').hide()
   }
  else if(statusid == 2)
   {
    $('#trackOrder2').show()
    $('#trackOrder1').hide()
    $('#trackOrder3').hide()
   }
  else
   {
    $('#trackOrder3').show()
    $('#trackOrder1').hide()
    $('#trackOrder2').hide()
   }
});


$("#txtSearchByOrderNum").keyup(function () {

var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("txtSearchByOrderNum");
  filter = input.value.toUpperCase();
  table = document.getElementById("tblOrderHistory");
  tr = table.getElementsByTagName("tr");

  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
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

$("#txtSearchByOrderNumForMyOrders").keyup(function () {

var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("txtSearchByOrderNumForMyOrders");
  filter = input.value.toUpperCase();
  table = document.getElementById("tblOrderDetails");
  tr = table.getElementsByTagName("tr");

  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
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