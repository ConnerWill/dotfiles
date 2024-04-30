# shellcheck disable=1072,2148

function git-blame-percentages(){
  ## Define current pwd and input variables
  local current_pwd="${PWD}"
  local target_dir="${1:-${current_pwd}}"
  
  ## cd to target_dir and error if failed
  cd "${target_dir}" || printf "Unable to cd to directory:\t%s\n" "${target_dir}" || return 1

  ## Get repository name
  local repo_name=$(basename $(git rev-parse --show-toplevel))

  ## Get repository branch name
  local repo_branch=$(git rev-parse --abbrev-ref HEAD)

  ## Get current date
  local current_date=$(date +"%Y-%m-%d")

  ## Print repository information
  printf "Repository:  %s\n" "${repo_name}"
  printf "Branch:      %s\n" "${repo_branch}"
  printf "Date:        %s\n" "${current_date}"
  printf "\n"
  
  ## Get percentages
  git ls-files "${target_dir}"                             \
    | xargs -I{} git blame --line-porcelain {} 2>/dev/null \
      | grep "^author " 2>/dev/null                        \
        | sed 's/author //'                                \
          | sort                                           \
            | uniq -c                                      \
              | awk '{ arr[$2 " " $3]+=$1 } END { for (i in arr) { total += arr[i]; } for (i in arr) { printf "%s: %.2f%%\n", i, (arr[i] / total) * 100; } }'
  
  ## cd back to original directory and error if failed
  cd "${current_pwd}" || printf "Unable to cd back to directory:\t%s\n" "${current_pwd}" || return 1
}
