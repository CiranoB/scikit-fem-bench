#!/bin/bash
set -e

echo "Running CPU Benchmark..."
python main.py > cpu_version_results.txt
echo "CPU Benchmark completed. Results saved to cpu_version_results.txt"

echo "Running GPU Benchmark..."
# We attempt to run maincuda.py. If it fails due to missing CUDA, we still want the CPU results to be preserved.
# The user said "run maincuda.py and write it on gpu_versions_results.txt".
# If it fails, the script will exit (set -e).
# If the user wants to ignore GPU failure, we could do `python maincuda.py > ... || true`
# But let's stick to the request.
python maincuda.py > gpu_versions_results.txt
echo "GPU Benchmark completed. Results saved to gpu_versions_results.txt"
