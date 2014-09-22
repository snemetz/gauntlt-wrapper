#!/bin/bash

# Generate attacks
bundle exec thor gauntlt_gen:generate
# Run Gauntlt
gauntlt attacks/*.attack
