from django.db import models
from django.contrib.auth.models import AbstractUser
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils.text import slugify


class UserType(models.Model):
    UserTypeId = models.AutoField(primary_key=True)
    Type = models.CharField(max_length=100)
    UserTypeUnchanged = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.Type


class User(AbstractUser):
    user_type = models.ForeignKey(UserType, blank=True, null=True, on_delete=models.CASCADE)


class DiscountType(models.Model):
    Discount_Type_Id = models.AutoField(primary_key=True)
    DiscountCode = models.CharField(max_length=50)
    DiscountDescription = models.CharField(max_length=100, blank=True, null=True)
    Percentage = models.FloatField(null=True, blank=True, validators=[MinValueValidator(0), MaxValueValidator(100)])
    DiscountFrom = models.DateField(null=True, blank=True)
    DiscountTo = models.DateField(null=True, blank=True)
    IsReferralDiscount = models.BooleanField(default=False, blank=True, null=True)


class OrderStatus(models.Model):
    OrderStatusId = models.AutoField(primary_key=True)
    OrderStatusType = models.CharField(null=True, blank=True, max_length=100)


class Customer(models.Model):
    Customer_Id = models.AutoField(primary_key=True)
    Phone_No = models.CharField(max_length=100, null=True, blank=True)
    Enrolled_Date = models.DateTimeField(blank=True, null=True, auto_now_add=True)
    First_Name = models.CharField(max_length=200, blank=True, null=True)
    Last_Name = models.CharField(max_length=200, blank=True, null=True)
    Email = models.CharField(max_length=200, blank=True, null=True)
    Gender = models.CharField(max_length=100, blank=True, null=True)
    user = models.OneToOneField(User, on_delete=models.CASCADE, blank=True, null=True)
    Referral = models.ForeignKey('self', on_delete=models.CASCADE, blank=True, null=True)
    SameHousehold = models.ForeignKey('self', on_delete=models.CASCADE, blank=True, null=True,
                                      related_name="within_same_family")
    ReferralDiscount = models.ForeignKey(DiscountType, on_delete=models.CASCADE, null=True, blank=True)
    PersonalDiscount = models.FloatField(default=0, null=True, blank=True,
                                         validators=[MinValueValidator(0), MaxValueValidator(100)])
    Stripe_Id = models.CharField(max_length=255,blank=True, null=True)


ADDRESS_CHOICES = (
    ('B', 'Billing'),
    ('S', 'Shipping'),
)


class Address(models.Model):
    Address_Id = models.AutoField(primary_key=True)
    Addressline1 = models.CharField(max_length=255, null=True, blank=True)
    Addressline2 = models.CharField(max_length=255, null=True, blank=True)
    Addressline3 = models.CharField(max_length=255, null=True, blank=True)
    City = models.CharField(max_length=100, null=True, blank=True)
    State = models.CharField(max_length=100, null=True, blank=True)
    Postal_Code = models.CharField(max_length=50, null=True, blank=True)
    Country = models.CharField(max_length=100, null=True, blank=True)
    User_Id = models.ForeignKey(User, null=True, blank=True, on_delete=models.CASCADE, db_column='User_Id')
    default = models.BooleanField(default=False)
    Address_Type = models.CharField(max_length=1, choices=ADDRESS_CHOICES, default='B')


class Category(models.Model):
    Category_Id = models.AutoField(primary_key=True)
    Name = models.CharField(max_length=255)


