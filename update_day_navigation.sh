#!/bin/bash

# Script to update navigation styling on all day pages

# Array of all day files
DAY_FILES=(
  "belgium-netherlands/day1.html"
  "belgium-netherlands/day2.html"
  "belgium-netherlands/day3.html"
  "belgium-netherlands/day4.html"
  "belgium-netherlands/day5.html"
  "belgium-netherlands/day6.html"
  "belgium-netherlands/day7.html"
  "belgium-netherlands/day8.html"
  "belgium-netherlands/day9.html"
  "belgium-netherlands/day10.html"
  "belgium-netherlands/day11.html"
)

# For each day file
for file in "${DAY_FILES[@]}"; do
  echo "Updating $file..."
  
  # 1. Add text-align: center to desktop trip-nav-link
  sed -i '' 's/\.trip-nav-link {/\.trip-nav-link {\n      text-align: center;/g' "$file"
  
  # 2. Update mobile trip-nav-link with width and center alignment
  sed -i '' 's/\.trip-nav-link {\n        padding: 0\.4rem 0\.5rem;\n        font-size: 0\.85rem;/\.trip-nav-link {\n        padding: 0\.4rem 0\.5rem;\n        font-size: 0\.85rem;\n        width: 100%;\n        text-align: center;/g' "$file"
  
  # 3. Add rule to hide icon in mobile view
  sed -i '' 's/\.mobile-trip-home-link {\n        display: inline-block;\n      }/\.mobile-trip-home-link {\n        display: inline-block;\n      }\n      \n      \/* Remove icon from Trip Home button in mobile view *\/\n      \.trip-home-link i {\n        display: none;\n      }/g' "$file"
  
  echo "✅ Updated $file"
done

echo "All day pages updated with consistent navigation styling." 