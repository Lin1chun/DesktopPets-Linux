# DesktopPets-Linux

Linux 桌宠适配：为三个 Shimeji 桌宠项目提供 Linux 启动器，以及可导入 NeurolingsCE-Qt 的资源包。

- `evil_neuro_shim`
- `neuro_shim`
- `The-Neuroling-Collection`

原版 Shimeji-ee JAR 在现代 Linux/Java 环境下无法可靠运行。本项目通过
[ShimeLinux](https://github.com/BujjuIsABee/shimelinux) 启动，并为每个项目使用独立配置目录。

## 中文使用说明

### 环境要求

- Java 21 或更新版本
- ShimeLinux 1.4.3 或更新版本
- X11 桌面会话

安装 ShimeLinux。如果 JAR 不在 `/usr/share/java/shimelinux.jar`，请设置
`SHIMELINUX_JAR`。然后运行对应启动器：

```sh
./evil_neuro_shim/run-linux.sh
./neuro_shim/run-linux.sh
./The-Neuroling-Collection/run-linux.sh
```

启动器会将资源复制到独立目录：
`${XDG_DATA_HOME:-~/.local/share}/desktop-pets/shimelinux/`，不会修改项目资源。

### 导入 NeurolingsCE-Qt

`linux-mascot-imports/` 中包含三个可导入压缩包。将 ZIP 拖入 NeurolingsCE-Qt
管理窗口，或使用 **File > Import**。修改资源后可运行以下命令重新生成：

```sh
python3 prepare-linux-mascot-imports.py
```

更多兼容性说明和验证结果见 [LINUX.md](LINUX.md)。

### 来源与授权

各项目目录保留了原始说明和许可证。Collection 文件来自上游项目
[neurofumo/The-Neuroling-Collection](https://github.com/neurofumo/The-Neuroling-Collection)，
版本快照为 `f6a973f321c578904adab2def2fde2fb72ab55c7`。本仓库不包含原工作区中的用户设置更改和运行日志。

## English

Linux adaptations for three Shimeji desktop-pet projects. This repository provides
Linux launchers and import archives for NeurolingsCE-Qt:

- `evil_neuro_shim`
- `neuro_shim`
- `The-Neuroling-Collection`

The original Shimeji-ee JARs are not reliable on current Linux/Java runtimes.
These launchers use [ShimeLinux](https://github.com/BujjuIsABee/shimelinux) and
keep each project's imported data in a separate profile.

### Requirements and launch

- Java 21 or newer
- ShimeLinux 1.4.3 or newer
- An X11 desktop session

Install ShimeLinux. Set `SHIMELINUX_JAR` if its JAR is not installed at
`/usr/share/java/shimelinux.jar`, then run one of:

```sh
./evil_neuro_shim/run-linux.sh
./neuro_shim/run-linux.sh
./The-Neuroling-Collection/run-linux.sh
```

The launchers copy assets into isolated profiles under
`${XDG_DATA_HOME:-~/.local/share}/desktop-pets/shimelinux/` without modifying
the project files.

### NeurolingsCE-Qt import

Three ready-to-import archives are in `linux-mascot-imports/`. Drag an archive
onto the NeurolingsCE-Qt manager window or use **File > Import**. Regenerate
them after changing assets with:

```sh
python3 prepare-linux-mascot-imports.py
```

See [LINUX.md](LINUX.md) for compatibility details and verification notes.

### Sources and licensing

Original project readmes and licenses are retained in their respective
directories. The Collection snapshot is from
[neurofumo/The-Neuroling-Collection](https://github.com/neurofumo/The-Neuroling-Collection),
revision `f6a973f321c578904adab2def2fde2fb72ab55c7`. The user's local settings
changes and runtime logs are not included.
