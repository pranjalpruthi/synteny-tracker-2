#!/bin/bash

# Create target directories
mkdir -p $PREFIX/bin
mkdir -p $PREFIX/opt/syntenytracker2

# Copy main script and modules
cp run_synteny.pl $PREFIX/opt/syntenytracker2/
cp -r modules $PREFIX/opt/syntenytracker2/

# Make script executable
chmod +x $PREFIX/opt/syntenytracker2/run_synteny.pl

# Create symlinks in bin
ln -s $PREFIX/opt/syntenytracker2/run_synteny.pl $PREFIX/bin/run_synteny.pl
ln -s $PREFIX/opt/syntenytracker2/run_synteny.pl $PREFIX/bin/syntenytracker2
