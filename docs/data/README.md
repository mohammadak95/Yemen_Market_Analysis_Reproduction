# Data Documentation

## Data Sources

### 1. World Food Programme (WFP) Price Data
- **Description**: Weekly commodity prices from markets across Yemen
- **Variables**:
  - Date
  - Market location
  - Commodity type
  - Price (YER)
  - Unit
- **Time Period**: December 2019 onwards
- **Processing**: Log-transformed prices, interpolated missing values

### 2. Exchange Rate Data (Central Bank of Yemen)
- **Description**: Official and parallel market exchange rates
- **Variables**:
  - Date
  - Official rate
  - Parallel market rate
  - Rate spread
- **Time Period**: Aligned with price data
- **Processing**: Daily rates aggregated to weekly averages

### 3. Geographic Data (ACAPS Yemen Analysis Hub)
- **Description**: Market locations and administrative boundaries
- **Variables**:
  - Market coordinates
  - Administrative regions
  - Control zones
- **Format**: GeoJSON
- **Processing**: Spatial weights matrix construction

### 4. Conflict Data (ACLED)
- **Description**: Security incidents and conflict intensity
- **Variables**:
  - Date
  - Location
  - Event type
  - Fatalities
- **Time Period**: Matched to price data period
- **Processing**: Aggregated to market-week level

## Data Structure

### Raw Data (`data/raw/`)
```
├── prices/
│   ├── weekly_prices.csv
│   └── market_metadata.csv
├── exchange_rates/
│   └── daily_rates.csv
├── geographic/
│   ├── markets.geojson
│   └── admin_boundaries.geojson
└── conflict/
    └── events.csv
```

### Processed Data (`data/processed/`)
```
├── market_panel.csv       # Main analysis dataset
├── spatial_weights.rds    # Spatial weights matrix
├── market_pairs.csv      # Pairwise market relationships
└── summary_stats.csv     # Descriptive statistics
```

## Variable Definitions

### Market Panel Dataset
- **market_id**: Unique market identifier
- **date**: Week beginning date
- **commodity**: Type of commodity
- **price_yer**: Price in Yemeni Rial
- **price_log**: Natural log of price
- **exchange_rate**: Weekly average exchange rate
- **conflict_events**: Number of conflict events
- **distance_km**: Distance to nearest market
- **control_zone**: Political control classification

## Data Quality

### Missing Data
- Price series: < 5% missing
- Exchange rates: Complete series
- Conflict data: Daily coverage

### Data Limitations
- Market access restrictions in conflict zones
- Potential reporting delays
- Exchange rate volatility effects

## Usage Notes

1. All price data should be log-transformed before analysis
2. Exchange rates should be matched to price dates
3. Spatial weights matrix is row-standardized
4. Conflict events are geocoded and matched to nearest market

## Replication Instructions

1. Place raw data files in respective `data/raw/` subdirectories
2. Run cleaning scripts from `code/cleaning/`
3. Processed files will be generated in `data/processed/`
4. Verify data structure matches documentation

## Contact

For data-related queries, contact:
Mohammad al Akkaoui
