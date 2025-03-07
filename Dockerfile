# Build the base image -> Stage 1
FROM python:alpine as baseimage
RUN mkdir /app
COPY requirements.txt /app/
WORKDIR /app
RUN pip install --user -r requirements.txt

# App run -> Stage 2
FROM python:alpine
WORKDIR /app
COPY --from=baseimage /root/.local /root/.local
COPY student.py /app/
COPY migrations /app/migrations
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Set environment variables
ENV FLASK_APP=student.py
ENV PATH=/root/.local/bin:$PATH


# Use the entrypoint script to run migrations and start Flask
CMD ["/app/entrypoint.sh"]