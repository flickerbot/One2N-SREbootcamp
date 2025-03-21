FROM python:alpine as baseimage
# Create app-specific user 
RUN adduser -u 10001 -D flaskapp
RUN mkdir /app
COPY requirements.txt /app/
WORKDIR /app

USER flaskapp
RUN pip install --user -r requirements.txt


FROM python:alpine
# Create the same app-specific user 
RUN adduser -u 10001 -D flaskapp
WORKDIR /app
COPY --from=baseimage /home/flaskapp/.local /home/flaskapp/.local
COPY student.py /app/
COPY migrations /app/migrations
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

RUN chown -R flaskapp:flaskapp /app
USER flaskapp
ENV FLASK_APP=student.py
ENV PATH=/home/flaskapp/.local/bin:$PATH
ENTRYPOINT ["/app/entrypoint.sh"]