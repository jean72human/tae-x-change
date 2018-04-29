#import MySQLdb

import mysql.connector
from mysql.connector import Error

def connect():
    """ Connect to MySQL database """
    conn = None
    try:
        conn = mysql.connector.connect(host='localhost',
                                       database='taeXchange',
                                       user='root',
                                       password='dovonon2011MYSQL')
        if conn.is_connected():
            print('Connected to MySQL database')
            return conn
        
 
    except Error as e:
        print(e)
 

    return conn

def login(conn, user, password):
    """
    Logs in the user and return his information
    """
    if conn.is_connected():
        print('Will login')

    cursor = conn.cursor()

    try:
        sql = "select * from users where user_email = '"+user+"'"

        cursor.execute(sql)

        row = cursor.fetchone()

        if row[1] == password:
            return (True, {'password': row[1], 'email':row[0], 'phone_no':row[2]})
    except Error as e:
        print(e)
    except TypeError as e:
        print(e)

    cursor.close()

    return (False, {})

def register(conn, email, password, phone_no):
    """
    registers a user based on these details
    """

    cursor = conn.cursor()

    if conn.is_connected():
        print('Will register')

    cursor = conn.cursor()

    try:
        sql = "insert into users(user_email,password,phone_no) values(%s,%s,%s)"
        args = (email,password,phone_no)
        cursor.execute(sql,args)
        conn.commit()
        cursor.close()
        return True
    except Error as e:
        print(e)
    cursor.close()
    return False


#def 



 
 
if __name__ == '__main__':
    conn = connect()
    print(login(conn, 'samuel.attule@ashesi.edu.gh', 'password'))
    print(register(conn,'samuel.attule@ashesi.edu.gh', 'password','0557486399'))



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