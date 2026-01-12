#!/usr/bin/env bash

# Set up git configuration
git config --global user.name "omeyenburg"
git config --global user.email "omeyenburg@gmail.com"
git config --global core.editor "nvim"
git config --global core.excludesfile "~/.config/git/gitignore_global"
git config --global fetch.autoFetch true
git config --global color.ui true
git config --global init.defaultBranch main

# Enable commit signing with GPG
git config --global user.signingkey 455ABBC1D8C33DA9
git config --global commit.gpgsign true
git config --global gpg.format openpgp
git config --global gpg.program gpg

echo "Git configuration applied, GPG signing enabled."
