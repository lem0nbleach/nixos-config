#!/usr/bin/env bash

pkill hyprsunset

# Get current time in minutes
current_hour=$(date +%H)
current_minute=$(date +%M)
current_time_minutes=$((current_hour * 60 + current_minute))

# Convert times to minutes by Hours*60 + Minutes
evening_start=1200  # 8:00 PM
morning_end=270     # 4:30 AM

if [[ "$current_time_minutes" -ge "$evening_start" ]] || [[ "$current_time_minutes" -le "$morning_end" ]]; then
  echo "Changing to nighttime hyprsunset"
  hyprsunset -t 4500
else
  echo "Changing to default hyprsunset"
  hyprsunset --identity
fi
