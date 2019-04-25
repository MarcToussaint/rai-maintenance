## Setting up qtcreator

### Installing newest version

You can install via
```
sudo apt-get install qtcreator
```
But sometimes the Ubuntu version is less stable. I downloaded the newest version (which requires registration with Qt):
```
mkdir -p ~/opt
cd ~/opt
wget https://download.qt.io/official_releases/qtcreator/4.6/4.6.1/qt-creator-opensource-linux-x86_64-4.6.1.run
chmod a+x ./qt-creator-opensource-linux-x86_64-4.6.1.run
./qt-creator-opensource-linux-x86_64-4.6.1.run
```
I chose `~/opt/qtcreator-4.6.1` as installation path, added a symbolic link
```
mkdir -p ~/opt/bin
cd ~/opt/bin
ln -s ~/opt/qtcreator-4.6.1/bin/qtcreator.sh
```
and `export PATH="$HOME/opt/bin:$PATH"` in my `.bashrc`

### New project

First, setup the sessions are remembered:
```
File -> Sessions -> Session Manager
```
and mark `Restore last session on startup`.

Open any `rai` path with a `Makefile` using
```
New (Ctrl-N) -> Import Project -> Import Existing Project
```
choose the path and "project name".

### Source Parsing & Browsing

In the "project name".includes, add the `rai/rai` (with relative `../` as needed) path to parse sources. Perhaps also add `/opt/ros/kinetic/include` and alike.

### Debugging helpers

To enable the `rai` specific debugging helpers: In
```
  Tools -> Options -> Debugger -> Locals & Expressions
```
add `$HOME/git/rai/build/qtcreator_debuggingHelpers.py` (In old versions, create a symbolic link `~/.gdbinit` to this file.)

In `Tools -> Options -> Debugger -> GDB` disable `Load system GDB pretty printers`

When debugging programs with own SIGINT handlers, sometines you need to ignore SIGINT. Open the `Debugger Log` window and write
```
  handle SIGINT pass
  handle SIGINT noprint
  handle SIGINT nostop
  handle SIGINT ignore
```

### Code formatting

To use the same formatting as `rai`:
```
  Tools -> Options > C++ > Import...
```
and choose the `rai-maintenance/help/qt_coding_style.xml`





