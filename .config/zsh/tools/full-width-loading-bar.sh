BAR_CHAR_START="["
BAR_CHAR_END="]"
BAR_CHAR_EMPTY="."
BAR_CHAR_FULL="="
BRACKET_CHARS=$(( ${#BAR_CHAR_START} + ${#BAR_CHAR_END} ))
LIMIT=100
BAR_WIDTH=$(( COLUMNS - 5 ))

print_progress_bar()
{
        # Calculate how many characters will be full.
        full_limit=$(($(($(($1 - BRACKET_CHARS)) * $2)) / LIMIT))

        # Calculate how many characters will be empty.
        empty_limit=$(($(($1 - BRACKET_CHARS)) - full_limit))

        # Prepare the bar.
        bar_line="${BAR_CHAR_START}"
        for ((j=0; j<full_limit; j++)); do
                bar_line="${bar_line}${BAR_CHAR_FULL}"
        done

        for ((j=0; j<empty_limit; j++)); do
                bar_line="${bar_line}${BAR_CHAR_EMPTY}"
        done

        bar_line="${bar_line}${BAR_CHAR_END}"

        printf "%3d%% %s" "${2}" "${bar_line}"
}

# Here is a sample of code that uses it.
MAX_PERCENT=100
for ((i=0; i<=MAX_PERCENT; i++)); do
        #
        sleep 0.1
        # ... Or run some other commands ...
        #
        print_progress_bar "${BAR_WIDTH}" "${i}"
        echo -en ""
done

echo ""
