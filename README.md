# DesktopPets-Linux

Linux launchers and import packages for three Shimeji desktop-pet projects:

- `evil_neuro_shim`
- `neuro_shim`
- `The-Neuroling-Collection`

The original Shimeji-ee JARs are not reliable on current Linux/Java runtimes.
The launchers use [ShimeLinux](https://github.com/BujjuIsABee/shimelinux)
instead, keeping each project's imported data in a separate user profile.

## Requirements

- Java 21 or newer
- ShimeLinux 1.4.3 or newer
- X11 desktop session

Install ShimeLinux and set `SHIMELINUX_JAR` if its JAR is not installed at
`/usr/share/java/shimelinux.jar`. Then run one of:

```sh
./evil_neuro_shim/run-linux.sh
./neuro_shim/run-linux.sh
./The-Neuroling-Collection/run-linux.sh
```

The launchers use `$XDG_DATA_HOME/desktop-pets/shimelinux/` (or
`~/.local/share/desktop-pets/shimelinux/`) for isolated profiles. They do not
modify the checked-in project assets.

## Import into NeurolingsCE-Qt

Three ready-to-import archives are in `linux-mascot-imports/`. In
NeurolingsCE-Qt, drag an archive onto the manager window or use **File > Import**.
To regenerate them after changing project assets:

```sh
python3 prepare-linux-mascot-imports.py
```

## Included projects and attribution

Each project's original readme and license are retained in its directory. The
Collection sources are from the upstream project at
[neurofumo/The-Neuroling-Collection](https://github.com/neurofumo/The-Neuroling-Collection),
snapshot `f6a973f321c578904adab2def2fde2fb72ab55c7`. The local worktree's
uncommitted settings, logs, and resource edits are not included.

See [LINUX.md](LINUX.md) for compatibility findings and verification notes.
