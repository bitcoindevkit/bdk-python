from setuptools import setup

setup(
    # This is required to ensure the library name includes the python version, abi, and platform tags
    # See issue #350 for more information
    has_ext_modules=lambda: True,
)