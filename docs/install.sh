#!/bin/sh
git clone --bare git@github.com:julianorchard/minimal-dotfiles.git $HOME/.minimal-dotfiles
function mindots {
   git --git-dir=$HOME/.minimal-dotfiles/ --work-tree=$HOME $@
}
mkdir -p .minimal-dotfiles-backup
mindots checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dotfiles.";
  # TODO: Replace grep with sed only?
  mindots checkout 2>&1 | grep -E "^\s+.*$" | sed 's/\s+//g' | xargs -I{} sh -c 'mkdir -p `echo $(dirname "${HOME}/.minimal-dotfiles-backup/{}")` && mv "${HOME}/{}" "${HOME}/.minimal-dotfiles-backup/{}"'
fi
mindots checkout
mindots config status.showUntrackedFiles no
