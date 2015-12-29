#!/usr/bin/env bash
# -*- mode: shell-script -*-
#
# Tangle .org files with org-mode
# Example usage:
#    ∴ tangle nested-in-all.org
#    Files:  "nested-in-all.org", Dir: /Users/hinmanm/es-scripts
#    Tangled 6 code blocks from nested-in-all.org

# Set this to the location of your emacs executable
EMACSCMD="emacs"

# wrap each argument in the code required to call tangle on it
DIR=`pwd`
FILES=""
for file in $@; do
    echo "File: $file"
    $EMACSCMD -nw --batch --eval "
(progn
  (require 'org-install)
  (find-file (expand-file-name \"$file\" \"$DIR\"))
  (org-babel-tangle)
  (kill-buffer))" 2>&1 | grep "Tangled"
done
