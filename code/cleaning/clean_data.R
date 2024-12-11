#!/usr/bin/env Rscript

# Market Unity Amidst Conflict: Yemen Market Analysis
# Data Cleaning Script
# Author: Mohammad al Akkaoui

# Load required packages
library(tidyverse)
library(lubridate)
library(sf)
library(zoo)  # for time series operations

# Set working directory to project root
# setwd("path/to/project")  # uncomment and modify as needed

# Create directories if they don't exist
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

# Load raw data
load_price_data <- function() {
  read_csv("data/raw/prices/weekly_prices.csv", 
           col_types = cols(
             date = col_date(),
             market = col_character(),
             commodity = col_character(),
             price = col_double()
           ))
}

load_exchange_rates <- function() {
  read_csv("data/raw/exchange_rates/daily_rates.csv",
           col_types = cols(
             date = col_date(),
             official_rate = col_double(),
             parallel_rate = col_double()
           ))
}

load_geographic_data <- function() {
  st_read("data/raw/geographic/markets.geojson")
}

load_conflict_data <- function() {
  read_csv("data/raw/conflict/events.csv",
           col_types = cols(
             date = col_date(),
             latitude = col_double(),
             longitude = col_double(),
             event_type = col_character(),
             fatalities = col_integer()
           ))
}

# Data cleaning functions
clean_price_data <- function(df) {
  df %>%
    # Remove duplicates
    distinct() %>%
    # Create log prices
    mutate(price_log = log(price)) %>%
    # Handle missing values
    group_by(market, commodity) %>%
    arrange(date) %>%
    mutate(
      price_interpolated = na.approx(price, maxgap = 2, na.rm = FALSE),
      is_interpolated = is.na(price) & !is.na(price_interpolated)
    ) %>%
    ungroup()
}

clean_exchange_rates <- function(df) {
  df %>%
    # Aggregate to weekly
    mutate(week = floor_date(date, "week")) %>%
    group_by(week) %>%
    summarise(
      official_rate = mean(official_rate, na.rm = TRUE),
      parallel_rate = mean(parallel_rate, na.rm = TRUE),
      rate_spread = parallel_rate - official_rate
    ) %>%
    ungroup()
}

process_conflict_data <- function(df, markets_sf) {
  # Convert to SF object
  events_sf <- st_as_sf(df, coords = c("longitude", "latitude"), crs = 4326)
  
  # Find nearest market for each event
  nearest_market <- st_nearest_feature(events_sf, markets_sf)
  
  df %>%
    mutate(nearest_market = markets_sf$market_id[nearest_market]) %>%
    # Aggregate to market-week level
    mutate(week = floor_date(date, "week")) %>%
    group_by(nearest_market, week) %>%
    summarise(
      conflict_events = n(),
      total_fatalities = sum(fatalities, na.rm = TRUE)
    ) %>%
    ungroup()
}

# Main execution
main <- function() {
  # Load data
  prices_raw <- load_price_data()
  exchange_raw <- load_exchange_rates()
  markets_sf <- load_geographic_data()
  conflict_raw <- load_conflict_data()
  
  # Clean data
  prices_clean <- clean_price_data(prices_raw)
  exchange_clean <- clean_exchange_rates(exchange_raw)
  conflict_clean <- process_conflict_data(conflict_raw, markets_sf)
  
  # Create market panel dataset
  market_panel <- prices_clean %>%
    left_join(exchange_clean, by = c("date" = "week")) %>%
    left_join(conflict_clean, by = c(
      "market" = "nearest_market",
      "date" = "week"
    ))
  
  # Save processed data
  write_csv(market_panel, "data/processed/market_panel.csv")
  write_csv(exchange_clean, "data/processed/exchange_rates_weekly.csv")
  st_write(markets_sf, "data/processed/markets_clean.geojson", delete_dsn = TRUE)
  
  # Generate summary statistics
  summary_stats <- market_panel %>%
    group_by(commodity) %>%
    summarise(
      n_observations = n(),
      mean_price = mean(price, na.rm = TRUE),
      sd_price = sd(price, na.rm = TRUE),
      missing_pct = mean(is.na(price)) * 100
    )
  
  write_csv(summary_stats, "data/processed/summary_stats.csv")
}

# Run main function
main()
