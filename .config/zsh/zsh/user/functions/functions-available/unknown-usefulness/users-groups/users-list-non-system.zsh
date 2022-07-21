function users-list-non-system(){
 awk -F ':' '
      BEGIN {
          printf("%-17s %-4s %-4s %-s\n", "NAME", "UID", "GID", "SHELL")
      }
      $3 >= 1000 && $1 != "nobody" {
          printf("%-17s %-d %-d %-s\n", $1, $3, $4, $7)
      }
  ' /etc/passwd
}
