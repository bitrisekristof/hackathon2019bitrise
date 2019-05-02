# Use bitrise base image
FROM bitriseio/docker-bitrise-base:latest

# Set working directory 
WORKDIR /BitriseData

#Add req
ADD . /BitriseData

# PostgreSQL
RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib

# Python
RUN apt-get install software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.6
RUN apt-get -y install postgresql postgresql-contrib libpq-dev python-dev
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

#google cloud sdk
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y
