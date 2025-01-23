FROM --platform=linux/amd64 ubuntu

RUN apt update && \
    apt install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        git \
        openjdk-21-jre-headless \
        libonig5

RUN java --version

# Create virtual environment
RUN python3 -m venv /appenv
ENV VIRTUAL_ENV=/appenv
ENV PATH=/appenv/bin:$PATH

# Install python packages
RUN pip install pandas matplotlib

WORKDIR /app
COPY . /app
RUN ./setup.sh

ENTRYPOINT ["bash"]