#!/usr/bin/env bash

echo "Generating README.md..."
{
  echo "# Wallpapers"
  echo ""
  echo "<table>"
} > README.md

count=0
row_open=false

# Sorted images
for img in $(find . -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | sort -V); do
    if (( count % 3 == 0 )); then
        echo "  <tr>" >> README.md
        row_open=true
    fi

    img_clean="${img#./}"  # remove leading ./ for cleaner output
    echo "    <td align=\"center\" width=\"300px\">" >> README.md
    echo "      <img src=\"$img_clean\" width=\"300px\"><br>" >> README.md
    echo "    </td>" >> README.md

    ((count++))

    if (( count % 3 == 0 )); then
        echo "  </tr>" >> README.md
        row_open=false
    fi
done

# Close last row if needed
if $row_open; then
    echo "  </tr>" >> README.md
fi

echo "</table>" >> README.md
echo "README.md updated!"