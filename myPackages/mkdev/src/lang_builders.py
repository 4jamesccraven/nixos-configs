import os
import boilerplates
from typing import List
from os.path import join


def write_bp(filename: str, boilerplate: 'List[str]'):
    '''
    Writes a collection of boilerplate joined by new lines
    to a path.
    '''
    try:
        with open(filename, 'x') as f:
            f.write('\n'.join(boilerplate))
    except FileExistsError:
        print(f'{filename} already exists.')


def ensure_dirs(directories: 'List[str] | str'):
    '''
    Ensures that all the given directories exist
    '''
    if isinstance(directories, list):
        for dir in directories:
            if not os.path.isdir(dir):
                os.mkdir(dir)
    else:
        if not os.path.isdir(directories):
            os.mkdir(directories)


def cpp_env(arguments):
    dir: str = arguments.directory
    file: str = arguments.filename
    one_file: bool = arguments.one_file

    full_path = join(dir, f'{file}.cpp') \
        if one_file else join(dir, 'src/'f'{file}.cpp')

    ensure_dirs(dir)

    if not one_file:
        # Directories for project structure
        p_dirs = ['bin', 'inc', 'src', 'obj']
        p_dirs = [join(dir, p_dir) for p_dir in p_dirs]

        ensure_dirs(p_dirs)

        makefile_path = join(dir, 'Makefile')

        write_bp(makefile_path, boilerplates.CPP_MAKEFILE(arguments.filename))

    write_bp(full_path, boilerplates.CPP)


def tex_env(arguments):
    dir: str = arguments.directory
    file: str = arguments.filename
    beamer: bool = arguments.beamer

    ensure_dirs(dir)

    full_path = join(dir, f'{file}.tex')

    file_content = boilerplates.TEX_BEAMER \
        if beamer else boilerplates.TEX

    write_bp(full_path, file_content)


def py_env(arguments):
    dir: str = arguments.directory
    file: str = arguments.filename
    module: bool = arguments.module

    ensure_dirs(dir)

    full_path = join(dir, f'{file}.py') \
        if not module else join(dir, '__init__.py')

    file_content = boilerplates.PYTHON \
        if not module else boilerplates.PYTHON_MODULE

    write_bp(full_path, file_content)


def java_env(arguments):
    dir: str = arguments.directory
    file: str = arguments.filename
    makefile: str = arguments.makefile

    full_path = join(dir, f'{file}.java')

    ensure_dirs(dir)

    write_bp(full_path, boilerplates.JAVA(file))

    if makefile:
        makefile_path = join(dir, 'Makefile')
        write_bp(makefile_path, boilerplates.JAVA_MAKEFILE(file))


def nix_env(arguments):
    dir: str = arguments.directory
    file: str = arguments.filename
    type: str = arguments.type

    full_path = join(dir, f'{file}.nix')

    ensure_dirs(dir)

    file_content = None
    match type:
        case 'default':
            file_content = boilerplates.NIX
        case 'hm':
            file_content = boilerplates.NIX_HM
        case 'sh':
            file_content = boilerplates.NIX_SHELL
        case _:
            print(f'Error: undefined nix file type \'{type}\']')

    write_bp(full_path, file_content)
