# Yemen Market Analysis Reproduction Package

This repository contains the reproduction package for the paper "Market Unity Amidst Conflict: Price Integration Analysis in Yemen".

## Repository Structure

```
├── data/                  # Data files
│   ├── raw/              # Original unprocessed data
│   └── processed/        # Cleaned and processed datasets
├── code/                 # Analysis code
│   ├── ecm_analysis/    # Error Correction Model analysis
│   │   ├── ecm_v2.5_directional.py
│   │   └── v2.5_unified.py
│   ├── spatial_analysis/  # Spatial econometric analysis
│   │   ├── spatial_model_v2.py
│   │   ├── time_varying_flows.py
│   │   └── data_prepration_for_spatial_chart_v2.py
│   ├── price_differential/  # Price differential analysis
│   │   └── price_differential_model_v2.py
│   ├── tests/           # Setup and validation tests
│   │   ├── test_setup.py
│   │   └── validate_setup.py
│   └── utils/           # Utility functions
│       ├── common_utils.py
│       ├── data_utils.py
│       ├── prepare_data.py          # Data preparation pipeline
│       └── precomputeSpatialData.py # Spatial data preprocessing
├── output/              # Generated outputs
│   ├── tables/         # Generated tables
│   └── figures/        # Generated figures
├── docs/               # Documentation
│   ├── methodology/    # Methodology documentation
│   └── data/          # Data documentation
└── presentation/       # Presentation materials
```

## Requirements

- Python (>= 3.8)
- Required Python packages:
  - pandas
  - numpy
  - statsmodels
  - geopandas
  - scipy
  - matplotlib
  - seaborn

## Reproduction Steps

1. Clone this repository
2. Install required dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run setup validation:
   ```bash
   python code/tests/validate_setup.py
   python code/tests/test_setup.py
   ```

4. Prepare data:
   ```bash
   python code/utils/prepare_data.py
   python code/utils/precomputeSpatialData.py
   ```

5. Run analysis scripts in the following order:
   ```bash
   # ECM Analysis
   python code/ecm_analysis/ecm_v2.5_directional.py
   python code/ecm_analysis/v2.5_unified.py

   # Spatial Analysis
   python code/spatial_analysis/spatial_model_v2.py
   python code/spatial_analysis/time_varying_flows.py

   # Price Differential Analysis
   python code/price_differential/price_differential_model_v2.py
   ```

## Data Sources

- World Food Programme (WFP) price data
- Central Bank of Yemen exchange rates
- ACAPS Yemen Analysis Hub geographic data
- ACLED conflict data

## Analysis Components

1. **Data Preparation**
   - Raw data processing and cleaning
   - Spatial data preprocessing
   - Feature engineering

2. **Error Correction Model (ECM) Analysis**
   - Directional price transmission between markets
   - Unified market integration assessment

3. **Spatial Analysis**
   - Spatial price transmission patterns
   - Time-varying market flows
   - Geographic price dispersion

4. **Price Differential Analysis**
   - Market pair price gap analysis
   - Transaction cost assessment
   - Exchange rate regime effects

## Testing and Validation

The package includes two testing scripts:
- `test_setup.py`: Verifies the correct installation and configuration of required dependencies
- `validate_setup.py`: Validates the data structure and environment setup

Run these tests before proceeding with the analysis to ensure proper setup.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Citation

If you use this code or data, please cite:

```bibtex
@article{alakkaoui2024market,
  title={Market Unity Amidst Conflict: Price Integration Analysis in Yemen},
  author={Al Akkaoui, Mohammad},
  year={2024}
}
```

## Contact

Mohammad al Akkaoui
