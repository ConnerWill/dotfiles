fzf is a Unix filter program that reads input from standard input and writes selected items to standard output. In order not to taint the standard output stream, it displays the finder to standard error. Having that in mind, you can easily integrate fzf into your programs. Here are a few examples. Feel free to add more examples for different programming languages.

## Ruby

(source: https://junegunn.kr/2016/02/using-fzf-in-your-program)

We write `with_filter` function that takes fzf command as the first argument and a block which produces the input to the command, and returns the selected entries as an array.

```ruby
def with_filter(command)
  io = IO.popen(command, 'r+')
  begin
    stdout, $stdout = $stdout, io
    yield rescue nil
  ensure
    $stdout = stdout
  end
  io.close_write
  io.readlines.map(&:chomp)
end

with_filter('fzf -m') do
  1000.times do |n|
    puts n
    sleep 0.005
  end
end
```

The function is generic in the sense you can use it with any other external interactive/non-interactive filters, e.g. `fzf-tmux` or `grep 123`.

## Clojure

```clojure
(require '[clojure.java.io :as io])
(import 'java.lang.ProcessBuilder$Redirect)

(defmacro with-filter
  [command & forms]
  `(let [sh#  (or (System/getenv "SHELL") "sh")
         pb#  (doto (ProcessBuilder. [sh# "-c" ~command])
                (.redirectError
                  (ProcessBuilder$Redirect/to (io/file "/dev/tty"))))
         p#   (.start pb#)
         in#  (io/reader (.getInputStream p#))
         out# (io/writer (.getOutputStream p#))]
     (binding [*out* out#]
       (try ~@forms (.close out#) (catch Exception e#)))
     (take-while identity (repeatedly #(.readLine in#)))))

(with-filter "fzf -m"
  (dotimes [n 1000]
    (println n)
    (Thread/sleep 5)))
```

You might have noticed a reference to `/dev/tty` which makes the code not portable across different platforms.

## Go

```go
package main

import (
    "fmt"
    "io"
    "os"
    "os/exec"
    "strings"
    "time"
)

func withFilter(command string, input func(in io.WriteCloser)) []string {
    shell := os.Getenv("SHELL")
    if len(shell) == 0 {
        shell = "sh"
    }
    cmd := exec.Command(shell, "-c", command)
    cmd.Stderr = os.Stderr
    in, _ := cmd.StdinPipe()
    go func() {
        input(in)
        in.Close()
    }()
    result, _ := cmd.Output()
    return strings.Split(string(result), "\n")
}

func main() {
    filtered := withFilter("fzf -m", func(in io.WriteCloser) {
        for i := 0; i < 1000; i++ {
            fmt.Fprintln(in, i)
            time.Sleep(5 * time.Millisecond)
        }
    })
    fmt.Println(filtered)
}
```