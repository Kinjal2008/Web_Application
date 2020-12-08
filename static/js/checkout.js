$(document).ready(function()
{
    isInstallment = $('input[name="installmentoption"]:checked').val();

    $("#lblWithInstallment").val(isInstallment)

    $('input[name="installmentoption"]').change(function()
    {
        isInstallment = $('input[name="installmentoption"]:checked').val();

        if(isInstallment == 'yes')
        {
            $("#btnYesContinue").show()
            $("#btnNoContinue").hide()
            $("#amountFullService").hide()
            $("#amountFullServiceDistributionForFirstPerson").hide()
            $("#amountFullServiceDistributionTwoFirstPerson").hide()
           // $("#amountInstall").show()
            $("#fullAmountDiscount").hide()
            $("#totalAmountFull").hide()
            $("#totalAmountInstall").show()
            document.getElementById('initialSetup').innerHTML = '1st Instalment:'

           // $("#DueAmountInstall").show()
          //  $("#InstallOption").show()
            $("#subtotal").hide()
//            $(".priceFull").hide()
//            $(".priceInstalment").show()
        }
        else
        {
            $("#btnYesContinue").hide()
            $("#btnNoContinue").show()
            $("#amountFullService").show()
            $("#amountFullServiceDistributionForFirstPerson").show()
            $("#amountFullServiceDistributionTwoFirstPerson").show()
            $("#amountInstall").hide()
            $("#fullAmountDiscount").show()
            $("#totalAmountFull").show()
            $("#totalAmountInstall").hide()
            document.getElementById('initialSetup').innerHTML = 'Initial setup charge:'
           // $("#DueAmountInstall").hide()
           // $("#InstallOption").hide()
            $("#subtotal").show()
//            $(".priceFull").show()
//            $(".priceInstalment").hide()

        }
        $("#lblWithInstallment").val(isInstallment)
    });
});