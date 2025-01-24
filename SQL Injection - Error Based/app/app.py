import pymysql
import time
from flask import Flask, render_template, request, redirect, url_for
from flask_bcrypt import Bcrypt

# -------------------------------
# App configurations
# -------------------------------
# -- App variables
app = Flask(__name__)

app.config['TIMEOUT'] = 60
bcrypt = Bcrypt(app)

# -- MySQL connection
max_retries = 20
retry_interval = 5
for _ in range(max_retries):
    try:
        db = pymysql.connect(
            host="con_mysql", # <------ Keep an eye on this part, a bit problematic...
            user="andrea",
            password="..Andr3+a17v,n",
            database="gamesatin"
        )
    except pymysql.MySQLError as e:
        print("Error en la conexión, reintentando:", e)
        time.sleep(retry_interval)

# -------------------------------
# Program functions
# -------------------------------
# -- Extract all the games from db
def extract_games():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM games")
    games = cursor.fetchall()
    return games

# -- Extract all the games from db, but ordering those by rating
def extract_popular_games():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM games ORDER BY rating DESC")
    games = cursor.fetchall()
    return games

# -------------------------------
# Website routes
# -------------------------------
# -- Index page, list all games
@app.route('/')
def index():
    games = extract_games()
    return render_template('index.html', games=games)

# -- Details page, explore info about a game
@app.route('/details')
def game_details():
    cursor = db.cursor()
    try:
        game_id = request.args.get('id')
        if game_id:
            cursor.execute("SELECT * FROM games WHERE id = " + game_id)
            game = cursor.fetchone()
            if game:
                return render_template('details.html', game=game, error=None)

    except pymysql.Error as err:
        return render_template('details.html', game=None, error=err)

# -- Login page, to test credentials found in SQL
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        games = extract_popular_games()
        return render_template('login.html', games=games)

    elif request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # If inputs are invalid
        if not (username and password):
            err="Invalid username or password"
            games = extract_popular_games()
            return render_template('login.html', games=games, error=err)

        # Searching credentials
        cursor = db.cursor()
        cursor.execute("SELECT password_hash FROM gamesatin_users WHERE username = %s", (username,))
        password_db = cursor.fetchone()

        # If record isn't found
        if password_db is None:
            err="Invalid username or password"
            games = extract_popular_games()
            return render_template('login.html', games=games, error=err)
        # If record has been found
        else:
            hashed_password = password_db[0]
            # Validate password to otorgate a "session"
            if hashed_password and bcrypt.check_password_hash(hashed_password, password):
                msg = "YOU ARE LOGGED! This is bit of the power behind a SQL Injection... But there is more, keep learning (:"
                return render_template('details.html', game=None, error=msg)
            else:
                err="Invalid username or password"
                games = extract_popular_games()
                return render_template('login.html', games=games, error=err)
    else:
        return redirect(url_for('index'))

# -------------------------------
# Start program
# -------------------------------
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
