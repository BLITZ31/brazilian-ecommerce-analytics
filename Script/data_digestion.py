import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Enter_your_password",
        database="ecommerce",
        allow_local_infile=True,
        auth_plugin='mysql_native_password'  
    )
    print("It worked! Connection established.")
    
    cursor = conn.cursor()
    print("Connected successfully!")

    # Path to your CSV file (using raw string r"..." to handle backslashes)
    csv_path = r"C:/datasets/Brazillian ecommerce open source data(1)/olist_customers_dataset.csv"  #Change csv files and load the tables

    # The fast import command
    # Change table name after as required
    query = f"""
    LOAD DATA LOCAL INFILE '{csv_path}'
    INTO TABLE customers
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '"'
    LINES TERMINATED BY '\\n'
    IGNORE 1 ROWS;
    """
    
    print("Importing data...")
    cursor.execute(query)
    conn.commit()
    print(f"Success! {cursor.rowcount} rows inserted.")

except mysql.connector.Error as e:
    print(f"Error: {e}")

finally:
    if 'conn' in locals() and conn.is_connected():
        cursor.close()
        conn.close()