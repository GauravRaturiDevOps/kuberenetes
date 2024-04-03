FROM python:3.9
WORKDIR /app
COPY requrements.txt .

RUN pip install -r requrements.txt

COPY . .

# RUN python3 manage.py makemigrations
# RUN python3 manage.py migrate
EXPOSE 8000

CMD ["python3","manage.py","runserver","0.0.0.0:8000"]