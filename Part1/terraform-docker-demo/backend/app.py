from flask import Flask
import psycopg2

app = Flask(__name__)

def get_db_connection():
    return psycopg2.connect(
        host="postgres_container",
        database="demo_db",
        user="demo",
        password="demo123"
    )

@app.route("/")
def hello():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT NOW();")   # simple query: current timestamp
    result = cur.fetchone()
    cur.close()
    conn.close()
    return f"Hello! Postgres says the time is: {result[0]}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
