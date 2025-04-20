#!/bin/bash

# Script to update the navigation section in all day pages for Belgium-Netherlands trip

# The directory containing the day pages
DIR="belgium-netherlands"

# Loop through day pages (day2.html through day10.html)
for i in {2..10}; do
  FILE="$DIR/day$i.html"
  
  echo "Updating $FILE..."
  
  # Update the navigation links with the new classes
  sed -i '' 's/<a href="\.\.\/index\.html" class="trip-nav-link"><i class="fas fa-home"><\/i> All Trips<\/a>/<a href="..\/index.html" class="trip-nav-link all-trips-link"><i class="fas fa-home"><\/i> All Trips<\/a>/g' "$FILE"
  
  sed -i '' 's/<a href="index\.html" class="trip-nav-link"><i class="fas fa-map-marked-alt"><\/i> Trip Home<\/a>/<a href="index.html" class="trip-nav-link trip-home-link"><i class="fas fa-map-marked-alt"><\/i> <span>Trip Home<\/span><\/a>/g' "$FILE"
  
  # Add the day labels to the day links if they don't have them
  if ! grep -q 'day-label' "$FILE"; then
    # Update day links with day labels
    local_sed='s/<a href="day1\.html" class="trip-nav-link">Day 1<\/a>/<a href="day1.html" class="trip-nav-link">Day 1 <span class="day-label">(Tue)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
    
    local_sed='s/<a href="day2\.html" class="trip-nav-link">Day 2<\/a>/<a href="day2.html" class="trip-nav-link">Day 2 <span class="day-label">(Wed)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
    
    local_sed='s/<a href="day3\.html" class="trip-nav-link">Day 3<\/a>/<a href="day3.html" class="trip-nav-link">Day 3 <span class="day-label">(Thu)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
    
    local_sed='s/<a href="day4\.html" class="trip-nav-link">Day 4<\/a>/<a href="day4.html" class="trip-nav-link">Day 4 <span class="day-label">(Fri)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
    
    local_sed='s/<a href="day5\.html" class="trip-nav-link">Day 5<\/a>/<a href="day5.html" class="trip-nav-link">Day 5 <span class="day-label">(Sat)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
    
    local_sed='s/<a href="day6\.html" class="trip-nav-link">Day 6<\/a>/<a href="day6.html" class="trip-nav-link">Day 6 <span class="day-label">(Sun)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
    
    local_sed='s/<a href="day7\.html" class="trip-nav-link">Day 7<\/a>/<a href="day7.html" class="trip-nav-link">Day 7 <span class="day-label">(Mon)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
    
    local_sed='s/<a href="day8\.html" class="trip-nav-link">Day 8<\/a>/<a href="day8.html" class="trip-nav-link">Day 8 <span class="day-label">(Tue)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
    
    local_sed='s/<a href="day9\.html" class="trip-nav-link">Day 9<\/a>/<a href="day9.html" class="trip-nav-link">Day 9 <span class="day-label">(Wed)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
    
    local_sed='s/<a href="day10\.html" class="trip-nav-link">Day 10<\/a>/<a href="day10.html" class="trip-nav-link">Day 10 <span class="day-label">(Thu)<\/span><\/a>/g'
    sed -i '' "$local_sed" "$FILE"
  fi
  
  # Update the CSS styles to match day1.html
  # Find the CSS section for .trip-nav
  sed -i '' '/\.trip-nav {/,/\.trip-nav-link\.active {/c\
    .trip-nav {\
      background-color: var(--white);\
      padding: 0.75rem 0;\
      position: sticky;\
      top: 70px;\
      z-index: 90;\
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);\
      margin-bottom: 1.5rem;\
    }\
\
    .trip-nav-container {\
      display: flex;\
      flex-direction: row;\
      justify-content: space-between;\
      align-items: center;\
      flex-wrap: wrap;\
      gap: 0.75rem;\
    }\
\
    .trip-nav-links, .trip-nav-days {\
      display: flex;\
      gap: 0.5rem;\
      flex-wrap: wrap;\
    }\
\
    .trip-nav-link {\
      padding: 0.5rem 1rem;\
      background-color: var(--light-bg);\
      border-radius: 4px;\
      font-weight: 600;\
      font-size: 0.9rem;\
      transition: all 0.2s ease;\
      color: var(--dark-text);\
    }\
\
    .trip-nav-link:hover {\
      background-color: var(--primary);\
      color: var(--white);\
    }\
\
    .trip-nav-link.active {\
      background-color: var(--primary);\
      color: var(--white);\
    }' "$FILE"
  
  # Add the media queries if they don't exist
  if ! grep -q '\.trip-nav-link\.all-trips-link' "$FILE"; then
    # Find the closing brace of the trip-nav-link.active and add the media queries after it
    sed -i '' '/\.trip-nav-link\.active {/,/}/a\
\
    @media (max-width: 768px) {\
      .trip-nav {\
        padding: 0.5rem 0;\
        top: 59px; /* Adjusted to prevent overlap with top nav */\
      }\
      \
      .trip-nav-container {\
        flex-direction: column;\
        gap: 0.5rem;\
      }\
      \
      .trip-nav-links {\
        justify-content: flex-start;\
      }\
      \
      .trip-nav-days {\
        justify-content: flex-start;\
        width: 100%;\
        flex-wrap: wrap; /* Allow wrapping for day buttons */\
        overflow-x: visible; /* Remove horizontal scrolling */\
        padding-bottom: 0.25rem;\
      }\
      \
      .day-label {\
        display: none;\
      }\
      \
      .trip-nav-link {\
        padding: 0.4rem 0.75rem;\
        font-size: 0.85rem;\
      }\
      \
      .trip-nav-link.all-trips-link {\
        display: none; /* Hide All Trips link on mobile */\
      }\
      \
      .trip-nav-link.trip-home-link span {\
        display: none; /* Hide text on mobile */\
      }\
    }\
\
    @media (max-width: 480px) {\
      .trip-nav-link {\
        padding: 0.3rem 0.6rem;\
        font-size: 0.8rem;\
      }\
    }' "$FILE"
  fi
  
  echo "Updated $FILE"
done

echo "All day pages updated successfully!" 