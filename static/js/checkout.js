$(document).ready(function()
{

    billingCountryCode = $('#hdnBillingCountry').val()
    if(billingCountryCode != '')
    {
        $('#id_billing_country').val(billingCountryCode)
    }

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
            $("#fullAmountDiscount").hide()
            $("#totalAmountFull").hide()
            $("#totalAmountInstall").show()
            $("#subtotal").hide()
        }
        else
        {
            $("#btnYesContinue").hide()
            $("#btnNoContinue").show()
            $("#amountFullService").show()
            $("#amountFullServiceDistributionForFirstPerson").show()
            $("#amountFullServiceDistributionTwoFirstPerson").show()
            $("#fullAmountDiscount").show()
            $("#totalAmountFull").show()
            $("#totalAmountInstall").hide()
            $("#subtotal").show()

        }
        $("#lblWithInstallment").val(isInstallment)
    });
});