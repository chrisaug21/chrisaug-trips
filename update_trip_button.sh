#!/bin/bash

# CSS to replace the Mobile Trip button styling
OLD_CSS="    \/\* Mobile Trip button without icon \*\/
    @media \(max-width: 768px\) {
      .trip-home-link i, 
      .trip-home-link:before {
        display: none !important;
      }"

NEW_CSS="    \/* Mobile Trip button with home icon *\/
    @media (max-width: 768px) {
      .trip-home-link i {
        display: none !important;
      }
      
      .trip-home-link:before {
        content: \"\\f015\";
        font-family: \"Font Awesome 6 Free\";
        font-weight: 900;
        margin-right: 0.3rem;
        font-size: 0.85rem;
        display: inline-block !important;
      }
      
      \/* Ensure text content is just \"Trip\" *\/
      .trip-home-link span:after {
        content: \"\";
      }
      
      .trip-home-link span {
        font-size: 0.85rem;
      }"

echo "Updating Trip button in day pages..."

# Skip day1.html as we already updated it manually
for file in belgium-netherlands/day*.html; do
  if [[ "$file" != "belgium-netherlands/day1.html" ]]; then
    echo "Processing $file"
    
    # Use perl for better multiline replace than sed
    perl -i -0pe "s/$OLD_CSS/$NEW_CSS/g" "$file"
    
    echo "  Updated successfully"
  fi
done

echo "Trip button update complete!" 