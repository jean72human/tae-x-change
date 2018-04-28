#import MySQLdb

import mysql.connector
from mysql.connector import Error

def connect():
    """ Connect to MySQL database """
    try:
        conn = mysql.connector.connect(host='localhost',
                                       database='taeXchange',
                                       user='root',
                                       password='dovonon2011MYSQL')
        if conn.is_connected():
            print('Connected to MySQL database')
 
    except Error as e:
        print(e)
 
    finally:
        conn.close()
 
 
if __name__ == '__main__':
    connect()



"""
# create connection to database
db = MySQLdb.connect("localhost","root","","icp_final_project")

# prepare a cursor object using cursor() method
cursor = db.cursor()

# create and execute statements
cursor.execute("SELECT VERSION()")
sql = "select * from student"
cursor.execute(sql)
results = cursor.fetchall()
print(results)
"""