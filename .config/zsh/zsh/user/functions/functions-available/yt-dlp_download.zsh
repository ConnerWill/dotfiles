#!/usr/bin/env zsh

#TODO: Figure out how to check how to see if this is already loaded
# autoload -Uz compinit
# compinit

# Check if yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    # printf "yt-dlp is not installed. Please install it to use the yt-dlp_download function.\n"
    return 0
fi

# Function: yt-dlp_download
# Description: Downloads a video from the specified URL in the best quality, including subtitles,
#              and saves it to the specified directory with the specified file name.
# Usage: yt-dlp_download -u <video_url> -o <output_directory> -f <file_name>
yt-dlp_download() {
    local url=""
    local output_dir=""
    local file_name=""

    # Nested function to display the help message
    display_help() {
      local calling_function="${1}"
        cat << EOF
Name:
 
  ${calling_function}


Options:

  -u, --url           URL of the video to download
  -o, --output-dir    Directory to save the downloaded video
  -f, --file-name     Name of the output file (without extension)
  -h, --help          Display this help message


Usage:

  ${calling_function} --url "<video_url>" --output-dir "<output_directory>" --file-name "<file_name>"


EOF
    }

    # Parse options
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -u|--url)
                url="${2}"
                shift 2
                ;;
            -o|--output-dir)
                output_dir="${2}"
                shift 2
                ;;
            -f|--file-name)
                file_name="${2}"
                shift 2
                ;;
            -h|--help)
                display_help "${0}"
                return 0
                ;;
            *)
                printf "Invalid option: %s\n" "${1}"
                display_help "${0}"
                return 1
                ;;
        esac
    done

    # Check if all parameters are provided
    if [[ -z "${url}" || -z "${output_dir}" || -z "${file_name}" ]]; then
        printf "Error: All parameters must be provided.\n"
        display_help "${0}"
        return 1
    fi

    # Append .mp4 extension if not already present
    if [[ "${file_name}" != *.mp4 ]]; then
        file_name="${file_name}.mp4"
    fi

    # Run yt-dlp command with specified options and progress display
    yt-dlp \
           --format "bestvideo+bestaudio"        \
           --merge-output-format mp4             \
           --write-subs                          \
           --sub-lang en                         \
           --sub-format srt                      \
           --convert-subs srt                    \
           --output "${output_dir}/${file_name}" \
           --progress                            \
           "${url}"
}

# # Completion function for yt-dlp_download
# _yt-dlp_download_completions() {
#     local cur prev opts
#     cur="${words[CURRENT]}"
#     prev="${words[CURRENT-1]}"
#
#     # Options completion
#     opts="-u --url -o --output-dir -f --file-name -h --help"
#     if [[ ${cur} == -* ]]; then
#         compadd ${opts}
#         return 0
#     fi
#
#     # URL completion (optional: provide your own logic for URL completion)
#     if [[ ${prev} == "-u" || ${prev} == "--url" ]]; then
#         opts=""  # Add URL completion logic here if desired
#         compadd ${opts}
#         return 0
#     fi
#
#     # Output directory completion
#     if [[ ${prev} == "-o" || ${prev} == "--output-dir" ]]; then
#         _files -/
#         return 0
#     fi
#
#     # File name completion
#     if [[ ${prev} == "-f" || ${prev} == "--file-name" ]]; then
#         _files
#         return 0
#     fi
# }
#
# # Register the completion function
# compdef _yt-dlp_download_completions yt-dlp_download

# Aliases for the function
alias youtube-download-video="yt-dlp_download"
alias ytdownload="yt-dlp_download"
alias ydlpvid="yt-dlp_download"

# Example usage (uncomment to use):
# yt-dlp_download -u "https://www.youtube.com/watch?v=example_video_id" -o "/home/user/Videos" -f "my_downloaded_video"
