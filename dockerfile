# base image
FROM python:3.11.3-buster
 
# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
 

# copy commands 
WORKDIR /mysite

# Copy the requirements file to the container
COPY requirements.txt .
 
# update docker-iamage packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y netcat-openbsd gcc && \
    apt-get clean
 

# update pip 
RUN pip install --upgrade pip

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the Django project files to the container
COPY /mysite /mysite


# Expose the necessary port(s)
EXPOSE 8000

# Specify the command to run your Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]