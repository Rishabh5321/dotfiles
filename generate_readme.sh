#!/bin/bash

echo "Generating README.md..."
echo "# Wallpapers" > README.md
echo "" >> README.md
echo "<table>" >> README.md

shopt -s nullglob
count=0

for img in ./*.{png,jpg,jpeg}; do
    if [[ -f "$img" ]]; then
        if (( count % 3 == 0 )); then
            echo "<tr>" >> README.md
        fi

        echo "<td align=\"center\" width=\"300px\">" >> README.md
        echo "<img src=\"$img\" width=\"300px\"><br>" >> README.md
        echo "</td>" >> README.md

        ((count++))

        if (( count % 3 == 0 )); then
            echo "</tr>" >> README.md
        fi
    fi
done

# Close unclosed row
if (( count % 3 != 0 )); then
    echo "</tr>" >> README.md
fi

echo "</table>" >> README.md
echo "README.md updated!"
