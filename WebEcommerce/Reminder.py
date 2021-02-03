from datetime import datetime
from apscheduler.schedulers.background import BackgroundScheduler
from WebEcommerce.AutoReminderEmailForInstalmentPayment import SendEmail


def start():
    scheduler = BackgroundScheduler()
    scheduler.add_job(SendEmail, 'cron', hour=10,  minute=49)
    scheduler.start()

