# Generating a C++ API documentation using Doxygen

Warning: The in code documentation is not well maintained in rai at
all. When coding we typically code-browse into headers and read
comments there directly. But at least for the older parts of the code,
the doxygen comments might still be useful.

* To generate the API, first install doxygen
```
sudo apt install doxygen doxygen-gui
```
* Call the wizard `doxywizard &`
* Select `rai/rai` as working directory (e.g. `$HOME/git/robotics-course/rai/rai`)
* In the Wizard tab, section Project, set `Project Name` to `rai` and mark `Scan recursively`
* In the Wizard tab, section Mode, mark `All Entities`
* In the Wizard tab, section Output, un-mark `LaTeX`
* In the Wizard tab, section Diagrams, mark `No diagrams`
* In the Run tab, `Run Doxygen` and `Show HTML output`
* I recomment looking at Namespaces->rai as the starting page for browing the API


