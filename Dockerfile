# Use official Python 3.13 slim image
FROM python:3.13-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1

# Set working directory
WORKDIR /app

# Copy dependency directories
# We expect the build context to be the parent directory containing:
# - scikit-fem-benchmark/ (this repo)
# - cuda-scikit-fem/
# - scikit-fem/
COPY scikit-fem /app/scikit-fem
COPY cuda-scikit-fem /app/cuda-scikit-fem
COPY scikit-fem-benchmark /app/scikit-fem-benchmark

# Set workdir to the benchmark repo
WORKDIR /app/scikit-fem-benchmark

# Install dependencies using uv
# uv sync will create a .venv directory with the dependencies installed
# We use --frozen to ensure we use the lockfile exactly
RUN uv sync --frozen

# Add the virtual environment to the PATH
ENV PATH="/app/scikit-fem-benchmark/.venv/bin:$PATH"

# Make the runner script executable
RUN chmod +x run_benchmarks.sh

# Set the entrypoint
ENTRYPOINT ["./run_benchmarks.sh"]