class Product(models.Model):
    Product_Id = models.AutoField(primary_key=True)
    Name = models.CharField(max_length=255)
    Code = models.CharField(max_length=255)
    Description = models.CharField(max_length=2000)
    DetailDescription = models.TextField(null=True, blank=True)
    Price = models.FloatField(null=True, blank=True)
    AdditionalMemberPrice = models.FloatField(null=True, blank=True, default=0)
    Image = models.ImageField(null=True, blank=True)
    IsProduct = models.BooleanField(default=True, blank=True, null=True)
    InitialSetupCharge = models.FloatField(null=True, blank=True, default=0)
    NoOfInstallmentMonths = models.IntegerField(null=True, blank=True, default=1)
    IsDiscountable = models.BooleanField(default=False, blank=True, null=True)
    DiscountPercentage = models.FloatField(null=True, blank=True, default=0,
                                           validators=[MinValueValidator(0), MaxValueValidator(100)])
    slug = models.SlugField(blank=True, null=True, editable=False)
    Category = models.ForeignKey(Category, null=True, blank=True, on_delete=models.CASCADE)
    StockLevel = models.IntegerField(null=True, blank=True, default=1)
    Threshold = models.IntegerField(null=True, blank=True, default=10)

    def __str__(self):
        return self.Name

    def save(self, *args, **kwargs):
        if not self.Product_Id:
            self.slug = slugify(self.Name)

        super(Product, self).save(*args, **kwargs)

    # Get price for 2 person.
    # Price + Additional member price e.g. (295 + 215)
    @property
    def getPriceForMultiplePerson(self):
        total = self.Price + self.AdditionalMemberPrice
        return total

    # Price * number of installments e.g. (295 * 2)
    @property
    def getPriceForAllInstallments(self):
        total = self.Price * self.NoOfInstallmentMonths
        return total

    # Get Full price for 2 person.
    # (Price + additional member price) * number of installment e.g. (295 + 215) * 2
    @property
    def getPriceForAllInstallmentsForMultiplePerson(self):
        total = self.getPriceForMultiplePerson * self.NoOfInstallmentMonths
        return total

    # Get Full price for 2 person.
    # (Price + additional member price) * number of installment e.g. (295 + 215) * 2
    @property
    def getPriceForAllInstallmentsForSecondPerson(self):
        total = self.AdditionalMemberPrice * self.NoOfInstallmentMonths
        return total

    # Get initial setup charge for 2 person. e.g. (295 + 295)
    @property
    def getInitialSetupChargeForMultiplePerson(self):
        total = self.InitialSetupCharge + self.InitialSetupCharge
        return total

    # (price * number of installment) + Initial Setup e.g. (295 * 2) + 295
    # Used in below pages:
    # Home page - display main amount of service for one person selected
    @property
    def getPriceForInitialSetupAndFullPaymentForOnePerson(self):
        total = self.getPriceForAllInstallments + self.InitialSetupCharge
        return total

    # (number of installment * price + additional member price) + Initial Setup e.g. ((295 + 215) * 2) + (295 + 295)
    # Used in below pages:
    # Home page - display main amount of service 2 person selected
    @property
    def getPriceForInitialSetupAndFullPaymentForMultiplePerson(self):
        total = self.getPriceForAllInstallmentsForMultiplePerson + self.getInitialSetupChargeForMultiplePerson
        return total

    @property
    def getPercentageOfServiceForInitialSetupAndFullPaymentForOnePerson(self):
        total = 0
        if self.IsDiscountable and not self.IsProduct:
            total = self.getPriceForAllInstallments + self.InitialSetupCharge
        return total

    @property
    def getPercentageOfServiceForInitialSetupAndFullPaymentForMultiplePerson(self):
        total = 0
        if self.IsDiscountable and not self.IsProduct:
            total = self.getPriceForAllInstallmentsForMultiplePerson + self.getInitialSetupChargeForMultiplePerson
        return total

    # Get identical monthly charges excluding first month.
    # e.g. For 2 months service, 1 month is compulsory and identical remaining month is 1
    # Similarly, for 6 months service, 1 months is compulsory and identical months are 5.
    @property
    def getIdenticalMonthsOfInstallation(self):
        total = self.NoOfInstallmentMonths - 1
        return total

    @property
    def getDiscountedPrice(self):
        discount = self.Price * self.DiscountPercentage / 100
        total = self.Price - discount
        return total


