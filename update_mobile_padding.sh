#!/bin/bash

# CSS to add for better mobile padding
CSS_SNIPPET='    /* Mobile Trip button without icon */
    @media (max-width: 768px) {
      .trip-home-link i, 
      .trip-home-link:before {
        display: none !important;
      }
      
      /* Reduce padding on mobile for container */
      .container {
        padding-left: 10px !important;
        padding-right: 10px !important;
        width: 95% !important;
      }
      
      /* Reduce card padding on mobile */
      .card, .travel-detail {
        padding: 1rem !important;
      }
    }
    
    /* Further reduce padding on very small screens */
    @media (max-width: 480px) {
      .container {
        padding-left: 5px !important;
        padding-right: 5px !important;
        width: 98% !important;
      }
      
      .card, .travel-detail {
        padding: 0.75rem !important;
      }
    }'

echo "Updating mobile padding in day pages..."

# Find all day pages (skip day1.html and day2.html as they're already updated)
for file in belgium-netherlands/day*.html; do
  if [[ "$file" != "belgium-netherlands/day1.html" && "$file" != "belgium-netherlands/day2.html" ]]; then
    echo "Processing $file"
    
    # Check if the file already has the mobile padding CSS
    if ! grep -q "Reduce padding on mobile for container" "$file"; then
      # Insert our CSS before the closing style tag
      sed -i '' "s|</style>|$CSS_SNIPPET\n  </style>|" "$file"
      echo "  Updated successfully"
    else
      echo "  Already has mobile padding CSS - skipping"
    fi
  fi
done

echo "Mobile padding update complete!" 