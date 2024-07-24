# Set the python version as a build-time argument
# with Python 3.12 as the default
ARG PYTHON_VERSION=3.12-slim-bullseye
FROM python:${PYTHON_VERSION}

# Create a virtual environment
RUN apt update && apt install -y nodejs npm

# Install requirements
ARG REQUIREMENTS_FILE=base.txt
ADD requirements/${REQUIREMENTS_FILE} requirements.txt
RUN pip install pip --upgrade && pip install -r requirements.txt

# Copy project
ADD /src /app

# Install Tailwind CSS, HTMX and other dependencies
WORKDIR /src
RUN npm install tailwindcss htmx.org
RUN npm run build:tailwind
# RUN npm run build:htmx

# Set final workdir
WORKDIR /app

# Command to run when image started
CMD python manage.py runserver 0.0.0.0:8000