class ProductSpecification(models.Model):
    ProductSpec_Id = models.AutoField(primary_key=True)
    Product = models.ForeignKey(Product, on_delete=models.CASCADE, db_column='Product_Id', null=True, blank=True)
    SpecificationName = models.CharField(max_length=2000, blank=True, null=True)
    SpecificationValue = models.CharField(max_length=2000, blank=True, null=True)


class Order(models.Model):
    Order_Id = models.AutoField(primary_key=True)
    Customer = models.ForeignKey(Customer, null=True, on_delete=models.SET_NULL, blank=True)
    Order_Date = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    IsOrderCompleted = models.BooleanField(default=False, blank=True, null=True)
    Transaction_Id = models.CharField(max_length=200, null=True)
    ServiceDiscountCode = models.IntegerField(null=True, blank=True)
    ServiceDiscountAmount = models.FloatField(null=True, blank=True)
    ProductDiscountCode = models.IntegerField( null=True, blank=True)
    ServiceDiscountAmount = models.FloatField(null=True, blank=True)
    ServiceTotalAmount = models.FloatField(null=True, blank=True)
    ProductTotalAmount = models.FloatField(null=True, blank=True)
    ConditionalVAT = models.FloatField(null=True, blank=True)
    GeneralVAT = models.FloatField(null=True, blank=True)
    OrderCompletionDate = models.DateField(auto_now_add=True, blank=True, null=True)
    ActualAmountToPay = models.FloatField(null=True, blank=True)
    FullPaymentDiscountAmount = models.FloatField(null=True, blank=True)
    OrderStatus = models.ForeignKey(OrderStatus, blank=True, null=True, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.Order_Id)

    @property
    def get_CartTotalPriceForAllProduct_WithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = sum([item.get_TotalForAllProduct_ByQuantity_WithFullPayment for item in orderitems])
        return total

    # Use this function in Checkout parge, to display total of all services
    @property
    def get_CartTotalPriceFor_ProductWithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if item.Product.IsProduct:
                total = sum([item.get_TotalForAllProduct_ByQuantity_WithFullPayment])
        return total

    # Use this function in Checkout parge, to display total of all products
    @property
    def get_CartTotalPriceFor_ServiceWithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if not item.Product.IsProduct:
                total = sum([item.get_TotalForAllProduct_ByQuantity_WithFullPayment])
        return total

    # Use this function in Checkout page, to display total of all products
    # for One person

    @property
    def get_CartTotalPriceFor_OnePerson_ServiceWithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if not item.Product.IsProduct:
                total = sum([item.get_TotalForAllProduct_ForOnePerson_WithFullPayment])
        return total

    # Use this function in Checkout page, to display total of all products
    # for Two person

    @property
    def get_CartTotalPriceFor_TwoPerson_ServiceWithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if not item.Product.IsProduct:
                total = sum([item.get_TotalForAllProduct_ForTwoPerson_WithFullPayment])
        return total

    # Use this function in Checkout page, to display total of all products
    # for One person

    @property
    def get_CartTotalQuantityFor_OnePerson_ServiceWithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if not item.Product.IsProduct:
                total = sum([item.Quantity])
        return total

    # Use this function in Checkout page, to display total of all products
    # for Two person

    @property
    def get_CartTotalQuantityFor_TwoPerson_ServiceWithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if not item.Product.IsProduct:
                total = sum([item.Quantity])
        return total

    @property
    def get_PercentageAmount_WithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = sum([item.get_FullPaymentPercentageForAllProduct for item in orderitems])
        return total

    @property
    def get_CartTotalPriceForAllProduct_WithInstallmentPayment(self):
        orderitems = self.orderdetails_set.all()
        total = sum([item.get_TotalForAllProduct_ByQuantity_WithInstallmentPayment for item in orderitems])
        return total

    # TO GET Only Pending Service Installation
    @property
    def get_PendingServiceCharge_WithInstallmentPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if not item.Product.IsProduct:
                total += sum([item.get_TotalForAllProduct_ByQuantity_WithInstallmentPayment])
        return total

    @property
    def get_CartTotalPriceForAllDiscountableService_WithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if item.Product.IsDiscountable and not item.Product.IsProduct:
                total += sum([item.get_TotalForAllProduct_ByQuantity_WithFullPayment])
        return total

    @property
    def get_CartTotalPriceForAllDiscountableProduct_WithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if item.Product.IsDiscountable and item.Product.IsProduct:
                total += sum([item.get_TotalForAllProduct_ByQuantity_WithFullPayment])
        return total

    @property
    def get_CartTotalPriceForAllNonDiscountableProduct_WithFullPayment(self):
        orderitems = self.orderdetails_set.all()
        total = 0
        for item in orderitems:
            if not item.Product.IsDiscountable and item.Product.IsProduct:
                total += sum([item.get_TotalForAllProduct_ByQuantity_WithFullPayment])
        return total

    # Get Total based on the Quantity.
    # (((Price * number of installments) + Initial setup charge) * Quantity) e.g. ((295 * 2) + 295 ) * 1
    @property
    def get_CartTotalPriceForInitialSetupAndProduct(self):
        orderitems = self.orderdetails_set.all()
        total = sum([item.get_TotalForAllProduct_ByQuantity for item in orderitems])
        return total

    @property
    def get_TotalCartItems(self):
        orderitems = self.orderdetails_set.all()
        total = sum([item.Quantity for item in orderitems])
        return total

    @property
    def get_InitialSetupChargeForAllProducts(self):
        orderitems = self.orderdetails_set.all()
        total = sum([item.get_InitialSetupCharge_ByQuantity for item in orderitems])
        return total

    @property
    def get_ServiceFirstMonthInstalmentAndProductCharge_WithInstalment(self):
        orderitems = self.orderdetails_set.all()
        total = sum([item.get_InitialSetupCharge_ByQuantity for item in orderitems])
        return total

    @property
    def get_TotalForAllProductPriceAndInitialSetupCharge_WithFullPayment(self):
        total = self.get_CartTotalPriceForAllProduct_WithFullPayment + self.get_InitialSetupChargeForAllProducts
        return total

    @property
    def get_TotalForAllProductPriceAndInitialSetupCharge_WithInstallmentPayment(self):
        total = self.get_CartTotalPriceForAllProduct_WithInstallmentPayment + self.get_InitialSetupChargeForAllProducts
        return total

    @property
    def get_TotalPrice_WithInstallmentPayment(self):
        orderitems = self.orderdetails_set.all()
        total = self.get_InitialSetupChargeForAllProducts
        for item in orderitems:
            if item.Product.IsProduct:
                total += sum([item.Product.Price])
        return total

    @property
    def getNumberofInstalment(self):
        orderitems = self.orderdetails_set.all()
        total = sum([item.getNumberofInstalment for item in orderitems])
        return total


