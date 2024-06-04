#!/usr/bin/env python

import argparse
import subprocess
import lang_builders

_NAME = 'mkdev'
_SUPPORTED = {
    'py': 'Python',
    'cpp': 'c++',
    'java': 'Java',
    'tex': 'LaTeX',
    'nix': 'Nix',
}


def get_args():
    # Create a parser and set it up to take a language and act as a sub command
    parser = argparse.ArgumentParser(prog=_NAME,
                                     usage=f'{_NAME} [-h] {{Language}}')
    subparsing = parser.add_subparsers(title='Language',
                                       dest='command')

    # Create subparsers for all supported languages
    subparsers = {k: subparsing.add_parser(k, prog=f'{_NAME} {k}')
                  for k, _ in _SUPPORTED.items()}

    # Add the three common arguments
    for p in subparsers:
        subparsers[p].add_argument('-f', '--filename',
                                   help='filename of main file',
                                   default='main')
        subparsers[p].add_argument('-d', '--directory',
                                   help='Directory to set up',
                                   default='.'
                                   )
        subparsers[p].add_argument('-c', '--code',
                                   help='Open VSCode on exit',
                                   action='store_true')

    # Python parser
    subparsers['py'].add_argument('-m', '--module',
                                  help='Set up project as module'
                                  'rather than script',
                                  action='store_true')

    # c++ parser
    subparsers['cpp'].add_argument('-one', '--one_file',
                                   help='Creates a single standalone file '
                                   'with no directory structure',
                                   action='store_true')

    # LaTeX parser
    subparsers['tex'].add_argument('-b', '--beamer',
                                   help='Sets up environment for beamer',
                                   action='store_true')

    # Java parser
    subparsers['java'].add_argument('-m', '--makefile',
                                    help='Generate a generic makefile '
                                    'for Java development',
                                    action='store_true')

    # Nix parser
    subparsers['nix'].add_argument('-t', '--type',
                                   help='Type of nix file to generate'
                                   ' [default, home-manager, shell]',
                                   choices=['default',
                                            'hm', 'sh'],
                                   default='default')

    return parser.parse_args()


def main() -> None:
    # Parse arguments
    arguments = get_args()

    # Run the appropriate steps for the given language
    match arguments.command:
        case 'cpp':
            lang_builders.cpp_env(arguments)

        case 'tex':
            lang_builders.tex_env(arguments)

        case 'py':
            lang_builders.py_env(arguments)

        case 'java':
            lang_builders.java_env(arguments)

        case 'nix':
            lang_builders.nix_env(arguments)
        case _:
            print(f'Usage: {_NAME} [-h] {{Language}}; see {_NAME} -h for more')
            return

    if arguments.code:
        subprocess.run(['code', arguments.directory])


if __name__ == '__main__':
    main()
