# Minimal Dotfiles

For remote ssh sessions, mainly based on my [dotfiles](https://github.com/julianorchard/dotfiles) but with package management (and scripts) removed.

## Usage

Install with the ansible playbook in `run.yaml`.

Add your host configuration to a file called, 'hosts'. Then:

```sh
./run.yaml -i hosts
```

## License

Code in this repository is under the MIT License. See the [License](/LICENSE) file for more information.
