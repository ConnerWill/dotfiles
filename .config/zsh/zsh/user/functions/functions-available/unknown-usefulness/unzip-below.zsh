
function unzip-below(){
  doneloop=0
  while [ $doneloop -eq 0 ]; do
    x=$((x+1))
    pwdf=$(pwd)
    zipbackups="$pwdf/zip-backups"

    mkdir -v -p "$zipbackups" \
      || echo "UNABLE TO CREATE DIR TO PLACE .zip FILES" \
        || return 1

    for file in *; do
      if [[ ${file: -4} == ".zip" ]]; then
        echo -e "\tUnzipping:\t${file}" \

        unzip "${file}" \
        && mv --force --verbose \
            "${file}" \
            "${zipbackups}" \
            && echo -e "Moved: ${file} to: ${zipbackups}/${file}" \
        || echo -e "\n\nERROR\n\n" \
            || exit 1

        echo $x
        y=$((y+1))
      fi
    done
  doneloop=1
  done
  echo -e "\n\nExtracted '$y' archives\nArchives have been saved to '$zipbackups'"
}

function unzip-below-rm(){
  doneloop=0
  while [ $doneloop -eq 0 ]; do
    x=$((x+1))
    pwdf=$(pwd)
    for file in *; do
      if [[ ${file: -4} == ".zip" ]]; then
        unzip "${file}" \
          && rm -f -v "${file}"
        echo $x
        y=$((y+1))
      fi
    done
  doneloop=1
  echo -e "\n\nExtracted '$y' archives\nArchives have been deleted."
  done
}


