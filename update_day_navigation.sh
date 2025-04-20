#!/bin/bash

# Update the navigation links for all day pages

DIR="belgium-netherlands"

# Titles for each day page
declare -a titles=(
  "Day 1: Travel Day | Belgium & Netherlands Trip"
  "Day 2: Travel Day & Ghent | Belgium & Netherlands Trip"
  "Day 3: Bruges (Day Trip) | Belgium & Netherlands Trip"
  "Day 4: Ghent | Belgium & Netherlands Trip"
  "Day 5: Option Day: Ghent or Bruges | Belgium & Netherlands Trip"
  "Day 6: Antwerp & Utrecht | Belgium & Netherlands Trip"
  "Day 7: Delft | Belgium & Netherlands Trip"
  "Day 8: Utrecht | Belgium & Netherlands Trip"
  "Day 9: Amsterdam (Day Trip) | Belgium & Netherlands Trip"
  "Day 10: Option Day: Amsterdam or Utrecht | Belgium & Netherlands Trip"
)

# Headers for each day page
declare -a headers=(
  "Day 1: Travel Day"
  "Day 2: Travel Day & Ghent"
  "Day 3: Bruges (Day Trip)"
  "Day 4: Ghent"
  "Day 5: Option Day: Ghent or Bruges"
  "Day 6: Antwerp & Utrecht"
  "Day 7: Delft"
  "Day 8: Utrecht"
  "Day 9: Amsterdam (Day Trip)"
  "Day 10: Option Day: Amsterdam or Utrecht"
)

# Descriptions for each day page
declare -a descriptions=(
  "Begin your journey to Belgium & the Netherlands."
  "Arrival and first exploration of Ghent."
  "Explore the fairytale city of Bruges."
  "Discover the medieval beauty of Ghent."
  "Option day: Second day in Ghent or Bruges."
  "Visit Antwerp and travel to Utrecht."
  "Discover Delft's famous blue pottery."
  "Explore Utrecht's canals and historic center."
  "Experience Amsterdam on King's Day!"
  "Option day: Second day in Amsterdam or Utrecht."
)

# Update navigation buttons text
declare -a prevText=(
  ""
  "Previous: Travel Day"
  "Previous: Travel Day & Ghent"
  "Previous: Bruges (Day Trip)"
  "Previous: Ghent"
  "Previous: Option Day: Ghent or Bruges"
  "Previous: Antwerp & Utrecht"
  "Previous: Delft"
  "Previous: Utrecht"
  "Previous: Amsterdam (Day Trip)"
)

declare -a nextText=(
  "Next: Travel Day & Ghent"
  "Next: Bruges (Day Trip)"
  "Next: Ghent"
  "Next: Option Day: Ghent or Bruges"
  "Next: Antwerp & Utrecht"
  "Next: Delft"
  "Next: Utrecht"
  "Next: Amsterdam (Day Trip)"
  "Next: Option Day: Amsterdam or Utrecht"
  ""
)

# Loop through the day pages
for i in {1..10}; do
  file="${DIR}/day${i}.html"
  echo "Updating $file..."
  
  # Update the title
  sed -i '' "s|<title>.*</title>|<title>${titles[$i-1]}</title>|" "$file"
  
  # Update the hero header and description
  sed -i '' "s|<h1>.*</h1>|<h1>${headers[$i-1]}</h1>|" "$file"
  sed -i '' "s|<p>.*</p>|<p>${descriptions[$i-1]}</p>|" "$file"
  
  # Update navigation buttons
  if [[ $i -eq 1 ]]; then
    # First day has only next button
    sed -i '' "s|<div class=\"navigation-buttons\">.*</div>|<div class=\"navigation-buttons\"><a href=\"day2.html\" class=\"btn btn-accent\">${nextText[$i-1]}</a></div>|" "$file"
  elif [[ $i -eq 10 ]]; then
    # Last day has only previous button
    sed -i '' "s|<div class=\"navigation-buttons\">.*</div>|<div class=\"navigation-buttons\"><a href=\"day9.html\" class=\"btn\">${prevText[$i-1]}</a></div>|" "$file"
  else
    # Middle days have both buttons
    prev=$((i-1))
    next=$((i+1))
    sed -i '' "s|<div class=\"navigation-buttons\">.*</div>|<div class=\"navigation-buttons\"><a href=\"day${prev}.html\" class=\"btn\">${prevText[$i-1]}</a> <a href=\"day${next}.html\" class=\"btn btn-accent\">${nextText[$i-1]}</a></div>|" "$file"
  fi
  
  echo "Updated $file"
done

echo "All day page navigations updated successfully!" 