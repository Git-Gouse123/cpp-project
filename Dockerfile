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

# Set the entry point to start a bash session
CMD ["/bin/bash"]

