#!/usr/bin/env python

from setuptools import setup, find_packages

setup(name='mdkev',
      version='1.0',
      packages=find_packages(),
      scripts=['mkdev.py', 'lang_builders.py', 'boilerplates.py'])
