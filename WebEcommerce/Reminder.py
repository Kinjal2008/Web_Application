from datetime import datetime
from apscheduler.schedulers.background import BackgroundScheduler
from WebEcommerce.AutoReminderEmailForInstalmentPayment import SendEmail


def start():
    scheduler = BackgroundScheduler()
    scheduler.add_job(SendEmail, 'interval', minutes=60)
    scheduler.start()