class OrderDetails(models.Model):
    Product = models.ForeignKey(Product, on_delete=models.CASCADE, db_column='Product_Id', null=True, blank=True)
    Order = models.ForeignKey(Order, on_delete=models.CASCADE, db_column='Order_Id', null=True, blank=True)
    Quantity = models.IntegerField(default=0, null=True, blank=True)
    Date_Added = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    TotalNoOfPerson = models.IntegerField(default=1, null=True, blank=True)

    # Get total by quantity price * number of installment e.g. (295 * 2) * 2 OR ((295 + 215) * 2) * 2
    @property
    def get_TotalForAllProduct_ByQuantity(self):
        total = self.Product.getPriceForInitialSetupAndFullPaymentForOnePerson * self.Quantity
        if self.TotalNoOfPerson == 2:
            total = self.Product.getPriceForInitialSetupAndFullPaymentForMultiplePerson * self.Quantity
            # total = self.getCartItemsPrice * self.Quantity
        return total

        # Get total by quantity price * number of installment e.g. (295 * 2) * 2 OR ((295 + 215) * 2) * 2

    @property
    def get_InitialSetupCharge_ByQuantity(self):
        total = self.Product.InitialSetupCharge * self.Quantity
        if self.TotalNoOfPerson == 2:
            total = self.Product.getInitialSetupChargeForMultiplePerson * self.Quantity
            # total = self.getCartItemsPrice * self.Quantity
        return total

    # To get product price based on number of quantity, IF the USer pays amount in FULL.
    @property
    def get_TotalForAllProduct_ByQuantity_WithFullPayment(self):
        total = self.Product.getPriceForAllInstallments * self.Quantity
        if self.TotalNoOfPerson == 2:
            total = self.Product.getPriceForAllInstallmentsForMultiplePerson * self.Quantity
        return total

    # To get product price to display in Checkout and payment page
    # , IF the USer pays amount in FULL.
    # display amount for individual person
    @property
    def get_TotalForAllProduct_ForOnePerson_WithFullPayment(self):
        total = self.Product.getPriceForAllInstallments
        return total

    # To get product price to display in Checkout and payment page
    # , IF the USer pays amount in FULL.
    # display amount for individual person
    @property
    def get_TotalForAllProduct_ForTwoPerson_WithFullPayment(self):
        total = 0
        if self.TotalNoOfPerson == 2:
            total = self.Product.getPriceForAllInstallmentsForSecondPerson
        return total

    # To get full payment Percentage based on number of quantity, IF the USer pays amount in FULL.
    @property
    def get_FullPaymentPercentageForAllProduct(self):
        total = self.Product.getPercentageOfServiceForInitialSetupAndFullPaymentForOnePerson * self.Quantity
        if self.TotalNoOfPerson == 2:
            total = self.Product.getPercentageOfServiceForInitialSetupAndFullPaymentForMultiplePerson * self.Quantity
        return total

    # To get product price based on number of quantity, IF the USer pays amount in Installments.
    @property
    def get_TotalForAllProduct_ByQuantity_WithInstallmentPayment(self):
        # total = self.Product.Price * self.Quantity
        total = self.Product.Price * self.Quantity
        if self.TotalNoOfPerson == 2:
            total = self.Product.getPriceForMultiplePerson * self.Quantity
            # total = self.getCartItemsPrice * self.Quantity
        return total

    # To get price for service based on no of person selected.
    # For 2 persons, it includes price for 2 persons.
    @property
    def getCartItemsPrice(self):
        total = self.Product.getPriceForAllInstallments
        if self.TotalNoOfPerson == 2:
            total = self.Product.getPriceForAllInstallmentsForMultiplePerson
        return total

    @property
    def getCartItemsInitialSetupCharge(self):
        total = self.Product.InitialSetupCharge
        if self.TotalNoOfPerson == 2:
            total = self.Product.getInitialSetupChargeForMultiplePerson
        return total

    @property
    def getNumberofInstalment(self):
        total = self.Product.NoOfInstallmentMonths - 1
        return total


