#!/bin/bash

for f in *.png
  do convert $f -negate dark/cmd/$f
done


