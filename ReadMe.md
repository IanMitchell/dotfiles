# Dotfiles

These are my personal OSX dotfiles.

## Bash Profile

I use a custom blue/green color scheme. I also set my prompt to follow a `username@path$ ` format (ie, `ianmitchell@~/code$ `). There are autocomplete bits for Bash and SSH, as well as the rbenv line.

Specific to OSX, I've added aliases for `fixopenwith` and `showlibrary`. Show Library makes the `~/Library` folder visible, while fixopenwith cleans up the right click "Open With" context menu and removes duplicate entries.

## Inputrc

The only change here is making tab-autocomplete case insensitive.

## Gemrc

On install and updates, skip rdoc and ri.
