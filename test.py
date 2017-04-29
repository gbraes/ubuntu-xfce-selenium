from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.firefox.firefox_binary import FirefoxBinary
driver = webdriver.Firefox(firefox_binary= FirefoxBinary('/usr/bin/firefox'))
driver.get("http://www.python.org")
assert "Python" in driver.title
elem = driver.find_element_by_name("q")
elem.clear()
elem.send_keys("pycon")
elem.send_keys(Keys.RETURN)
assert "No results found." not in driver.page_source
if(driver.page_source.find("No result found.")==-1):
            print("TEST OK.")
driver.close()
