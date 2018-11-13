# Features and Objectives for KOMO

## Features

We assume a single configuration $x$, or a whole set of configurations
$\{x_1,..,x_T\}$. Each $x_i \in\mathbb{R}$ are the DOFs of that
configuration.

A feature $\phi$ is a differentiable mapping
$$\phi: x \mapsto \mathbb{R}^D$$
of a single configuration into some $D$-dimensional space, or a mapping
$$\phi: (x_0,x_2,..,x_k) \mapsto \mathbb{R}^D$$
of a $(k+1)$-tuple of configurations to a $D$-dimensional space.

The rai code implements many features, most of them are accessible via
a feature symbol (FS). The are declared in

rai/rai/Kin/featureSymbols.h

Here is a table of feature symbols, with the
respective dimensionality $D$, the default order $k$, and a
description

| FS | frames | $D$ | $k$ | description |
|:---:|:---:|:---:|:---:|:---:|
| position | {o1} | 3 || 3D position of o1 in world coordinates |
| positionDiff | {o1,o2} | 3 || difference of 3D positions of o1 and o2 in world coordinates |
| positionRel | {o1,o2} | 3 || 3D position of o1 in o2 coordinates |
| quaternion | {o1} | 4 || 4D quaternion of o1 in world coordinates\footnote{There is ways to handle the invariance w.r.t.\ quaternion sign properly.} |
| quaternionDiff | {o1,o2} | 4 || ... |
| quaternionRel | {o1,o2} | 4 || ... |
| pose | {o1} | 7 || 7D pose of o1 in world coordinates |
| poseDiff | {o1,o2} | 7 || ... |
| poseRel | {o1,o2} | 7 || ... |
| vectorX | {o1} | 3 || The x-axis of frame o1 rotated back to world coordinates |
| vectorXDiff | {o1,o2} | 3 || The difference of the above for two frames o1 and o2 |
| vectorXRel | {o1,o2} | 3 || The x-axis of frame o1 rotated as to be seend from the frame o2 |
| vectorY... | | | | same as above |
| scalarProductXX | {o1,o2} | 1 || The scalar product of the x-axis fo frame o1 with the x-axis of frame o2 |
| scalarProduct... | {o1,o2} | | | as above |
| gazeAt | {o1,o2} | 2 | | The 2D projection of the origin of frame o2 onto the xy-plane of frame o1 |
| angularVel | {o1} | 3 | 1 | The angular velocity of frame o1 across two configurations |
| accumulatedCollisions | {} | 1 | | The sum of collision penetrations; when negative/zero, nothing is colliding |
| jointLimits | {} | 1 | | The sum of joint limit penetrations; when negative/zero, all joint limits are ok |
| distance | {o1,o1} | 1 | | The NEGATIVE distance between convex meshes o1 and o2, positive for penetration |
| qItself | {} | $n$ | | The configuration joint vector |
| aboveBox | {o1,o2} | 4 | | when all negative, o1 is above (inside support of) the box o2 |
| insideBox | {o1,o2} | 6 | | when all negative, o1 is inside the box o2 |
| standingAbove | | | | ? |

A features is typically defined by
* The feature symbol (`FS_...` in cpp; `FS....` in python)
* The set of frames it refers to
* Optionally: A target, which changes the zero-point of the features (optimization typically try to drive features to zero, see below)
* Optionally: A scaling, that can also be a matrix to down-project a feature
* Optionally: The order $k$, which can make the feature a velocity or acceleration feature

Target and scale redefine a feature to become
$$
  \phi(x) \gets \texttt{scale} \cdot (\phi(x) - \texttt{target})
$$
The target needs to be a $D$-dim vector. The scale can be a matrix, which projects features; e.g., and 3D position to just $x$-position.

The order of a feature is usually $k=0$, meaning that it is defined over a single configuration only. $k=1$ means that it is defined over two configurations (1st oder Markov), and redefines the feature to become the difference or velocity
$$
  \phi(x_1,x_2) \gets \frac{1}{\tau}(\phi(x_2) - \phi(x_1))
$$
$k=2$ means that it is defined over three configurations (2nd order Markov), and redefines the feature to become the acceleration
$$
  \phi(x_1,x_2,x_3) \equiv \frac{1}{\tau^2}(\phi(x_1) + \phi(x_3) - 2 \phi(x_2))
$$

### Examples

```
(FS.position, {'hand'})
```
is the 3D position of the hand in world coordinates

```
(FS.positionRel, {'handL', 'handR'}, scale=[[0,0,1]], target=[0.1])
```
is the z-position position of the left hand measured in the frame of the right hand, with target 10centimeters.

```
(FS.position, {'handL'}, order=1)
```
is the 3D velocity of the left hand in world coordinates

```
(FS.scalarProductXX, {'handL', 'handR'}, target=[1])
```
says that the scalar product of the x-axes (e.g. directions of the index finger) of both hands should equal 1, which means they are aligned.

```
(FS.scalarProductXY, {'handL', 'handR'})
(FS.scalarProductXZ, {'handL', 'handR'})
```
says that the the x-axis of handL should be orthogonal (zero scalar product) to the y- and z-axis of handR. So this also describes aligning both z-axes. However, this formulation is much more robust, as it has good error gradients around the optimum.


## Objectives

Features are meant to define objectives in an optimization problem. An objective is
* a feature
* an indicator $\rho_k
\in\{\texttt{ineq, eq, sos}\}$ that states whether the features
implies an inequality, an equality, or a sum-of-square objective
* and an index tuple $\pi_k \subseteq \{1,..,n\}$ that states which
configurations this feature is defined over.

Then, given a set
$\{\phi_1,..,\phi_K\}$ of $K$ features, and a set $\{x_1,..,x_n\}$ of
$n$ configurations, this defines the mathematical program

$$
  \min_{x_1,..,x_n} \sum_{k : \rho_k=\texttt{sos}} \phi_k(x_{\pi_k})^T \phi_k(x_{\pi_k})
  ~\text{s.t.}~ \mathop\forall_{k : \rho_k=\texttt{ineq}} \phi_k(x_{\pi_k}) \le 0 ~,\quad
  \mathop\forall_{k : \rho_k=\texttt{eq}} \phi_k(x_{\pi_k}) = 0 ~,\quad
$$
