import string
import time
import re
import mysql.connector
import config
from datetime import datetime
from dateutil.relativedelta import relativedelta
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options  
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from mysql.connector import  connect, Error
from config import db_config

def parse_relative_ru(text):
    num = int(re.search(r'\d+', text).group())
    
    if "год" in text or "лет" in text:
        return datetime.now() - relativedelta(years=num)
    if "месяц" in text:
        return datetime.now() - relativedelta(months=num)
    if "нед" in text:
        return datetime.now() - relativedelta(weeks=num)
    if "дн" in text:
        return datetime.now() - relativedelta(days=num)
    if "час" in text:
        return datetime.now() - relativedelta(hours=num)
    
#OPERATIONS
FirefoxOptions = Options()
driver = webdriver.Firefox(options = FirefoxOptions)
connection = connect(
        host = "MySQL-8.4",
        user = "root",
        password = "",
        database = "reviews_db"
    )
cursor = connection.cursor()
cursor.execute(''' SELECT location_id FROM locations where location_name = 'ТЦ "Казына" – Google Карты' ''')
url = cursor.fetchall()
url_address = url[0][0]
driver.get(url_address) 
print(driver.title + "\nКоординаты объекта:")
objects_title = driver.title

wait = WebDriverWait(driver, 10)

objects_coordinates = re.search(r'@([\d\.\-]+),([\d\.\-]+)', url_address)
latitude = objects_coordinates[1]
longitude = objects_coordinates[2]
print("Latitude: " + latitude +  "\nLongitude:" + longitude + "\n")
coordination = latitude + "," + longitude

img = wait.until(   
    EC.visibility_of_element_located((By.XPATH, "/html/body/div[1]/div[2]/div[9]/div[8]/div/div/div[1]/div[2]/div/div[1]/div/div/div[1]/div[1]/button/img"))
)
img_url = img.get_attribute("src")
print(img_url)
average_rating_obg = wait.until(
    EC.visibility_of_element_located((
        By.CSS_SELECTOR, "span.ceNzKf"))
)

aria_label_aro = average_rating_obg.get_attribute("aria-label")
print("Средняя оценка объекта: " + aria_label_aro)

reviews_count = wait.until(
    EC.visibility_of_element_located((
        By.XPATH, "/html/body/div[1]/div[2]/div[9]/div[8]/div/div/div[1]/div[2]/div/div[1]/div/div/div[2]/div/div[1]/div[2]/div/div[1]/div[2]/span[2]/span/span"))
)
print("Количесто отзывов объкета: " + reviews_count.text)

reviews_block_button = wait.until(
    EC.element_to_be_clickable((
        (By.XPATH, '//button[@role="tab"][contains(@aria-label,"Отзывы")]')
    ))
)

reviews_block_button.click()

scroll_block = driver.find_element(By.XPATH, '/html/body/div[1]/div[2]/div[9]/div[8]/div/div/div[1]/div[2]/div/div[1]/div/div/div[2]')

print("\nСамые релевантный отзыв")

driver.execute_script(
     "arguments[0].scrollTop = arguments[0].scrollHeight",
 scroll_block)
reviews = wait.until(
        EC.visibility_of_all_elements_located((
        By.CSS_SELECTOR, "div.jftiEf"
        ))
    )

