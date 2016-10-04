#_6 Rendering Quality and Antialiasing_
<a name="Chapter06"></a>
<a name="Rendering Quality and Antialiasing"></a>
Rendering quality settings are available to control implementation-specific trade-offs between quality and performance. For example, an application might wish to use the highest quality setting for still images, and the fastest setting during UI operations or animation. The implementation must satisfy conformance requirements regardless of the quality setting.

A non-antialiased mode is provided for single-sampled drawing surfaces in which pixel coverage is always assigned to be 0 or 1, based on the inclusion of the pixel center in the geometry being rendered. When antialiasing is disabled, a coverage value of 1 will be assigned to each pixel whose center lies within the estimated path geometry, and a coverage value of 0 will be assigned otherwise. A consistent tie-breaking rule must be used for paths that pass through pixel centers.

For purposes of estimating whether a pixel center is included within a path, implementations may make use of approximations to the exact path geometry, providing that the following constraints are met. Conceptually, draw a disc D around each pixel center with a radius of just under 1⁄2 a pixel (in topological terms, an open disc of radius 1⁄2) and consider its intersection with the exact path geometry:

1. If D is entirely inside the path, the coverage at the pixel center must be estimated as 1;
2. If D is entirely outside the path, the coverage at the pixel center must be estimated as 0;
3. If D lies partially inside and partially outside the path, the coverage may be estimated as either 0 or 1 subject to the additional constraints that:
    a. The estimation is deterministic and invariant with respect to state variables apart from the current user-to-surface transformation, path coordinate geometry, and clipping due to different drawing surface dimensions; and
    b. For two disjoint paths that share a common segment, if D is partially covered by each path and completely covered by the union of the paths, the coverage must be estimated as 1 for exactly one of the paths. A segment is considered common to two paths if and only if both paths have the same path format, path datatype, scale, and bias, and the segments have bit-for-bit identical segment types and coordinate values, possibly in flipped order. If the segment is specified using relative coordinates, any preceding segments that may influence the segment must also have identical segment types and coordinate values.

Non-antialiased rendering may be useful for previewing results or for techniques such as picking (selecting the geometric primitive that appears at a given screen location) that require a single geometric entity to be associated with each pixel after rendering has completed.

Applications may indicate the sub-pixel color layout of the display in order to optimize rendering quality.

##6.1 Rendering Quality
<a name="Rendering Quality"></a>
The overall rendering quality may be set to one of three settings: non-antialiased, faster, or better. These settings do not affect rendering to multisampled surfaces; for such surfaces, each sample is evaluated independently and antialiasing occurs automatically as part of the process of resolving multiple samples into pixels.

###_VGRenderingQuality_

The `VGRenderingQuality` enumeration defines the values for setting the rendering quality:

```
typedef enum {
  VG_RENDERING_QUALITY_NONANTIALIASED = 0x1200,
  VG_RENDERING_QUALITY_FASTER         = 0x1201,
  VG_RENDERING_QUALITY_BETTER         = 0x1202  /* Default */
} VGRenderingQuality;
```
The `VG_RENDERING_QUALITY_NONANTIALIASED` setting disables antialiasing when used with a single-sampled drawing surface.

The `VG_RENDERING_QUALITY_FASTER` setting causes rendering to be done at the highest available speed, while still satisfying all API conformance criteria. The `VG_RENDERING_QUALITY_BETTER` setting, which is the default, causes rendering to be done with the highest available quality.

The **vgSet** function is used to control the quality setting to one of `VG_RENDERING_QUALITY_NONANTIALIASED`,`VG_RENDERING_QUALITY_FASTER`, or `VG_RENDERING_QUALITY_BETTER:`

```
vgSeti(VG_RENDERING_QUALITY, VG_RENDERING_QUALITY_NONANTIALIASED);
vgSeti(VG_RENDERING_QUALITY, VG_RENDERING_QUALITY_FASTER);
vgSeti(VG_RENDERING_QUALITY, VG_RENDERING_QUALITY_BETTER);

```
##_6.2 Additional Quality Settings_
<a name="Additional Quality Settings"></a>
###VGPixelLayout

The `VGPixelLayout` enumeration describes a number of possible geometric layouts of the red, green, and blue emissive or reflective elements within a pixel. This information may be used as a hint to the rendering engine to improve rendering quality. The supported pixel layouts are illustrated in Figure 2.

```
typedef enum {
  VG_PIXEL_LAYOUT_UNKNOWN
  VG_PIXEL_LAYOUT_RGB_VERTICAL
  VG_PIXEL_LAYOUT_BGR_VERTICAL
  VG_PIXEL_LAYOUT_RGB_HORIZONTAL = 0x1303,
  VG_PIXEL_LAYOUT_BGR_HORIZONTAL = 0x1304
} VGPixelLayout;
```

