# Minimal Dotfiles

For remote ssh sessions. Bringing that feeling of home to remote.

Mainly based on my [dotfiles](https://github.com/julianorchard/dotfiles) but with package management (and scripts) removed.

## Usage

Run this command on the remote machine you wish to work on:

```sh
curl -Lks https://julianorchard.github.io/minimal-dotfiles/install.sh | /bin/bash
```

Credit once again to [this Atlassian article](https://www.atlassian.com/git/tutorials/dotfiles) and specifically this [original source by durdn](https://bitbucket.org/durdn/cfg/src/master/.bin/install.sh).

Then, if you have Ansible installed locally:

```sh
source ~/.bashrc
mindots-install
```

You can also run the playbook remotely or install required applications (at the time of writing: [fzf](https://github.com/junegunn/fzf), [tmux](https://github.com/tmux/tmux), and [vim](https://github.com/vim/vim)) manually.

## License

Code in this repository is under the MIT License. See the [License](/LICENSE) file for more information.
