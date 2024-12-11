#!/bin/bash

# Yemen Market Analysis Reproduction Pipeline
# Author: Mohammad al Akkaoui

echo "Starting Yemen Market Analysis reproduction pipeline..."

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required but not installed."
    exit 1
fi

# Create virtual environment
echo "Creating Python virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install requirements
echo "Installing required packages..."
pip install -r requirements.txt

# Create necessary directories
echo "Creating output directories..."
mkdir -p output/{tables,figures}

# Run analysis pipeline
echo "Running analysis pipeline..."

echo "1. Running ECM Analysis..."
python code/ecm_analysis/ecm_v2.5_directional.py
python code/ecm_analysis/v2.5_unified.py

echo "2. Running Spatial Analysis..."
python code/spatial_analysis/spatial_model_v2.py
python code/spatial_analysis/time_varying_flows.py
python code/spatial_analysis/data_prepration_for_spatial_chart_v2.py

echo "3. Running Price Differential Analysis..."
python code/price_differential/price_differential_model_v2.py

# Deactivate virtual environment
deactivate

echo "Analysis pipeline completed. Results are available in the output directory."
echo "Please check the documentation in docs/ for interpretation of results."