#MAIN CYCLE
past_resources = []
authors_past_resources = []
reviews_from_DB = []
authors_from_DB = []
try:
    with connection.cursor() as cursore:
        cursore.execute("SELECT review_id FROM reviews")
        rows = cursore.fetchall()
        for row in rows:
            reviews_from_DB.append(row[0])
        cursore.execute("SELECT profile_id FROM authors")
        rows = cursore.fetchall()
        for row in rows:
            authors_from_DB.append(row[0])
    while True:
        time.sleep(1)
        for review in reviews:  
            cursor.execute("SELECT profile_id, id FROM authors")
            rows = cursor.fetchall()
            for row in rows:
                authors_from_DB.append(row[0])
            reviews_author_name = review.find_element(By.CLASS_NAME, "al6Kxe")
            only_reviews_author_name = reviews_author_name.find_element(By.CLASS_NAME, "d4r55")
            authors_ref = reviews_author_name.get_attribute("data-href")
            authors_id = re.search(r'/contrib/(\d+)', authors_ref).group(1)
            authors_img = review.find_element(By.CLASS_NAME, "NBa7we")
            authors_img_src = authors_img.get_attribute("src")
            if authors_id not in authors_from_DB:
                insert_author = "INSERT INTO authors (profile_id, author_name, profile_link, profile_img) VALUES (%s, %s, %s, %s)"
                cursor.execute(insert_author, (authors_id,only_reviews_author_name.text,authors_ref, authors_img_src))
                connection.commit()
            if authors_id in authors_from_DB:
                continue
            users_review_id = reviews_author_name.get_attribute("data-review-id")
            if users_review_id in reviews_from_DB:
                continue
            if users_review_id in past_resources:
                continue
            past_resources.append(users_review_id)
            try:
                users_reviews_to_object = review.find_element(By.CSS_SELECTOR, "span.kvMYJc")
                authors_rate_for_object = users_reviews_to_object.get_attribute("aria-label")
                INT_authors_rate_for_object = int(authors_rate_for_object[0])
            except:
                INT_authors_rate_for_object = 0  
            try:
                authors_text = review.find_element(By.CSS_SELECTOR, "span.wiI7pd")
            except:
                authors_text = " "
            try:
                reviews_push_data = review.find_element(By.CLASS_NAME, "rsqaWe")
                datetime_reviews_push_data = parse_relative_ru(reviews_push_data.text)
            except:
                datetime_reviews_push_data = datetime.now()
            try:
                reviews_likes = review.find_element(By.CSS_SELECTOR, "span.pkWtMe")
                INT_reviews_likes = reviews_likes.text
                likes = int(INT_reviews_likes)
            except:
                likes = 0
            to_find_sys_location_id = "SELECT id FROM locations WHERE location_id = %s"
            url_to_find_sys_location_id = (f"{url_address}",)
            cursor.execute(to_find_sys_location_id, url_to_find_sys_location_id)
            result_url_to_find_sys_location_id = cursor.fetchone()
            sys_location_id = result_url_to_find_sys_location_id[0]

            to_find_sys_author_id =  "SELECT id FROM authors WHERE profile_id = %s"
            authors_id_to_find_sys_author_id = (f"{authors_id}",)
            cursor.execute(to_find_sys_author_id, authors_id_to_find_sys_author_id)
            result_authors_id_to_find_sys_author_id = cursor.fetchone()
            sys_author_id = int(result_authors_id_to_find_sys_author_id[0])

            insert_this_reviw = f"INSERT INTO reviews (review_id, content, rating, likes, sys_location_id, sys_author_id, review_date) VALUES ('{users_review_id}' ,'{authors_text.text}', {INT_authors_rate_for_object}, {likes}, {sys_location_id}, {sys_author_id}, '{datetime_reviews_push_data}')"
            cursor.execute(insert_this_reviw)
            connection.commit()
            print("Ник и информация об автора отзыва: " + reviews_author_name.text)     
            print("Id отзыва:                         " + users_review_id)  
            print("Оценка автора объекту:             " + authors_rate_for_object)     
            print("Отзыв автора объекту:              " + authors_text.text)    
            print("Выложено                           " + str(datetime_reviews_push_data) + " назад")
            try:
                print("Количестов лайков под одзывом:     " + likes + "\n\n")
            except:
                print("Под отзывом нету лайков\n\n")
        authors_from_DB = []
        driver.execute_script(
            "arguments[0].scrollTop = arguments[0].scrollHeight",
        scroll_block)
        reviews = driver.find_elements(By.CSS_SELECTOR, "div.jftiEf")
except Error as e:
    print("Error: ", e)

driver.quit()
