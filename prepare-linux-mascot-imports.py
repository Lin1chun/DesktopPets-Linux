#!/usr/bin/env python3
"""Package the supplied Shimeji assets for import into NeurolingsCE-Qt."""

from pathlib import Path
import zipfile


ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "linux-mascot-imports"
PROJECTS = (
    ("evil-neuro-shim", ROOT / "evil_neuro_shim"),
    ("neuro-shim", ROOT / "neuro_shim"),
    ("the-neuroling-collection", ROOT / "The-Neuroling-Collection"),
)
IMAGE_SET_NAMES = {
    "evil-neuro-shim": "Evil-Neuro-Shimeji",
    "neuro-shim": "Neuro-Shimeji",
}
OMIT_NAMES = {
    "settings.properties",
    "theme.properties",
    "logging.properties",
}
OMIT_SUFFIXES = {".bak", ".log", ".lck"}


def included(path: Path, project: Path) -> bool:
    relative = path.relative_to(project)
    if not path.is_file() or any(part in {"unused", ".git"} for part in relative.parts):
        return False
    if path.name in OMIT_NAMES or path.suffix.lower() in OMIT_SUFFIXES:
        return False
    return relative.parts[0] in {"conf", "img"}


def main() -> None:
    OUTPUT.mkdir(exist_ok=True)
    for package_name, project in PROJECTS:
        if not (project / "conf").is_dir() or not (project / "img").is_dir():
            raise SystemExit(f"Missing Shimeji conf/img directories: {project}")

        archive_path = OUTPUT / f"{package_name}.zip"
        files = sorted(path for path in project.rglob("*") if included(path, project))
        if not files:
            raise SystemExit(f"No mascot assets found in {project}")

        with zipfile.ZipFile(
            archive_path, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=6
        ) as archive:
            for path in files:
                member_path = path.relative_to(project)
                replacement = IMAGE_SET_NAMES.get(package_name)
                if replacement and member_path.parts[:2] == ("img", "Shimeji"):
                    member_path = Path("img", replacement, *member_path.parts[2:])
                archive.write(path, member_path.as_posix())

        with zipfile.ZipFile(archive_path) as archive:
            bad_member = archive.testzip()
            if bad_member:
                raise SystemExit(f"Invalid archive member in {archive_path}: {bad_member}")
        print(f"{archive_path.relative_to(ROOT)}: {len(files)} files, {archive_path.stat().st_size} bytes")


if __name__ == "__main__":
    main()
