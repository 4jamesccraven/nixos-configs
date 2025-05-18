{ pkgs, ... }:

with pkgs;
writers.writePython3Bin "export_nvim" { } ''
  from argparse import ArgumentParser, Namespace
  from pathlib import Path
  from tempfile import TemporaryDirectory
  from typing import Optional
  import json
  import os
  import re
  import tarfile as tf


  def load_file(file: str) -> str:
      with open(file, 'r', encoding='utf8') as f:
          return f.read()


  def write_file(file: str, contents: str) -> None:
      with open(file, 'x', encoding='utf8') as f:
          f.write(contents)


  def write_plugin_str(package: str, config: Optional[str]) -> str:
      contents = 'return {\n' \
                 + '    "' + package + '",\n' \
                 + '    ' + 'config = function()\n'

      if config:
          # Wire in the header image
          config = re.sub(r'dashboard.section.header = dofile\(.*\)',
                          'dashboard.section.header = require\'config.header\''',
                          config)

          # Wire in the map function
          config = re.sub(r'^(\s*)map\((.*?)\)',
                          r"\1require'config.map'(\2)",
                          config,
                          flags=re.MULTILINE)

          config = '\n'.join(
              list(map(lambda line: (' ' * 8) + line, config.splitlines())))
          contents = contents + config

      contents = contents \
          + '\n    ' + 'end\n' \
          + '}'

      return contents


  def cli() -> Namespace:
      DESC = 'build a concrete lua copy of my neovim config'
      parser = ArgumentParser('build_config.py',
                              description=DESC)

      parser.add_argument('--header',
                          help='path to header file for alpha',
                          type=Path,
                          required=True)

      parser.add_argument('--json',
                          help='path to parsed neovim json',
                          type=Path,
                          required=True)

      parser.add_argument('--lazy',
                          help='path to lazy bootstrap file',
                          type=Path,
                          required=True)

      parser.add_argument('--map',
                          help='path to map function definition',
                          type=Path,
                          required=True)

      return parser.parse_args()


  def main() -> None:
      args = cli()

      # Load in files from arguments
      header = load_file(args.header)
      bootstrap = load_file(args.lazy)
      map_fn = load_file(args.map)

      with open(args.json, 'r', encoding='utf8') as f:
          config = json.load(f)

      # Make a temporary directory to build the config
      with TemporaryDirectory() as temp:
          config_dir = temp + '/lua/config/'
          plugin_dir = temp + '/lua/plugins/'

          os.makedirs(config_dir)
          os.makedirs(plugin_dir)

          # Write init.lua and wire in lazy.nvim
          write_file(temp + '/init.lua',
                     config['init'] + '\nrequire\'config.lazy\'\n')

          # Write software I may need to install manually
          write_file(temp + '/dependencies.txt',
                     '\n'.join(config['dependencies']))

          # Bootstrap lazy.nvim, add header and map() declarations
          write_file(config_dir + 'lazy.lua', bootstrap)
          write_file(config_dir + 'header.lua', header)
          write_file(config_dir + 'map.lua', map_fn)

          plugins = config['plugins']

          # Make a plugin file for each plugin
          for plugin in plugins:
              filename = plugin['name'] + '.lua'
              text = write_plugin_str(plugin['packageName'], plugin['config'])

              with open(plugin_dir + filename, 'x', encoding='utf8') as f:
                  f.write(text)

          # Tar the contents of the temporary directory into the cwd
          with tf.open('nvim-config.tar.gz', 'w:gz') as tar:
              for root, _, files in os.walk(temp):
                  for file in files:
                      file_path = os.path.join(root, file)
                      tar.add(file_path,
                              arcname=os.path.relpath(file_path, temp))


  if __name__ == '__main__':
      main()
''
