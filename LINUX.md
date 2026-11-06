# Linux compatibility

The three mascot projects use Shimeji-ee XML actions and PNG animation frames.
Their bundled Java launchers are not a working Linux runtime:

- The two Shimeji-ee JARs crash in their generic Linux backend with a
  `GenericEnvironment.tick()` null-pointer exception.
- The Neuroling Collection JAR depends on Nashorn's removed
  `jdk.nashorn.api.scripting` classes and fails on Java 21.

The per-project launchers use the open-source Linux port
[ShimeLinux](https://github.com/BujjuIsABee/shimelinux), rather than invoking
the incompatible bundled JARs. Install ShimeLinux and Java 21 or newer, then
run:

```sh
./evil_neuro_shim/run-linux.sh
./neuro_shim/run-linux.sh
./The-Neuroling-Collection/run-linux.sh
```

The launchers copy the relevant `conf/` and `img/` data to isolated profiles
under `${XDG_DATA_HOME:-~/.local/share}/desktop-pets/shimelinux/`. They do not
modify the project files or an existing ShimeLinux profile. Set `SHIMELINUX_JAR`
to select the ShimeLinux JAR location, or `JAVA` to select the Java executable.

Alternatively, [NeurolingsCE-Qt](https://github.com/qingchenyouforcc/NeurolingsCE-Qt)
publishes Linux AppImages and imports legacy Shimeji-ee archives. Three
prepared import archives are in `linux-mascot-imports/`. To rebuild them:

```sh
python3 prepare-linux-mascot-imports.py
```

The archives include mascot XML/PNG data and exclude local settings, logs,
Windows launchers, and Java libraries. The two otherwise identically named
`Shimeji` sets receive distinct names; Collection character names are preserved
so transform interactions can continue to work. In NeurolingsCE-Qt, drag an
archive onto the manager window or use **File > Import**.

The JAR failures were reproduced in isolated copies under X11. Each ShimeLinux
launcher passed an eight-second X11 startup smoke test without logged
exceptions; these short runs do not establish long-term behavior. The
NeurolingsCE-Qt GUI import has not been exercised in this workspace.
