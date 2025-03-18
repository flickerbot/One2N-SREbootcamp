# Build the base image -> Stage 1
FROM python:alpine as baseimage
# Create nonroot-user with specific user ID 1234
RUN adduser -u 1234 -D tempuser
RUN mkdir /app
COPY requirements.txt /app/
WORKDIR /app

USER tempuser
RUN pip install --user -r requirements.txt

# App run -> Stage 2
FROM python:alpine
# Create the same nonroot-user in the second stage
RUN adduser -u 1234 -D tempuser
WORKDIR /app
COPY --from=baseimage /home/tempuser/.local /home/tempuser/.local
COPY student.py /app/
COPY migrations /app/migrations
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

RUN chown -R tempuser:tempuser /app
USER tempuser
ENV FLASK_APP=student.py
ENV PATH=/home/tempuser/.local/bin:$PATH
CMD ["/app/entrypoint.sh"]