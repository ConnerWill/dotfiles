


function _rclone_tree(){
  rclone tree                           \
    --max-depth 2             \
    --links                   \
    --modtime                 \
    --size                    \
    --protections             \
    --sort-modtime            \
    --sort-reverse            \
    --progress-terminal-title \
    --color                   \
    "${rcloneRemote}": | "${PAGER}"
