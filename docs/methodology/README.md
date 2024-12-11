# Methodology Documentation

## Overview
This directory contains detailed documentation of the methodological approach used in the analysis of market integration in Yemen.

## Contents

1. **Econometric Framework**
   - Vector Error Correction Models (VECM)
   - Spatial regression techniques
   - Time-varying market integration indices

2. **Data Processing**
   - Price series transformation
   - Market segmentation approach
   - Missing value handling

3. **Statistical Tests**
   - Cointegration analysis
   - Spatial dependency tests
   - Robustness checks

4. **Presentation Materials**
   - Methodology slides
   - Technical appendix
   - Mathematical derivations

## Key Equations

### Long-run Equilibrium
The long-run price relationship between markets:
```
P_{it} = α₀ + α₁P_{jt} + u_t
```
where:
- P_{it}: Price in market i at time t
- P_{jt}: Price in market j at time t
- α₀: Transaction costs
- α₁: Price transmission elasticity
- u_t: Equilibrium deviations

### Error Correction Model
Short-run dynamics with long-run adjustment:
```
ΔX_t = αβ'X_{t-1} + ∑Γᵢ ΔX_{t-i} + δZ_t + ε_t
```

### Spatial Analysis
Spatial price transmission:
```
y = ρWy + Xβ + ε
```

## Implementation Details
Detailed implementation steps and code documentation can be found in the `code/` directory of this repository.
