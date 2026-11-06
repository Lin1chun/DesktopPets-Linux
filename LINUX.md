# Linux 兼容性 / Linux compatibility

## 中文

三个桌宠项目使用 Shimeji-ee XML 动作定义和 PNG 动画帧。原版 Java 启动器不能在当前 Linux 环境下可靠运行：

- 两个 Shimeji-ee JAR 在通用 Linux 后端触发 `GenericEnvironment.tick()` 空指针异常。
- Neuroling Collection JAR 依赖 Java 21 中已移除的 Nashorn 类，启动失败。

项目启动脚本改为使用开源 Linux 移植版
[ShimeLinux](https://github.com/BujjuIsABee/shimelinux)。安装 ShimeLinux 和 Java 21 或更新版本后运行：

```sh
./evil_neuro_shim/run-linux.sh
./neuro_shim/run-linux.sh
./The-Neuroling-Collection/run-linux.sh
```

启动器把项目的 `conf/` 与 `img/` 复制到独立配置目录
`${XDG_DATA_HOME:-~/.local/share}/desktop-pets/shimelinux/`，不会改动项目文件或已有 ShimeLinux 配置。
设置 `SHIMELINUX_JAR` 可指定 ShimeLinux JAR 路径；设置 `JAVA` 可指定 Java 可执行文件。

也可以使用提供 Linux AppImage 并支持导入 Shimeji-ee 资源包的
[NeurolingsCE-Qt](https://github.com/qingchenyouforcc/NeurolingsCE-Qt)。
`linux-mascot-imports/` 中已准备三个导入包。资源变更后运行以下命令重建：

```sh
python3 prepare-linux-mascot-imports.py
```

导入包包含桌宠 XML/PNG 资源，不包含本机设置、日志、Windows 启动器或 Java 库。两个原本同名的
`Shimeji` 资源集使用不同名称；Collection 保留角色名以支持角色间变换。可将 ZIP 拖入
NeurolingsCE-Qt 管理窗口，或使用 **File > Import**。

验证方面，原版 JAR 的失败已在隔离副本中复现；三个 ShimeLinux 启动器均通过 8 秒 X11 启动冒烟测试，
未记录异常。短时测试不代表长期运行保证。NeurolingsCE-Qt 图形界面的导入流程尚未在本环境实测。

## English

The three mascot projects use Shimeji-ee XML actions and PNG animation frames.
Their bundled Java launchers are not reliable on current Linux runtimes:

- Both Shimeji-ee JARs fail in the generic Linux backend with a
  `GenericEnvironment.tick()` null-pointer exception.
- The Neuroling Collection JAR depends on Nashorn classes removed from Java 21.

The project launchers use the open-source Linux port
[ShimeLinux](https://github.com/BujjuIsABee/shimelinux). Install ShimeLinux and
Java 21 or newer, then run:

```sh
./evil_neuro_shim/run-linux.sh
./neuro_shim/run-linux.sh
./The-Neuroling-Collection/run-linux.sh
```

The launchers copy `conf/` and `img/` into isolated profiles under
`${XDG_DATA_HOME:-~/.local/share}/desktop-pets/shimelinux/`. They do not modify
project files or an existing ShimeLinux profile. Set `SHIMELINUX_JAR` to select
the ShimeLinux JAR location, or `JAVA` to select the Java executable.

Alternatively, [NeurolingsCE-Qt](https://github.com/qingchenyouforcc/NeurolingsCE-Qt)
publishes Linux AppImages and imports legacy Shimeji-ee archives. Three prepared
archives are in `linux-mascot-imports/`; regenerate them after asset changes with:

```sh
python3 prepare-linux-mascot-imports.py
```

The archives include mascot XML/PNG data and exclude local settings, logs,
Windows launchers, and Java libraries. The two otherwise identically named
`Shimeji` sets receive distinct names; Collection character names are preserved
for transform interactions. Drag an archive onto the NeurolingsCE-Qt manager
window or use **File > Import**.

The original JAR failures were reproduced in isolated copies. Each ShimeLinux
launcher passed an eight-second X11 startup smoke test without logged
exceptions; these short runs do not establish long-term behavior. The
NeurolingsCE-Qt GUI import has not been exercised in this workspace.
