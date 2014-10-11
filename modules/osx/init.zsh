#
# Defines macOS aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if [[ "$OSTYPE" != darwin* ]]; then
  return 1
fi

#
# Aliases
#
if [[ -e /Users/tsaeger/.nix-profile/bin/vim ]] ; then
    alias vim='/Users/tsaeger/.nix-profile/bin/vim'
    alias vi='/Users/tsaeger/.nix-profile/bin/vim'
    alias view='/Users/tsaeger/.nix-profile/bin/vim -R'
else
    which nvim > /dev/null
    if [ $? -eq 0 ]; then
        alias vim='nvim'
        alias vi='nvim'
        alias view='nvim -R'
    # else
    #     alias vim='mvim -v'
    #     alias vi='vim'
    #     alias view='mvim -vR'
    fi
fi

# Changes directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Pushes directory to the current Finder directory.
alias pushdf='pushd "$(pfd)"'
