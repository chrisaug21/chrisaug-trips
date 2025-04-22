#!/bin/bash

# Update CSS for each remaining file
for file in belgium-netherlands/day{5,6,7,8,9,10,11}.html; do
  echo "Processing $file"
  
  # Use sed to replace the CSS block
  sed -i '' 's/\/\* Mobile Trip button without icon \*\/[[:space:]]*@media (max-width: 768px) {[[:space:]]*\.trip-home-link i,[[:space:]]*\.trip-home-link:before {[[:space:]]*display: none !important;[[:space:]]*}/\/* Mobile Trip button with home icon *\/\
    @media (max-width: 768px) {\
      .trip-home-link i {\
        display: none !important;\
      }\
      \
      .trip-home-link:before {\
        content: "\\f015";\
        font-family: "Font Awesome 6 Free";\
        font-weight: 900;\
        margin-right: 0.3rem;\
        font-size: 0.85rem;\
        display: inline-block !important;\
      }\
      \
      \/* Ensure text content is just "Trip" *\/\
      .trip-home-link span:after {\
        content: "";\
      }\
      \
      .trip-home-link span {\
        font-size: 0.85rem;\
      }/g' "$file"
  
  echo "  Updated successfully"
done

echo "All remaining Trip buttons updated!" 