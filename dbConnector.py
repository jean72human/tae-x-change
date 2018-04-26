import MySQLdb

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