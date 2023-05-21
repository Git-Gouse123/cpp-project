FROM gcc:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y cmake lcov doxygen graphviz

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . /app

# Create build directory
RUN mkdir build

# Set the working directory to build
WORKDIR /app/build

# Configure and build the project
RUN cmake .. -DCMAKE_BUILD_TYPE=coverage
RUN make
RUN make test

# Set the entry point
CMD ["./main"]
