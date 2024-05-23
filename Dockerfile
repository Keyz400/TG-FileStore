FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    locales \
    build-essential \
    curl \
    git \
    gnupg2 \
    wget \
    busybox \
    python3 \
    python3-dev \
    python3-pip \
    python3-lxml \
    pv && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# Set up locales
RUN locale-gen en_US.UTF-8 && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

# Install Python dependencies
RUN pip3 install setuptools wheel yarl multidict

# Copy requirements file and install dependencies
COPY requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

# Copy application code
COPY . /app

# Set working directory
WORKDIR /app

# Command to run the application
CMD ["python3", "bot.py"]
