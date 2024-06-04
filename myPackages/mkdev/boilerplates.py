from typing import List
import os

CPP = [
    '#include<iostream>',
    '',
    'int main(int argc, char* argv[]) {',
    '',
    '    return 0;',
    '}',
    '',
]

PYTHON = [
    '# Imports placedholder',
    '',
    '',
    'def main() -> None:',
    '    ...',
    '',
    '',
    'if __name__ == \'__main__\':',
    '    main()',
    '',
]

PYTHON_MODULE = [
    '# Imports placeholder',
    '',
    '__all__ = []',
    '',
]

TEX = [
    '\\documentclass[12pt]{article}',
    '\\usepackage{amsmath,amssymb,amsfonts}',
    '\\usepackage[margin=1in]{geometry}',
    '\\usepackage{graphicx}',
    '\\title{}',
    '\\author{}',
    '',
    '',
    '\\begin{document}',
    '\\fontsize{14}{22}\\selectfont',
    '\\maketitle',
    '',
    '',
    '\\end{document}',
]

TEX_BEAMER = [
    '% Imports',
    '\\documentclass[9pt, dvipsnames]{beamer}',
    '\\usepackage{times}',
    '\\usepackage{amsmath}',
    '\\usepackage{amsthm}',
    '\\usepackage{verbatim}',
    '\\usepackage{anyfontsize}',
    '\\usepackage{subcaption}',
    '\\usepackage{graphicx}',
    '\\usepackage[export]{adjustbox}',
    '\\usepackage[multidot]{grffile}',
    '\\usepackage{tabularx}',
    '\\usepackage{tikz}',
    '\\usepackage{wasysym}',
    '\\usepackage{amsmath,amssymb,amsfonts}',
    '% \\usepackage[margin=1in]{geometry}',
    '',
    '% Beamer Themes',
    '\\usetheme[secheader]{Boadilla}',
    '\\usecolortheme{beaver}',
    '\\usefonttheme{professionalfonts}',
    '\\setbeamertemplate{caption}[numbered]',
    '',
    '% Counter',
    '\\newcounter{saveenumi}',
    '\\resetcounteronoverlays{saveenumi}',
    '',
    '% Preamble',
    '\\title{}',
    '\\author{}',
    '\\date{}',
    '',
    '',
    '\\begin{document}',
    '',
    '',
    '\\maketitle',
    '',
    '',
    '\\end{document}',
]

NIX = [
    '{ pkgs, lib, config, ...}:',
    '',
    '{',
    '  ',
    '}',
]

NIX_SHELL = [
    'with import <nixpkgs> { };',
    '',
    'mkShell {',
    '',
    '  nativeBuildInputs = [',
    '  ',
    '  ];',
    '  ',
    '  shellHook = \'\'',
    '  \'\';',
    '}',
]


NIX_HM = [
    '{ pkgs, lib, config, ...}:',
    '',
    '{',
    '',
    f'  home-manager.users.{os.getlogin()} = {{',
    '    ',
    '  };',
    '',
    '}',
]


def JAVA(filename: str) -> 'List[str]':
    return [
        f'public class {filename} {{',
        '    public static void main(String[] args) {',
        '        ',
        '    }',
        '}',
        '',
    ]


def JAVA_MAKEFILE(filename: str) -> 'List[str]':
    return [
        '# Compilation order',
        f'CO := {filename}.class',
        '',
        '.PHONY: all',
        'all: $(CO)',
        '',
        '%.class: %.java',
        '	javac $<',
        '',
        '.PHONY: clean',
        'clean:',
        '	del *.class',
    ]


def CPP_MAKEFILE(filename: str) -> 'List[str]':
    return [f'exe = {filename}.exe',
            '',
            '###---Environment---###',
            'CXX = g++',
            'CXXFlags = -std=c++17 -I$(INCDIR) -Wall -pedantic',
            '',
            'BINDIR = ./bin',
            'INCDIR = ./inc',
            'SRCDIR = ./src',
            'OBJDIR = ./obj',
            '',
            'SRC = $(wildcard $(SRCDIR)/*.cpp)',
            'INC = $(wildcard $(INCDIR)/*.h)',
            'OBJ = $(SRC:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)',
            '',
            '###---Build---###',
            '.PHONY: all',
            'all: $(BINDIR)/$(exe)',
            '',
            '$(BINDIR)/$(exe): $(OBJ)',
            '	$(CXX) $(CXXFlags) -o $@ $(OBJ)',
            '',
            '$(OBJDIR)/%.o: $(SRCDIR)/%.cpp',
            '	$(CXX) $(CXXFlags) -o $@ -c $<',
            '',
            '###---Utilities---###',
            '.PHONY: clean, cleanwin',
            'clean:',
            '	rm -f $(BINDIR)/*.exe $(OBJDIR)/*.o',
            '',
            'cleanwin:',
            '	powershell -command \"Remove-Item $(BINDIR)/*.exe;'
            'Remove-Item $(OBJDIR)/*.o\"',
            '',
            ]