class InstallmentType(models.Model):
    Installment_Type_Id = models.AutoField(primary_key=True)
    Installment_Type = models.CharField(max_length=50)
    Installment_TypeUnchanged = models.CharField(max_length=50, null=True, blank=True)
    Description = models.CharField(max_length=255, null=True)


PAYMENT_OPTIONS = ((0, 'None'), (1, "Cash"), (2, "Debit/Credit Card"))


class Payment(models.Model):
    Payment_Id = models.AutoField(primary_key=True)
    Order = models.ForeignKey(Order, on_delete=models.CASCADE, null=True, blank=True)
    Installment_Type = models.ForeignKey(InstallmentType, on_delete=models.CASCADE, null=True, blank=True)
    Discount_Type = models.ForeignKey(DiscountType, on_delete=models.CASCADE, null=True, blank=True)
    # Payment_Type = models.CharField(max_length=50, widget=forms.RadioSelect(choices=PAYMENT_OPTIONS))
    Payment_Type = models.CharField(max_length=50, blank=True, null=True)
    Amount = models.FloatField(null=True, blank=True)
    Date = models.DateTimeField(null=True, auto_now_add=True)
    Is_Invoice_Sent = models.BooleanField(null=True, blank=True, default=False)
    Stripe_Payment_Id = models.CharField(max_length=100, blank=True, null=True)


