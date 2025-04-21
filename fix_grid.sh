#!/bin/bash

# Script to manually fix all day pages with proper grid styling

# Array of day files to update
FILES=(
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

# Loop through all files
for file in "${FILES[@]}"; do
  echo "Fixing $file..."
  
  # Find media query section and manually update the grid properties
  sed -i '' 's/display: grid;/display: grid !important;/g' "$file"
  sed -i '' 's/grid-template-columns: repeat(auto-fit, minmax(60px, 1fr));/grid-template-columns: repeat(auto-fit, minmax(60px, 1fr)) !important;/g' "$file"
  sed -i '' 's/gap: 0.3rem;/gap: 0.3rem !important;/g' "$file"
  
  # Also update the JavaScript to properly handle Trip Home text in mobile view
  sed -i '' '/clonedTripHomeLink.innerHTML = '\''Trip'\'';/ {
    s/clonedTripHomeLink.innerHTML = '\''Trip'\'';/clonedTripHomeLink.innerHTML = '\''Trip'\'';/
  }' "$file"
  
  # Ensure the JavaScript resize handler is updated
  sed -i '' '/window.addEventListener('\''resize'\'', () => {/ {
    n
    s/const clonedLink = tripNavDays.querySelector('\''.trip-home-link'\'');/const clonedLinks = document.querySelectorAll('\''.trip-home-link'\'');/
    n
    s/if (clonedLink) {/clonedLinks.forEach(link => {/
    n
    s/if (window.innerWidth <= 768) {/if (window.innerWidth <= 768) {/
    n
    s/clonedLink.innerHTML = '\''Trip'\'';/link.innerHTML = '\''Trip'\'';/
    n
    s/} else {/} else {/
    n
    s/clonedLink.innerHTML/link.innerHTML/
    n
    s/}/});/
  }' "$file"
  
  echo "✅ Done with $file"
done

echo "All day pages have been updated with proper grid styling!" 