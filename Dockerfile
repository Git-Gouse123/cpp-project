FROM gcc:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y cmake lcov doxygen graphviz default-jdk

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . /app

# Create build directory
RUN mkdir build

# Set the working directory to build
WORKDIR /app/build

# Install Sonar Scanner
RUN curl -o sonar-scanner-cli.zip -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip \
    && unzip sonar-scanner-cli.zip \
    && rm sonar-scanner-cli.zip \
    && mv sonar-scanner-* sonar-scanner

# Set the PATH for Sonar Scanner
ENV PATH="/app/build/sonar-scanner/bin:${PATH}"

# Set the entry point to start a bash session
CMD ["/bin/bash"]

