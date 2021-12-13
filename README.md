# asdf-purge

purge plugin for [asdf](https://github.com/asdf-vm/asdf) version manager

## Requirements

### macOS

* Python 3.x: should be built-in in recent versions

### Linux

* Python 3.x

## Install

After installing [asdf](https://github.com/asdf-vm/asdf), install the plugin by running:

```bash
asdf plugin add purge https://github.com/henry40408/asdf-purge.git 
```

## Use

Dry run:

Print directories that will be purged then do nothing.

```bash
asdf purge
```

Purge:

Purge directories. Use with caution.

```bash
asdf purge -f
```

Help:

Print help message.

```bash
asdf purge -h
```

# License

MIT
