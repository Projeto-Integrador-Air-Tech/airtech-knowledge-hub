# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Install updates and MySQL server
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install mysql-server

# Expose the default MySQL port
EXPOSE 3306

# Start MySQL server when the container launches
CMD ["mysqld_safe"]