The pixel layout of the display device associated with the current drawing surface may be queried using **vgGeti** with a paramType value of `VG_SCREEN_LAYOUT`. The value `VG_PIXEL_LAYOUT_UNKNOWN`may indicate that the color elements of a pixel are geometrically coincident, or that no layout information is available to the implementation.

To provide the renderer with a pixel layout hint, use **vgSeti** with a `paramType` value of `VG_PIXEL_LAYOUT` and a value from the `VGPixelLayout` enumeration. The value `VG_PIXEL_LAYOUT_UNKNOWN` disables any optimizations based on pixel layout, treating the color elements of a pixel as geometrically coincident. Reading back the value of `VG_PIXEL_LAYOUT` with **vgGet** simply returns the value set by the application or the default value and does not reflect the properties of the drawing surface.

![Figure 2](https://raw.githubusercontent.com/Ajou-Khronies/OpenVG_1.1_Spec/0b3d69e55090b1dd337328b0c97e582cfa750746/figures/Figure_2.png)
*_Figure 2: `VGPixelLayout` Values_*

##_6.3 Coordinate Systems and Transformations_
<a name="Coordinate Systems and Transformations"></a>

Geometry is defined in a two-dimensional coordinate system that may or may not correspond to pixel coordinates. Drawing may be performed independently of the details of screen size, resolution, and drawing area by establishing suitable transformations between coordinate systems.


##_6.4 Coordinate Systems_
<a name="Coordinate Systems"></a>
Geometric coordinates are specified in the user coordinate system. The path-user-to- surface and image-user-to-surface transformations map between the user coordinate system and pixel coordinates on the destination drawing surface. This pixel-based coordinate system is known as the surface coordinate system. The relationship between the user and surface coordinate systems and the transformations that map between them is shown in Figure 3 below.

The user coordinate system is oriented such that values along the X axis increase from left to right and values along the Y axis increase from bottom to top, as in OpenGL. When the user-to-surface transformation is the identity transformation, a change of 1 unit along the X axis corresponds to moving by one pixel.

In the surface coordinate system, pixel (0, 0) is located at the lower-left corner of the drawing surface. The pixel (x, y) has its center at the point (x + 1⁄2, y + 1⁄2). Antialiasing filters used to evaluate the color or coverage of a pixel are centered at the pixel center. If antialiasing is disabled, the evaluation of each pixel occurs at its center.

##_6.5 Transformations_
<a name="Transformations"></a>
Geometry is defined in the user coordinate system, and is ultimately transformed into surface coordinates and assigned colors by means of a set of user-specified transformations that apply to geometric path data and to paint.

###_6.5.1 Homogeneous Coordinates_
<a name="Homogeneous Coordinates"></a>
Homogeneous coordinates are used in order to allow translation factors to be included in the affine matrix formulation, as well as to allow perspective effects for images. In homogeneous coordinates, a two-dimensional point (x, y) is represented by the three- dimensional column vector [x, y, 1]T. The same point may be equivalently represented by the vector [s*x, s*y, s]T for any non-zero scale factor s. More detailed explanations of the use of homogeneous coordinates may be found in most standard computer graphics textbooks, for example [FvDFH95].

![Figure 3](https://raw.githubusercontent.com/Ajou-Khronies/OpenVG_1.1_Spec/0b3d69e55090b1dd337328b0c97e582cfa750746/figures/Figure_3.png)
_Figure 3: Coordinates, Transformation, Clipping, and Scissoring_

###_6.5.2 Affine Transformations_
<a name="Affine Transformations"></a>
Geometric objects to be drawn are transformed from user coordinates to surface coordinates as they are drawn by means of a 3x3 affine transformation matrix with the following entries:

$\begin{bmatrix} sh & shx & tx \\
 shy & sy & ty \\ 0 & 0 & 1 \end{bmatrix}$

The entries may be divided by their function:

 * $sx$ and $sy$ define scaling in the $x$ and $y$ directions, respectively;
 * $shx$ and $shy$ define shearing in the $x$ and $y$ directions, respectively;
 * $tx$ and $ty$ define translation in the $x$ and $y$ directions, respectively.

An affine transformation maps a point (x, y) (represented using homogeneous coordinates as the column vector $[x, y, 1]^T$)  into the point  $(x*sx + y*shx + tx, x*shy + y*sy + ty)$ using matrix multiplication:

 $\begin{bmatrix} sh & shx & tx \\
  shy & sy & ty \\ 0 & 0 & 1 \end{bmatrix} \begin{bmatrix} x \\ y \\ z \end{bmatrix}\ = \begin{bmatrix} x*sx & + y*shx & + tx \\ x*shy & + y*sy & + ty \\ &1 \end{bmatrix}$

Affine transformations allow any combination of scaling, rotation, shearing, and translation. The concatenation of two affine transformations is an affine transformation, whose matrix form is the product of the matrices of the original transformations.

Gradients and patterns are subject to an additional affine transformation mapping the coordinate system used to specify the gradient parameters into user coordinates. The path-user-to-surface transformation is then applied to yield surface coordinates.

OpenVG does not provide the notion of a hierarchy of transformations; applications must maintain their own matrix stacks if desired.

###_6.5.3 Projective (Perspective) Transformations_
<a name="Projective (Perspective) Transformations"></a>
The **vgDrawImage** function uses a 3x3 projective (or perspective) transformation matrix (representing the image-user-to-surface transformation) with the following entries to transform from user coordinates to surface coordinates:

_ Rendering Quality and Antialiasing_

$\begin{bmatrix} sh & shx & tx \\
 shy & sy & ty \\ w_0 & w_1 & w_2 \end{bmatrix}$

A projective transformation maps a point (x, y) into the point:

$\left( \frac { x*sx+y*shx+tx }{ x*w_ 0+y*w_ 1+w_ 2 } ,\frac { x*shy+y*sy+ty }{ x*w_ 0+y*w_ 1+ w_ 2 }  \right)$

using matrix multiplication and division by the third homogeneous coordinate:

$\begin{bmatrix} sx & shx & tx \\ shy & sy & ty \\ w_{ 0 } & w_{ 1 } & w_{ 2 } \end{bmatrix}\begin{bmatrix} x \\ y \\ z \end{bmatrix}=\begin{bmatrix} x*sx+y*shx+tx \\ x*shy+y*sy+ty \\ x*w_{ 0 }+y*w_{ 1 }+w_{ 2 } \end{bmatrix}=\begin{bmatrix} \frac { x*sx+y*shx+tx }{ x*w\_ 0+y*w\_ 1+w\_ 2 }  \\ \frac {w*shy+y*sy+ty  }{ x*w_1+y*w_1+w_2 } \\ 1\end{bmatrix}$
The concatenation of two projective transformations is a projective transformation, whose matrix form is the product of the matrices of the original transformations.

Both affine and projective transformations map straight lines to straight lines. However, affine transformations map evenly spaced points along a source line to evenly spaced points in the destination, whereas projective transformations allow the distance between points to vary due to the effect of division by the denominator $d = (x*w_0 + y*w_1 + w_2)$.
Although OpenVG does not provide support for three-dimensional coordinates, proper setting of the w matrix entries can simulate the effect of placement of images in three dimensions, as well as other warping effects.

##_6.6 Matrix Manipulation_
<a name="Matrix Manipulation"></a>
Transformation matrices are manipulated using the **vgLoadIdentity**, **vgLoadMatrix**, and **vgMultMatrix** functions. For convenience, the **vgTranslate**, **vgScale**, **vgShear**, and **vgRotate** functions may be used to concatenate common types of transformations.

The matrix conventions used by OpenVG are similar to those of OpenGL. A point to be transformed is given by a homogeneous column vector $[x, y, 1^]T$. Transformation of a point p by a matrix M is defined as the product M∙p. Concatenation of transformations is performed using right-multiplication of matrices.

In the following sections, the matrix being updated by each call will be represented by the symbol M.

####_VGMatrixMode_
<a name="VGMatrixMode"></a>
The current matrix to be manipulated is specified by setting the matrix mode. Separate matrices are maintained for transforming paths, images, and paint (gradients and patterns). The matrix modes are defined in the `VGMatrixMode` enumeration:

```
typedef enum {
  VG_MATRIX_PATH_USER_TO_SURFACE  = 0x1400,
  VG_MATRIX_IMAGE_USER_TO_SURFACE = 0x1401,
  VG_MATRIX_FILL_PAINT_TO_USER    = 0x1402,
  VG_MATRIX_STROKE_PAINT_TO_USER  = 0x1403,
  VG_MATRIX_GLYPH_USER_TO_SURFACE = 0x1404
} VGMatrixMode;
```


To set the matrix mode, call **vgSeti*8 with a type of `VG_MATRIX_MODE` and a value of `VG_MATRIX_*`. For example, to set the matrix mode to allow manipulation of the path- user-to-surface transformation, call:

```
vgSeti(VG_MATRIX_MODE, VG_MATRIX_PATH_USER_TO_SURFACE);
```

####_vgLoadIdentity_
<a name="vgLoadIdentity"></a>
The **vgLoadIdentity** function sets the current matrix M to the identity matrix:

$M =\begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}$

```
void vgLoadIdentity(void)
```

####_vgLoadMatrix_
<a name="vgLoadMatrix"></a>
The vgLoadMatrix function loads an arbitrary set of matrix values into the current matrix. Nine matrix values are read from m, in the order:

$\left\{ sx, shy, w_0, shx, sy, w_1, tx, ty, w_2  \right\}$

defining the matrix:

$M=\begin{bmatrix} sx & shx & tx \\ shy & sy & ty \\ w_{ 0 } & w_{ 1 } & w_{ 2 } \end{bmatrix}$

However, if the targeted matrix is affine (_i.e.,_ the matrix mode is not `VG_MATRIX_IMAGE_USER_TO_SURFACE`), the values _{$w_0, w_1, w_2$}_ are ignored and replaced by the values _{ $0, 0, 1$ }_, resulting in the affine matrix:

$\begin{bmatrix} sx & shx & tx \\ shy & sy & ty \\ 0 & 0 &1 \end{bmatrix}$

```
void vgLoadMatrix(const VGfloat * m)
```

>**ERRORS**
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>* if `m` is `NULL`
>* if `m` is not properly aligned

####_vgGetMatrix_
<a name="vgGetMatrix"></a>
It is possible to retrieve the value of the current transformation by calling **vgGetMatrix**. Nine values are written to m in the order:

_{ $sx, shy, w_0, shx, sy, w_1, tx, ty, w_2$ }_

For an affine matrix, w0 and w1 will always be $0$ and $w_2$ will always be 1.

```
void vgGetMatrix(VGfloat * m)
```

>**ERRORS**
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>* if `m` is `NULL`
>* ***if m is not properly aligned***

####_vgMultMatrix_
<a name="vgMultMatrix"></a>
The **vgMultMatrix** function right-multiplies the current matrix **M** by a given matrix:

$M\leftarrow M=\begin{bmatrix} sx & shx & tx \\ shy & sy & ty \\ w_{ 0 } & w_{ 1 } & w_{ 2 } \end{bmatrix}$

Nine matrix values are read from m in the order:

_{ $sx, shy, w0, shx, sy, w1, tx, ty, w2$ }_

and the current matrix is multiplied by the resulting matrix. However, if the targeted matrix is affine (_i.e.,_ the matrix mode is not `VG_MATRIX_IMAGE_USER_TO_SURFACE`), the values _{ $w_0, w_1, w_2$ }_ are ignored and replaced by the values _{ $0, 0, 1$ }_ prior to multiplication.

```
void vgMultMatrix(const VGfloat * m)
```

>**ERRORS**
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>* if `m` is `NULL`
>* **`if m is not properly aligned`**

####_vgTranslate_
<a name="vgTranslate"></a>
The **vgTranslate** function modifies the current transformation by appending a translation. This is equivalent to right-multiplying the current matrix **M** by a translation matrix:

$M\leftarrow M = \begin{bmatrix} 1 & 0 & tx \\ 0 & 1 & ty \\ 0 & 0 & 1 \end{bmatrix}$

```
void vgTranslate(VGfloat tx, VGfloat ty)
```

####_vgScale_
<a name="vgScale"></a>
The **vgScale** function modifies the current transformation by appending a scale. This is equivalent to right-multiplying the current matrix $M$ by a scale matrix:

$M\leftarrow M = \begin{bmatrix} sx & 0 & 0 \\ 0 & sy & 0 \\ 0 & 0 & 1 \end{bmatrix}$

```
void vgScale(VGfloat sx, VGfloat sy)
```

####_vgShear_
<a name="vgShear"></a>
The **vgShear** function modifies the current transformation by appending a shear. This is equivalent to right-multiplying the current matrix $M$ by a shear matrix:

$M\leftarrow M = \begin{bmatrix} 1 & shx & 0 \\ shy & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}$

```
void vgShear(VGfloat shx, VGfloat shy)
```

####_vgRotate_
<a name="vgRotate"></a>
The **vgRotate** function modifies the current transformation by appending a counter- clockwise rotation by a given angle (expressed in degrees) about the origin. This is equivalent to right-multiplying the current matrix $M$ by the following matrix (using the symbol a to represent the value of the `angle` parameter):

$M\leftarrow M = \begin{bmatrix} cos(a) & -sin(a) & 0 \\ sin(a) & cos(a) & 0 \\ 0 & 0 & 1 \end{bmatrix}$


To rotate about a center point (cx, cy) other than the origin, the application may perform a translation by $(cx, cy)$, followed by the rotation, followed by a translation by $(-cx, -cy)$.

```
void vgRotate(VGfloat angle)
```
