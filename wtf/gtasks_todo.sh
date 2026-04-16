#!/usr/bin/env bash

# Exit if any command fails
set -e

# Path to your wtfutil todo file
TODO_FILE="$HOME/.config/wtf/todo.yaml"

# Ensure the file exists and has the 'items:' root node
if [ ! -f "$TODO_FILE" ]; then
    echo "items:" > "$TODO_FILE"
fi

echo "🔄 Syncing Google Tasks to wtfutil..."

# 1. Fetch lists and strip the "[1] " prefix
while IFS= read -r list; do
    [ -z "$list" ] && continue
    echo "📂 Checking list: $list"

    # 2. Fetch tasks and parse the ASCII table
    # We now extract Column 2 (Title) AND Column 5 (Due Date), separated by a pipe
    TASKS=$(gtasks tasks -l "$list" view | awk -F'|' 'NR>3 {print $2 "|" $5}')

    # Read each parsed task line by line, splitting by the pipe character
    while IFS='|' read -r raw_title raw_date; do
        
        # Trim leading/trailing whitespace from both variables
        title=$(echo "$raw_title" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        date_str=$(echo "$raw_date" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

        # Skip empty lines
        [ -z "$title" ] && continue

        # 3. DATE FORMATTING
        # If the date is "-" (empty in gtasks), set it to null. 
        # Otherwise, convert it to yyyy-mm-dd.
        if [[ "$date_str" == "-" || -z "$date_str" ]]; then
            formatted_date="null"
        else
            # GNU date command dynamically converts "16 April 2026" to "2026-04-16"
            # We suppress errors to /dev/null and fallback to "null" if it fails to parse
            formatted_date=$(date -d "$date_str" +%Y-%m-%d 2>/dev/null || echo "null")
        fi

        # 4. DEDUPLICATION CHECK
        if ! grep -Fq "text: $title" "$TODO_FILE"; then
            echo "   -> ➕ Adding: $title (Due: $formatted_date)"
            
            # 5. APPEND TO YAML
            cat >> "$TODO_FILE" <<EOF
- checked: false
  date: $formatted_date
  tags:
  - $list
  text: $title
EOF
        else
            echo "   -> ⏭️  Skipping: $title"
        fi

    done <<< "$TASKS"

done < <(gtasks tasklists view | sed -n 's/^\[[0-9]*\] //p')

echo "✅ Sync complete!"
