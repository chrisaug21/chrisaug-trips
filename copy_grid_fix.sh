#!/bin/bash

# Script to copy the fixed CSS to all day pages
FIXED_STYLES=$(cat <<'ENDCSS'
    @media (max-width: 768px) {
      .trip-nav {
        padding: 0.5rem 0;
        top: 0; /* Ensure it's at the top */
      }
      
      .trip-nav-container {
        gap: 0.5rem;
      }
      
      .trip-nav-links {
        justify-content: flex-start;
        /* Move trip home link into the day nav row */
        display: none;
      }
      
      .trip-nav-days {
        justify-content: flex-start;
        width: 100%;
        overflow-x: visible; /* Remove horizontal scrolling */
        padding-bottom: 0.25rem;
        border-top: none; /* Remove top border */
        padding-top: 0; /* Remove top padding */
        display: grid !important;
        grid-template-columns: repeat(auto-fit, minmax(60px, 1fr)) !important;
        gap: 0.3rem !important;
      }

      .day-label {
        display: none;
      }
      
      .trip-nav-link {
        padding: 0.4rem 0.5rem;
        font-size: 0.85rem;
        width: 100%;
        text-align: center;
      }
      
      .mobile-trip-home-link {
        display: inline-block;
      }
      
      /* Remove icon from Trip Home button in mobile view */
      .trip-home-link i {
        display: none;
      }
    }
ENDCSS
)

# Array of all day files (excluding day1.html which we already fixed)
DAY_FILES=(
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
  echo "Fixing $file..."
  
  # Use sed to replace the media query section with our fixed version
  sed -i '' "/@media (max-width: 768px) {/,/}/c\\
$FIXED_STYLES" "$file"
  
  echo "✅ Fixed $file"
done

echo "All day pages updated with proper grid navigation styling!" 