class InstallmentDue(models.Model):
    Installment_Due_Id = models.AutoField(primary_key=True)
    Order = models.ForeignKey(Order, on_delete=models.CASCADE, null=True, blank=True)
    Customer_Id = models.IntegerField(null=True, blank=True)
    User_Id = models.IntegerField(null=True, blank=True)
    Amount_Due = models.FloatField(null=True, blank=True)
    Due_Installments = models.IntegerField(null=True, blank=True)
    InstalmentDueDate = models.DateTimeField(null=True, auto_now_add=True)
    InstalmentReminderDay = models.IntegerField(null=True, blank=True, default=5)
    PaymentRefId = models.IntegerField(null=True, blank=True)
    IsInstalmentPaid = models.BooleanField(null=True, blank=True, default=False)
    OrderDetail = models.ForeignKey(OrderDetails, on_delete=models.CASCADE, null=True, blank=True)


class OrderDiscount(models.Model):
    Id = models.AutoField(primary_key=True)
    Order = models.ForeignKey(Order, on_delete=models.CASCADE, null=True, blank=True)
    DiscountType_Id = models.IntegerField(null=True, blank=True)


class CustomerDiscountEligibility(models.Model):
    Id = models.AutoField(primary_key=True)
    Customer = models.ForeignKey(Customer, on_delete=models.CASCADE, null=True, blank=True)
    DiscountType_Id = models.IntegerField(null=True, blank=True)
    DiscountApplicableLimit = models.IntegerField(null=True, blank=True, default=1)
    IsUsed = models.BooleanField(null=True, blank=True, default=False)


class Invoice(models.Model):
    InvoiceId = models.AutoField(primary_key=True)
    InvoiceNumber = models.CharField(null=True, blank=True, max_length=50)
    Filename = models.CharField(null=True, blank=True, max_length=2000)
    CreatedBy = models.CharField(null=True, blank=True, max_length=200)
    Content = models.FileField(null=True, blank=True)
    Date = models.DateTimeField(null=True, auto_now_add=True)
    Order = models.ForeignKey(Order, on_delete=models.CASCADE, null=True, blank=True)


class ActivityType(models.Model):
    ActivityTypeId = models.AutoField(primary_key=True)
    ActivityType = models.CharField(null=True, blank=True, max_length=50)


class ActivityLog(models.Model):
    ActivityLogId = models.AutoField(primary_key=True)
    ActivityDescription = models.CharField(null=True, blank=True, max_length=2000)
    CreatedBy = models.CharField(null=True, blank=True, max_length=50)
    CreatedDate = models.DateField(null=True, blank=True, auto_now_add=True)
    ActivityType = models.ForeignKey(ActivityType, on_delete=models.CASCADE, null=True, blank=True)


# To store default configuration for the application like Email, password, Instalment Reminder days, etc.
class Configuration(models.Model):
    ConfigurationId = models.AutoField(primary_key=True)
    ConfigurationName = models.CharField(null=True, blank=True, max_length=2000)
    DisplayName = models.CharField(null=True, blank=True, max_length=2000)
    ConfigurationValue = models.CharField(null=True, blank=True, max_length=2000)
    Image = models.ImageField(null=True, blank=True)


class AnnouncementPost(models.Model):
    Announcement_Id = models.AutoField(primary_key=True)
    Title1 = models.CharField(null=True, blank=True, max_length=2000)
    Title2 = models.CharField(null=True, blank=True, max_length=2000)
    Description = models.CharField(null=True, blank=True, max_length=2000)
    PostImage = models.ImageField(null=True, blank=True)
    IsActive = models.BooleanField(default=True, blank=True, null=True)


@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        if instance.user_type == 4:
            Customer.objects.create(user=instance)


@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    if instance.user_type == 4:
        instance.customer.save()
