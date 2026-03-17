{
  pkgs ? import <nixpkgs> { },
  ...
}:

let
  inherit (pkgs.writers) writePython3Bin;
in
writePython3Bin "rff" { } /* python */ ''
  import os
  import pty
  import subprocess
  import sys
  import time


  def run_fastfetch() -> bytes:
      ''''Run fastfetch and receive its output as bytes.''''
      output = []
      master, slave = pty.openpty()

      process = subprocess.Popen(
          ['fastfetch'],
          stdin=slave,
          stdout=slave,
          stderr=slave,
      )
      os.close(slave)

      while True:
          try:
              data = os.read(master, 4096)
              output.append(data)
          except OSError:
              break

      process.wait()
      os.close(master)
      return b'''.join(output)


  def main() -> None:
      try:
          sys.stdout.write('\033[?25l\033[s')  # ]]
          sys.stdout.flush()

          while True:
              output = run_fastfetch()
              sys.stdout.buffer.write(b"\033[u\033[J" + output)  # ]]
              sys.stdout.buffer.flush()

              time.sleep(0.1)
      except KeyboardInterrupt:
          ...
      finally:
          sys.stdout.write('\033[?25h')  # ]


  if __name__ == '__main__':
      main()
''
