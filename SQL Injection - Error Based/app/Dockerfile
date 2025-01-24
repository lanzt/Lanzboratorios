FROM python:3.12.2

WORKDIR /opt/sqli_error_based

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
COPY . .

EXPOSE 5000

CMD ["python3", "app.py"]
