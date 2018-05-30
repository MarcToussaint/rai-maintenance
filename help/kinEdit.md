# Notes on scene and robot model files

## Import

There is ways to import from URDF or similar XML type
descriptions. There are also some working examples to import
`gltf`. With Bremen we also managed to import a [full
kitchen](https://github.com/MarcToussaint/rai-robotModels/tree/master/bremenKitchen)
from unreal. More info on demand.

## Continuous editing using `kinEdit`

Compile the binary
```
cd rai  # into the rai submodule
make bin
```
perhaps export
```
echo 'export PATH="$HOME/path-to-rai/bin:$PATH"' >> $HOME/.bashrc
```

Then you can call `kinEdit someFile.g` from anywhere on any model
file. This displays and animates the model. While displaying the
model, edit the file in any other editor and save. `kinEdit` then
notices that the file changed and reloads and directly displays your
changes -- or writes parsing errors to the console. You might
sometimes have to hit enter in the window or restart `kinEdit` on such
errors. I tell my windows manager to keep the `kinEdit` window "always
on top".

Whenever `kinEdit` reads a file, it also outputs a file `z.g` of what
it read. Sometimes it is useful to look into this.

## Editing robot model/configuration files

Example: This is a description of a little arm on a table with ball and hook ([model.g](https://github.com/MarcToussaint/rai/blob/master/test/KOMO/switches/model.g))
```
frame table1{ shape:ST_ssBox, X:<t(.8 0 .7)>, size:[2. 3. .2 .02], color:[.3 .3 .3] fixed, contact, logical:{ table } }

### arm

frame stem(table1) {
    joint:JT_rigid Q:<t(0 0 .2)>
    shape:ST_ssBox mass:.5 size:[0.1 0.1 .2 .03] }
frame arm1(stem) {
    joint:JT_quatBall A:<t(0 0 .1)>  B:<d(90 1 0 0) t(0 0 .25) > Q:<d(-60 1 0 0)>
    shape:ST_ssBox mass:1 size:[0.1 0.1 .5 .03] }
frame arm2(arm1) {
    joint:JT_hingeX  A:<t(0 0 .25)> B:<t(0 0 .25) > q:1.
    shape:ST_ssBox mass:1 size:[0.1 0.1 .5 .03] }
frame arm3(arm2) {
    joint:JT_hingeX A:<t(0 0 .25)>  B:<t(0 0 .15) > q:1.
    shape:ST_ssBox mass:1 size:[0.1 0.1 .3 .03] }

frame endeff(arm3) {
    shape:ST_ssBox Q:<t(0 0 .2)> size:[.05 .05 .1 .02] color:[1. 1. 0] }

### ball

frame redBall(table1) { Q:<t(0 0 .1) t(.1 .7 .03)> size:[.06 .06 .06 .02] color:[1 0 0] shape:ST_ssBox contact, logical:{ object } }

### hook

frame stick (table1){
  shape:ST_ssBox size:[.8 .025 .04 .01] color:[.6 .3 0] contact, logical:{ object }
  Q:<t(0 0 .1) t(.5 -.7 .02) d(90 0 0 1)>
}
frame stickTip (stick) { Q:<t(.4 .1 0) d(90 0 0 1)> type:ST_ssBox size:[.2 .026 .04 0.01] color:[.6 .3 0], logical:{ object, pusher } }
```

See [graph.md](graph.md) for a general description of the `.g` file syntax.

See [rai::Frame](https://github.com/MarcToussaint/rai/blob/master/rai/Kin/frame.h) for the definition of the underlying data structure.

Kinematic configurations are frame trees.

The declaration `stem(table1)` declares a new frame
with name `stem` and parent `table1`. The dictionary `{...}`
defines parameters of this frame and what is associated to the frame.

Internally, every frame has an absolute world pose `X`, and, if it is a child of
a parent, a relative transformation `Q` from parent to this
frame. Forward kinematics means nothing but forward chaining `Q`s to
compute `X`s for all frames.

We can associate to a frame any (or none) of the following:
* A `shape`, which requires either a `mesh` filename given, or a primitive shape type with given `size`
* A `joint`, which means that `Q` is a differentiable function of some DOFs, rather than fixed.
* A `mass`, which means that the frame can act as a dynamic body in a physical simulation

Let's read in detail
```
frame stick (table1){
  shape:ST_ssBox size:[.8 .025 .04 .01] color:[.6 .3 0] contact, logical:{ object }
  Q:<t(0 0 .1) t(.5 -.7 .02) d(90 0 0 1)>
}
```
This defines a new frame `stick` with parent frame `table1`. This
frame has a shape, namely a sphere-swept box (`ST_ssBox`) of dimension
(.8, .025, .04) meters, radius 1cm (radius of the sphere-sweeping) and
color (.6,.3,.0).
See [geoms.h](https://github.com/MarcToussaint/rai/blob/master/rai/Geo/geoms.h) for the list of possible shape types `ST_...`
 It also has other attributes (`contact`, and
`logical`) that don't relate to the kinematic description itself.

The `stick` is positioned relative to `table1` as given by the transformation `Q`. The transformation is given as a chaining of little interpretable transformations, as in the old turtle language. Namely,
* `t(x y z)`  translation by (x,y,z)
* `q(q0 q1 q2 q3)`  rotation by a quaternion
* `r(r x y z)` rotation by `r` _radians_ around the axis (x,y,z)
* `d(d x y z)` rotation by `d` _degrees_ around the axis (x,y,z)
* `E(r p y)` rotation by roll-pitch-yaw Euler angles

Alternativly, `Q:<p1 p2 p3 q0 q1 q2 q3>` would directly specify a 7d transformation.

Any `joint:JT_...` attribute causes a joint to be associated to this frame.  See
[frame.h](https://github.com/MarcToussaint/rai/blob/master/rai/Kin/frame.h)
for the list of possible joint types `JT_...`. The joint's DOFs can be
initialized equivalently either with a `q` attribute (defining the
DOFs), or a `Q` attribute (defining the resulting relative
transformation generated by the joint).

However, often one wants the joint to be
located somewhere else, not directly in the frame's origin. E.g., the
frame `arm2` is centered with the second box that defines the arm. The
joint associated with that link is a bit lower in the chain. The `A`
and `B` tags allow you to split the transformation from `arm1` to
`arm2` into: `arm1`frame -> `A`transform -> `Q`transform of
joint-frame -> `B`transform -> `arm2`frame. Internally this
creates new intermediate frames, so that the data structure is
strictly a simple frame tree.

