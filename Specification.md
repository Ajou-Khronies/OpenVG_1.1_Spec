**written to** values.
```C
VGfloat vgGetf (VGParamType paramType)
VGint   vgGeti (VGParamType paramType)
VGint   vgGetVectorSize(VGParamType paramType)
void    vgGetfv(VGParamType paramType, VGint count, VGfloat * values)
void    vgGetiv(VGParamType paramType, VGint count, VGint * values)
```

>**ERRORS**
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if `paramType` is not a valid value from the `VGParamType` enumeration
>* if `paramType` refers to a vector parameter in **vgGetf** or **vgGeti**
>* if `values` is `NULL` in **vgGetfv** or **vgGetiv**
>* if `values` is not properly aligned in **vgGetfv** or **vgGetiv**
>* if `count` is less than or equal to 0 in **vgGetfv** or **vgGetiv**
>* if `count` is greater than the value returned by **vgGetVectorSize** for the given parameter in **vgGetfv** or **vgGetiv**

###_5.2.1 Default Context Parameter Values_
<a name=“Default Context Parameter Values_”></a>
When a new OpenVG context is created, it contains default values as shown in Table 4. Note that some tokens have been split across lines for reasons of space.

Parameter | Datatype | Default Value
----------|----------|--------------
`VG_MATRIX_MODE`|`VGMatrixMode`|`VG_MATRIX_PATH_USER_TO_SURFACE`
`VG_FILL_RULE`|`VGFillRule`|`VG_EVEN_ODD`
`VG_IMAGE_QUALITY`|`VGImageQuality`|`VG_IMAGE_QUALITY_FASTER`
`VG_RENDERING_QUALITY`|`VGRendering Quality`|`VG_RENDERING_QUALITY_BETTER`
`VG_BLEND_MODE`|`VGBlendMode`|`VG_BLEND_SRC_OVER`
`VG_IMAGE_MODE`|`VGImageMode`|`VG_DRAW_IMAGE_NORMAL`
`VG_SCISSOR_RECTS`|`VGint *`|{ } (array of length 0)
`VG_COLOR_TRANSFORM`|`VGboolean`|`VG_FALSE` (disabled)
`VG_COLOR_TRANSFORM_VALUES`|`VGfloat[8]`|{ 1.0f, 1.0f, 1.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f }
`VG_STROKE_LINE_WIDTH`|`VGfloat`|1.0f
`VG_STROKE_CAP_STYLE`|`VGCapStyle`|`VG_CAP_BUTT`
`VG_STROKE_JOIN_STYLE`|`VGJoinStyle`|`VG_JOIN_MITER`
`VG_STROKE_MITER_LIMIT`|`VGfloat`|4.0f
`VG_STROKE_DASH_PATTERN`|`VGfloat *`|{ } (array of length 0) (disabled)
`VG_STROKE_DASH_PHASE`|`VGfloat`|0.0f
`VG_STROKE_DASH_PHASE_ RESET`|`VGboolean`|`VG_FALSE` (disabled)
`VG_TILE_FILL_COLOR`|`VGfloat[4]``|{ 0.0f, 0.0f, 0.0f, 0.0f }
`VG_CLEAR_COLOR`|`VGfloat[4]`|{ 0.0f, 0.0f, 0.0f, 0.0f }
`VG_GLYPH_ORIGIN`|`VGfloat[2]`|{ 0.0f, 0.0f }
`VG_MASKING`|`VGboolean`|`VG_FALSE` (disabled)
`VG_SCISSORING`|`VGboolean`|`VG_FALSE` (disabled)
`VG_PIXEL_LAYOUT`|`VGPixelLayout`|`VG_PIXEL_LAYOUT_UNKNOWN`
`VG_SCREEN_LAYOUT`|`VGPixelLayout`|Layout of the drawing surface
`VG_FILTER_FORMAT_LINEAR`|`VGboolean`|`VG_FALSE` (disabled)
`VG_FILTER_FORMAT_PREMULTIPLIED`|`VGboolean`|`VG_FALSE` (disabled)
`VG_FILTER_CHANNEL_MASK`|`VGbitfield`|`(VG_RED \| VG_GREEN \| VG_BLUE \| VG_ALPHA)`
_Table 4: Default Parameter Values for a Context_

The read-only parameter values `VG_MAX_SCISSOR_RECTS,VG_MAX_DASH_COUNT, VG_MAX_KERNEL_SIZE, VG_MAX_SEPARABLE_KERNEL_SIZE, VG_MAX_GAUSSIAN_STD_DEVIATION, VG_MAX_COLOR_RAMP_STOPS, VG_MAX_IMAGE_WIDTH, VG_MAX_IMAGE_HEIGHT, VG_MAX_IMAGE_PIXELS, VG_MAX_IMAGE_BYTES,` and `VG_MAX_FLOAT` are initialized to implementation-defined values.

The `VG_SCREEN_LAYOUT` parameter is initialized to the current layout of the display device containing the current drawing surface, if applicable.

The matrices for matrix modes `VG_MATRIX_PATH_USER_TO_SURFACE, VG_MATRIX_IMAGE_USER_TO_SURFACE, VG_MATRIX_GLYPH_USER_TO_SURFACE, VG_MATRIX_FILL_PAINT_TO_USER,` and `VG_MATRIX_STROKE_PAINT_TO_USER` are initialized to the identity matrix (see Section 6.5):

$\begin{bmatrix} sh & shx & tx \\
 shy & sy & ty \\ w_0 & w_1 & w_2 \end{bmatrix} = \begin{bmatrix} 1 & 0 & 0 \\
 0 & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}$

 By default, no paint object is set for filling or stroking paint modes. The default paint parameter values are used instead, as described in Section 9.1.3.

 ##_5.3 Setting and Querying Object Parameter Values_
 Objects that are referenced using a `VGHandle` (_i.e.,_ `VGImage, VGPaint, VGPath, VGFont,` and `VGMaskLayer` objects) may have their parameters set and queried using a number of **vgSetParameter** and **vgGetParameter** functions. The semantics of these functions (including the handling of invalid count values) are similar to those of the **vgGet** and **vgSet** functions.

 ####_vgSetParameter_
 The **vgSetParameter** functions set the value of a parameter on a given `VGHandle-` based `object`.

 ```
void vgSetParameterf (VGHandle object, VGint paramType,
                    VGfloat value)
void vgSetParameteri (VGHandle object, VGint paramType,
                      VGint value)
void vgSetParameterfv(VGHandle object, VGint paramType,
                      VGint count, const VGfloat * values)
void vgSetParameteriv(VGHandle object, VGint paramType,
                      VGint count, const VGint * values)
 ```

>**ERRORS**
>
>`VG_BAD_HANDLE_ERROR`
>* if object is not a valid handle, or is not shared with the current context `VG_ILLEGAL_ARGUMENT_ERROR`
>* if paramType is not a valid value from the appropriate enumeration
>* if paramType refers to a vector parameter in **vgSetParameterf** or **vgSetParameteri**
>* if paramType refers to a scalar parameter in **vgSetParameterfv** or **vgSetParameteriv** and count is not equal to 1
>* if value is not a legal enumerated value for the given parameter in **vgSetParameterf** or **vgSetParameteri**, or if values[i] is not a legal enumerated value for the given parameter in **vgSetParameterfv** or **vgSetParameteriv** for 0 ≤ i < count
>* if values is NULL in **vgSetParameterfv** or **vgSetParameteriv** and count is greater than 0
>* if values is not properly aligned in **vgSetParameterfv** or **vgSetParameteriv**
>* if count is less than 0 in vgSetParameterfv or vgSetParameteriv
>* if count is not a valid value for the given parameter

####_vgGetParameter and vgGetParameterVectorSize_
<a name="vgGetParameter and vgGetParameterVectorSize"></a>
The **vgGetParameter** functions return the value of a parameter on a given `VGHandle-` based object.

The **vgGetParameterVectorSize** function returns the number of elements in the vector that will be returned by the **vgGetParameteriv** or **vgGetParameterfv** functions if called with the given paramType argument. For scalar values, 1 is returned. If **vgGetParameteriv** or **vgGetParameterfv** is called with a smaller value for count than that returned by **vgGetParameterVectorSize**, only the first count elements of the vector are retrieved. Use of a greater value for count will result in an error.

The original value passed to **vgSetParameter** (provided the call to **vgSetParameter** completed without error) should be returned by **vgGetParameter** (except where specifically noted), even if the implementation makes use of a truncated or quantized value internally.

If an error occurs during a call to **vgGetParameterf**, **vgGetParameteri**, or **vgGetParameterVectorSize**, the return value is undefined. If an error occurs during a call to **vgGetParameterfv** or **vgGetParameteriv**, nothing is written to values.

```
VGfloat vgGetParameterf (VGHandle object,
                         VGint paramType)
VGint   vgGetParameteri (VGHandle object,
                         VGint paramType)
VGint   vgGetParameterVectorSize (VGHandle object,
                                  VGint paramType)
void    vgGetParameterfv(VGHandle object,
                         VGint paramType,
                         VGint count, VGfloat * values)
void    vgGetParameteriv(VGHandle object,
                         VGint paramType,
                         VGint count, VGint * values)
```

>**ERRORS**
>
>`VG_BAD_HANDLE_ERROR`
>* if object is not a valid handle, or is not shared with the current context
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>* if *paramType* is not a valid value from the appropriate enumeration
>* if *paramType* refers to a vector parameter in **vgGetParameterf** or **vgGetParameteri**
>* if values is NULL in **vgGetParameterfv** or **vgGetParameteriv**
>* if values is not properly aligned in **vgGetParameterfv** or **vgGetParameteriv**
>* if count is less than or equal to 0 in **vgGetParameterfv* or **vgGetParameteriv**
>* if count is greater than the value returned by **vgGetParameterVectorSize** for the given parameter in **vgGetParameterfv** or **vgGetParameteriv**

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

#_7 Scissoring, Masking, and Clearing_
<a name="Chapter 7"></a><a name="Scissoring, Masking, and Clearing"></a>
All drawing is _clipped_ (restricted) to the bounds of the drawing surface, and may be further clipped to the interior of a set of scissoring rectangles. If available, a mask is applied for further clipping and to create soft edge and partial transparency effects.

Pixels outside the drawing surface bounds, or (when scissoring is enabled) not in any scissoring rectangle are not affected by any drawing operation. For any drawing operation, each pixel will receive the same value for any setting of the scissoring rectangles that contains the pixel. That is, the placement of the scissoring rectangles, and whether scissoring is enabled, affects only whether a given pixel will be written, without affecting what value it will receive.

##_7.1 Scissoring_
<a name="Scissoring"></a>
Drawing may be restricted to the union of a set of scissoring rectangles. Scissoring is enabled when the parameter `VG_SCISSORING` has the value `VG_TRUE`. Scissoring may be disabled by calling **vgSeti** with a `paramType` argument of `VG_SCISSORING` and a value of `VG_FALSE`.

####_VG_MAX_SCISSOR_RECTS_
<a name="VG_MAX_SCISSOR_RECTS"></a>
The `VG_MAX_SCISSOR_RECTS` parameter contains the maximum number of scissoring rectangles that may be supplied for the `VG_SCISSOR_RECTS` parameter. All implementations must support at least 32 scissor rectangles. If there is no implementation-defined limit, a value of `VG_MAXINT` may be returned. The value may be retrieved by calling **vgGeti** with a `paramType` argument of `VG_MAX_SCISSOR_RECTS`:

```
VGint maxScissorRects = vgGeti(VG_MAX_SCISSOR_RECTS);
```

####_Specifying Scissoring Rectangles_
<a name="Specifying Scissoring Rectangles"></a>
Each scissoring rectangle is specified as an integer 4-tuple of the form $(minX, minY, width, height)$, where $minX$ and $minY$ are inclusive. A rectangle with $width ≤ 0$ or $height ≤ 0$ is ignored. The scissoring region is defined as the union of all the specified rectangles. The rectangles as specified need not be disjoint. If scissoring is enabled and no valid scissoring rectangles are present, no drawing occurs. If more than `VG_MAX_SCISSOR_RECTS` rectangles are specified, those beyond the first `VG_MAX_SCISSOR_RECTS` are discarded immediately (and will not be returned by **vgGet**).

```
#define NUM_RECTS 2
/* { Min X, Min Y, Width, Height } 4-Tuples */
VGint coords[4*NUM_RECTS] = { 20, 30, 100, 200,
                              50, 70,  80,  80 };
vgSetiv(VG_SCISSOR_RECTS, 4*NUM_RECTS, coords)
```

##_7.2 Masking_
<a name="Masking"></a>
All drawing operations may be modified by a drawing surface mask (also known as an alpha mask for historical reasons), which is a separate implementation-internal buffer defining an additional coverage value at each sample of the drawing surface. The values from this buffer modify the coverage value computed by the rasterization stage of the pipeline.

Masking is enabled when a mask is present for the drawing surface (_e.g.,_ by specifying an `EGLConfig` with an `EGL_ALPHA_MASK_SIZE` attribute having a value greater than zero) and the `VG_MASKING` parameter has the value `VG_TRUE`. Masking may be disabled by calling **vgSeti** with a parameter of `VG_MASKING` and a value of `VG_FALSE`. If a drawing surface mask is present, it may be manipulated by the **vgMask** function regardless of the value of `VG_MASKING` at the time of the call. If a drawing surface mask is not present, the behavior is the same as though there were a mask having a value of 1 at every pixel; functions that manipulate the mask values have no effect.

In addition to the drawing surface mask, OpenVG applications may manipulate _mask layer_ objects, which are application-level objects accessed via handles. The term _layer_ is not meant to imply any ordering between such objects; rather, it is up to the application to modify the drawing surface mask using mask layer objects in order to affect the rendering process. A mask layer that is created when a multisampled drawing surface is current may only be used to modify that drawing surface's mask or other drawing surface masks that share the same bit depth and subpixel sample layout.

In this section, we will describe coverage values as ranging from 0 to 1. The actual bit depth used for computation is implementation-dependent. For single- sampled surfaces, it must be possible to obtain configurations supporting a mask with at least 1 bit for 1-bit black and white drawing surfaces, a mask with at least 4 bits for 16-bit color drawing surfaces, and a mask with at least 8 bits for 8-bit grayscale and 24-bit color drawing surfaces. For multi-sampled surfaces, implementations are only required to provide 1 mask bit per sample.

The drawing surface mask may be thought of as a single-channel image with the same size as the current drawing surface. Initially, the mask has the value of 1 at every pixel. Changes to the mask outside of its bounds are ignored. If the drawing surface size changes, the drawing surface mask associated with it is resized accordingly, with new pixels being initialized to a coverage value of 1. If the context acquires a new drawing surface, the drawing surface mask is reset. Some implementations may modify primitive drawing using the path geometry used to generate the mask directly, without first rasterizing such geometry into a pixel-based representation.

A mask defines a stencil area through which primitives are placed before being drawn. The union, intersection, and subtraction operations on masks are defined by analogy with the corresponding operations on the stencil areas.

The mask coverage values are multiplied by the corresponding coverage values of each primitive being drawn in the clipping and masking stage (stage 5) of the rendering pipeline (see Section 2.5). The masking step is equivalent (except for color space conversions that may occur) to replacing the source image with the result of the Porter-Duff operation “Src in Mask” (see Section 13.3).

####_VGMaskOperation_
<a name="VGMaskOperation"></a>
The `VGMaskOperation` enumeration defines the set of possible operations that may be used to modify a mask, possibly making use of a new mask image. Each operation occurs within a rectangular region of interest.

The `VG_CLEAR_MASK` operation sets all mask values in the region of interest to 0, ignoring the new mask image.

The `VG_FILL_MASK` operation sets all mask values in the region of interest to 1, ignoring the new mask image.

The `VG_SET_MASK` operation copies values in the region of interest from the new mask image, overwriting the previous mask values.

The `VG_UNION_MASK` operation replaces the previous mask in the region of interest by its union with the new mask image. The resulting values are always greater than or equal to their previous value.

The `VG_INTERSECT_MASK` operation replaces the previous mask in the region of interest by its intersection with the new mask image. The resulting mask values are always less than or equal to their previous value.

The `VG_SUBTRACT_MASK` operation subtracts the new mask from the previous mask and replaces the previous mask in the region of interest by the resulting mask. The resulting values are always less than or equal to their previous value.

Table 5 gives the equations defining the new mask value for each mask operation in terms of the previous mask value μprev and the newly supplied mask value $μ_{mask}$.
Operation|Mask Equation
---------|-------------
VG_CLEAR_MASK|$μ_{new} = 0$
VG_FILL_MASK|$μ_{new} = 1$
VG_SET_MASK|$μ_{new} = μ_{mask}$
VG_UNION_MASK|$μ_{new} = 1 – (1 – μ_{mask})*(1 – μ_{prev})$
VG_INTERSECT_MASK|$μnew = μ_{mask} *μ_{prev}$
VG_SUBTRACT_MASK|$μnew = μ_{prev}*(1 – μ_{mask})$

_Table 5: VGMaskOperation Equations_

```
typedef enum {
  VG_CLEAR_MASK     = 0x1500,
  VG_FILL_MASK      = 0x1501,
  VG_SET_MASK       = 0x1502,
  VG_UNION_MASK     = 0x1503,
  VG_INTERSECT_MASK = 0x1504,
  VG_SUBTRACT_MASK  = 0x1505
} VGMaskOperation;
```

####_vgMask_
<a name="vgMask"></a>
The **vgMask** function modifies the drawing surface mask values according to a given operation, possibly using coverage values taken from a mask layer or bitmap image given by the mask parameter. If no mask is configured for the current drawing surface, **vgMask** has no effect.

The affected region is the intersection of the drawing surface bounds with the rectangle extending from pixel $(x, y)$ of the drawing surface and having the given width and height in pixels. For operations that make use of the mask parameter (_i.e.,_ operations other than `VG_CLEAR_MASK` and `VG_FILL_MASK`), mask pixels starting at $(0, 0)$ are used, and the region is further limited to the width and height of mask. For the `VG_CLEAR_MASK` and `VG_FILL_MASK` operations, the mask parameter is ignored and does not affect the region being modified. The value `VG_INVALID_HANDLE` may be supplied in place of an actual image handle.

If `mask` is a `VGImage` handle, the image defines coverage values at each of its pixels as follows. If the image pixel format includes an alpha channel, the alpha channel is used. Otherwise, values from the red (for color image formats) or grayscale (for grayscale formats) channel are used. The value is divided by the maximum value for the channel to obtain a value between 0 and 1. If the image is bi-level (black and white), black pixels receive a value of 0 and white pixels receive a value of 1.

If `mask` is a `VGMaskLayer` handle, it must be compatible with the current drawing surface mask.

If the drawing surface mask is multisampled, this operation may perform dithering. That is, it may assign different values to different drawing surface mask samples within a pixel so that the average mask value for the pixel will match the incoming value more accurately.

```
void vgMask(VGHandle mask, VGMaskOperation operation,
            VGint x, VGint y, VGint width, VGint height)
```

>**ERRORS**
>
>`VG_BAD_HANDLE_ERROR`
>* if operation is not `VG_CLEAR_MASK` or `VG_FILL_MASK`, and mask is not a valid mask layer or image handle, or is not shared with the current context `VG_IMAGE_IN_USE_ERROR`
>* if mask is a `VGImage` that is currently a rendering target `VG_ILLEGAL_ARGUMENT_ERROR`
>* if `operation` is not a valid value from the `VGMaskOperation` enumeration
>* if `width` or `height` is less than or equal to 0
>* if `mask` is a `VGMaskLayer` and is not compatible with the current surface mask

####_vgRenderToMask_
<a name="vgRenderToMask"></a>
The **vgRenderToMask** function modifies the current surface mask by applying the given `operation` to the set of coverage values associated with the rendering of the given `path`. If `paintModes` contains `VG_FILL_PATH`, the path is filled; if it contains `VG_STROKE_PATH`, the path is stroked. If both are present, the mask `operation` is performed in two passes, first on the filled path geometry, then on the stroked path geometry.

Conceptually, for each pass, an intermediate single-channel image is initialized to 0, then filled with those coverage values that would result from the first four stages of the OpenVG pipeline (_i.e.,_ state setup, stroked path generation if applicable, transformation, and rasterization) when drawing a path with **vgDrawPath** using the given set of paint modes and all current OpenVG state settings that affect path rendering (scissor rectangles, rendering quality, fill rule, stroke parameters, etc.). Paint settings (e.g., paint matrices) are ignored. Finally, the drawing surface mask is modified as though **vgMask** were called using the intermediate image as the mask parameter. Changes to path following this call do not affect the mask. If operation is `VG_CLEAR_MASK` or `VG_FILL_MASK`, path is ignored and the entire mask is affected.

An implementation that supports geometric clipping of primitives may cache the contents of `path` and make use of it directly when primitives are drawn, without generating a rasterized version of the clip mask. Other implementation-specific optimizations may be used to avoid materializing a full intermediate mask image.

```
 void vgRenderToMask(VGPath path, VGbitfield paintModes,
                    VGMaskOperation operation)
```

>**ERRORS**
>
>`VG_BAD_HANDLE_ERROR`
>
>* if `path` is not a valid path handle `VG_ILLEGAL_ARGUMENT_ERROR`
>* if `paintModes` is not a valid bitwise OR of values from the `VGPaintMode` enumeration
>* if `operation` is not a valid value from the `VGMaskOperation` enumeration

####_VGMaskLayer_
<a name="VGMaskLayer"></a>
Mask layers may be stored and manipulated using opaque handles of type `VGMaskLayer`. When a mask layer is created, it is assigned a fixed size and a subpixel layout determined by the multisampling properties of the current drawing surface. A mask layer may only be used with the surface that was current at the time it was created or with another surface with the same multisampling properties.

```
typedef VGHandle VGMaskLayer;
```

####_vgCreateMaskLayer_
<a name="vgCreateMaskLayer"></a>
**vgCreateMaskLayer** creates an object capable of storing a mask layer with the given `width` and `height` and returns a `VGMaskLayer` handle to it. The mask layer is defined to be compatible with the format and multisampling properties of the current drawing surface. If there is no current drawing surface, no mask is configured for the current drawing surface, or an error occurs, `VG_INVALID_HANDLE` is returned. All mask layer values are initially set to one.

```
VGMaskLayer vgCreateMaskLayer(VGint width, VGint height)
```

>**ERRORS**
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>
>* if `width` or `height` are less than or equal to 0
>* if `width` is greater than `VG_MAX_IMAGE_WIDTH`
>* if `height` is greater than `VG_MAX_IMAGE_HEIGHT`
>* if `width*height` is greater than `VG_MAX_IMAGE_PIXELS`

####_vgDestroyMaskLayer_
<a name="vgDestroyMaskLayer"></a>

The resources associated with a mask layer may be deallocated by calling **vgDestroyMaskLayer**. Following the call, the maskLayer handle is no longer valid in the current context.

```
void vgDestroyMaskLayer(VGMaskLayer maskLayer)
```

>**ERRORS**
>
>`VG_BAD_HANDLE_ERROR`
>* if `maskLayer` is not a valid mask handle

####_vgFillMaskLayer_
<a name="vgFillMaskLayer"></a>

The `vgFillMaskLayer` function sets the values of a given `maskLayer` within a given rectangular region to a given value. The floating-point value value must be between 0 and 1. The value is rounded to the closest available value supported by the mask layer. If two values are equally close, the larger value is used.

```
void vgFillMaskLayer(VGMaskLayer maskLayer,
                     VGint x, VGint y, VGint width, VGint height,
                     VGfloat value)
```
>**ERRORS**
>
>`VG_BAD_HANDLE_ERROR`
>* if `maskLayer` is not a valid mask layer handle, or is not shared with the current context
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>* if `value` is less than 0 or greater than 1
>* if `width` or `height` is less than or equal to 0
>* if `x` or `y` is less than 0
>* if `x + width` is greater than the width of the mask
>* if `y + height` is greater than the height of the mask

####_vgCopyMask_
<a name="vgCopyMask"></a>
**vgCopyMask** copies a portion of the current surface mask into a `VGMaskLayer` object. The source region starts at $(sx, sy)$ in the surface mask, and the destination region starts at $(dx, dy)$ in the destination `maskLayer`. The copied region is clipped to the given `width` and `height` and the bounds of the source and destination. If the current context does not contain a surface mask, **vgCopyMask** does nothing.

```
   void vgCopyMask(VGMaskLayer maskLayer,
                VGint dx, VGint dy, VGint sx, VGint sy,
                VGint width, VGint height)
```

>**ERRORS**
>
>`VG_BAD_HANDLE_ERROR`
>* if maskLayer is not a valid mask layer handle
>`VG_ILLEGAL_ARGUMENT_ERROR`
>* if `width` or `height` are less than or equal to 0
>* if `maskLayer` is not compatible with the current surface mask

##_7.3 Fast Clearing_
<a name="Fast Clearing"></a>
The **vgClear** function allows a region of pixels to be set to a single color with a single call.

####_vgClear_
<a name="vgClear"></a>
The **vgClear** function fills the portion of the drawing surface intersecting the rectangle extending from pixel $(x, y)$ and having the given `width` and `height` with a constant color value, taken from the `VG_CLEAR_COLOR` parameter. The color value is expressed in non-premultiplied sRGBA (sRGB color plus alpha)format. Values outside the $[0, 1]$ range are interpreted as the nearest endpoint of the range. The color is converted to the destination color space in the same manner as if a rectangular path were being filled. Clipping and scissoring take place in the usual fashion, but antialiasing, masking, and blending do not occur.

```
void vgClear(VGint x, VGint y, VGint width, VGint height)
```

>**ERRORS**
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>* if `width` or `height` is less than or equal to 0

For example, to set the entire drawing surface with dimensions `WIDTH` and `HEIGHT` to an opaque yellow color, the following code could be used:

```
VGfloat color[4] = { 1.0f, 1.0f, 0.0f, 1.0f }; /* Opaque yellow */
vgSeti(VG_SCISSORING, VG_FALSE);
vgSetfv(VG_CLEAR_COLOR, 4, color);
vgClear(0, 0, WIDTH, HEIGHT);

```

#_8 Paths_
<a name="Chapter 8"></a><a name="Paths"></a>
Paths are the heart of the OpenVG API. All geometry to be drawn must be defined in terms of one or more paths. Paths are defined by a sequence of _segment commands_ (or _segments_). Each segment command in the standard format may specify a move, a straight line segment, a quadratic or cubic Bézier segment, or an elliptical arc. Extensions may define other segment types.

##_8.1 Moves_
<a name="Moves"></a>
A path segment may consist of a “move to” segment command that causes the path to jump directly to a given point, starting a new subpath without drawing.

##_8.2 Straight Line Segments_
<a name="Straight Line Segments"></a>
Paths may contain horizontal, vertical, or arbitrary line segment commands. A special “close path” segment command may be used to generate a straight line segment joining the current vertex of a path to the vertex that began the current portion of the path.

##_8.3 Bézier Curves_
<a name="Bézier Curves"></a>
Bézier curves are polynomial curves defined using a parametric representation. That is, they are defined as the set of points of the form $(x(t), y(t))$, where $x(t)$ and $y(t)$ are polynomials of t and t varies continuously from 0 to 1. Paths may contain quadratic or cubic Bézier segment commands.

###_8.3.1 Quadratic Bézier Curves_
<a name="Quadratic Bézier Curves"></a>
A quadratic Bézier segment is defined by three control points, $(x0, y0)$, $(x1, y1)$, and $(x2, y2)$. The curve starts at $(x0, y0)$ and ends at $(x2, y2)$. The shape of the curve is influenced by the placement of the internal control point $(x1, y1)$, but the curve does not usually pass through that point. Assuming non-coincident control points, the tangent of the curve at the initial point $x_0$ is aligned with and has the same direction as the vector $x_1 – x_0$ and the tangent at the final point $x_2$ is aligned with and has the same direction as the vector $x_2 – x_1$. The curve is defined by the set of points $(x(t), y(t))$ as $t$ varies from 0 to 1, where:

$$x(t)=x_0(1-t)^2+2*x_1*(1-t)*t+x_2*t^2$$
$$y(t)=y_0(1-t)^2+2*y_1*(1-t)*t+y_2*t^2$$

###_8.3.2 Cubic Bézier Curves_
<a name="Cubic Bézier Curves"></a>
Cubic Bézier segments are defined by four control points $(x0, y0)$, $(x1, y1)$, $(x2, y2)$, and $(x3, y3)$. The curve starts at $(x_0, y_0)$ and ends at $(x_3, y_3)$. The shape of the curve is influenced by the placement of the internal control points $(x_1, y_1)$ and $(x_2, y_2)$, but the curve does not usually pass through those points. Assuming non-coincident control points, the tangent of the curve at the initial point $x_0$ is aligned with and has the same direction as the vector $x_1 – x_0$ and the tangent at the final point $x_3$ is aligned with and has the same direction as the vector $x_3 – x_2$. The curve is defined by the set of points $(x(t), y(t))$ as $t$ varies from 0 to 1, where:

$$x(t)=x_0*(1-t)^3+3*x_1*(1-t)^2*t+3*x_2*(1-t)*t^2+x_3*t^3$$
$$y(t)=y_0*(1-t)^3+3*y_1*(1-t)^2*t+3*y_2*(1-t)*t^2+y_3*t^3$$

###_8.3.3 **$G^1$** Smooth Segments_
<a name="G1 Smooth Segments"></a>
$G^1$ Smooth quadratic or cubic segments implicitly define their first internal control point in such a manner as to guarantee a continuous tangent direction at the join point when they are joined to a preceding quadratic or cubic segment. Geometrically, this ensures that the two segments meet without a sharp corner. However, the length of the unnormalized tangent vector may experience a discontinuity at the join point.

$G^1$ smoothness at the initial point of a quadratic or cubic segment may be guaranteed by suitable placement of the first internal control point $(x_1, y_1)$ of the following segment. Given a previous quadratic or cubic segment with an internal control point $(px, py)$ and final endpoint $(ox, oy)$, we compute $(x_1, y_1)$ as $(2*ox – px, 2*oy – py)$ (_i.e.,_ the reflection of the point $(px, py)$ about the point $(ox, oy)$). For segments of the same type, this will provide $C^1$ smoothness (see the next section).

![Figure4](https://raw.githubusercontent.com/Ajou-Khronies/OpenVG_1.1_Spec/0b3d69e55090b1dd337328b0c97e582cfa750746/figures/Figure_4.png)
_Figure 4: Smooth Curve Construction_

###_8.3.4 **$C^1$** Smooth Segments_
<a name="C1 Smooth Segments"></a>
_[ Note: this section is informative only. ]_

$C^1$ smooth quadratic or cubic segments define their first internal control point $(x_1, y_1)$ in such a manner as to guarantee a continuous first derivative at the join point when they are joined to a preceding quadratic or cubic segment. Geometrically, this ensures that the two segments meet with continuous parametric velocity at the join point. This is a stronger condition than $G^1$ continuity.
Note that joining a $C^1$ smooth segment to a preceding line segment will not produce a smooth join. To guarantee a smooth join, convert line segments to equivalent quadratic or cubic curves whose internal control points all lie along the line segment.

Given a previous quadratic or cubic segment with an internal control point $(px, py)$ and final endpoint $(ox, oy)$, $(x_1, y_1)$ is computed as follows:

* When joining a previous quadratic or cubic segment to a following segment of the same type (quadratic or cubic):
$$ (x_1,y_1) = (2*ox-px,2*oy-py) $$
* When joining a previous quadratic segment to a following cubic segment:
$$ (x_1,y_1) = (5*ox-2*px,5*oy-2*py)/3 $$

In this section, we define the standard data format for paths that may be used to definesequences of various types of path segments. Extensions may define other path data formats.

#### VG_PATH_FORMAT_STANDARD
<a name="VG_PATH_FORMAT_STANDARD"></a>

The `VG_PATH_FORMAT_STANDARD `macro defines a constant to be used as an argument to **vgCreatePath** to indicate that path data are stored using the standard format. As this API is revised, the lower 16 bits of version number may increase. Each version of OpenVG will accept formats defined in all prior specification versions with which it is backwards-compatible.

Extensions wishing to define additional path formats may register for format identifiers that will differ in their upper 16 bits;the lower 16 bits may be used by the extension vendor for versioning purposes.

```
#define VG_PATH_FORMAT_STANDARD 0;
```

### 8.5.1 Path Segment Command Side Effects
<a name="Path Segment Command Side Effects"></a>

In order to define the semantics of each segment command type, we define three reference points (all are initially (0, 0)):

• *(sx, sy)*: the beginning of the current subpath,*i*.*e*., the position of the last ``MOVE_TO`` segment.

• $(ox, oy)$: the last point of the previous segment.

• $(px, py)$: the last internal control point of the previous segment, if the segment was a (regular or smooth) quadratic or cubic Bézier, or else the last point of the previous segment.

Figure 6 illustrates the locations of these points at the end of a sequence of segment commands ``{ `MOVE_TO`, LINE_TO, CUBIC_TO }``.

<img src="figures/Figure 6.PNG"/>

*Figure 6: Segment Reference Points*

We define points *(x0, y0)*, *(x1, y1)*, and *(x2, y2)* in the discussion below as absolute coordinates. For segments defined using relative coordinates, *(x0, y0)*, etc., are defined as the incoming coordinate values added to $(ox, oy)$. Ellipse rh, rv, and rot parameters are unaffected by the use of relative coordinates. Each segment (except for `MOVE_TO` segments) begins at the point $(ox, oy)$ defined by the previous segment.

A path consists of a sequence of subpaths. As path segment commands are encountered, each segment is appended to the current subpath. The current subpath is ended by a `MOVE_TO` or `CLOSE_PATH` segment, and a new current subpath is begun. The end of the path data also ends the current subpath.

### 8.5.2 Segment Commands
<a name="Segment Commands"></a>

The following table describes each segment command type along with its prefix, the number of specified coordinates and parameters it requires, the numerical value of the segment command, the formulas for any implicit coordinates, and the side effects of the segment command on the points $(ox, oy)$, *(sx, sy)*, and $(px, py)$ and on the termination of the current subpath.

_**Type**_ | _**VGPathSegment**_ | _**Coordinates**_ | _**Value**_ | _**Implicit Points**_ | _**Side Effects**_
---- | ------------- | ----------- | ----- | --------------- | ------------
Close Path| `CLOSE_PATH` | *none* | 0 | | *(px,py)=(ox,oy)=(sx,sy)* End current subpath
Move|`MOVE_TO`|*x0,y0*|2||*(sx,sy)=(px,py)=(ox,oy)=(x0,y0)* End current subpath
Line|`LINE_TO`|*x0,y0*|4||*(px,py)=(ox,oy)=(x0,y0)*
Horiz Line|`HLINE_TO`|*x0*|6|*y0=oy*|*(px,py)=(x0,oy) ox=x0*
Vertical Line|`VLINE_TO`|*y0*|8|*x0=ox*|*(px,py)=(ox,y0) oy=y0*
Quadratic|`QUAD_TO`|*x0,y0,x1,y1*|10||*(px,py)=(x0,y0) (ox,oy)=(x1,y1)*
Cubic|`CUBIC_TO`|*x0,y0,x1,y1,x2,y2*|12||*(px,py)=(x1,y1) (ox,oy)=(x2,y2)*
G1 Smooth Quad|`SQUAD_TO`|*x1,y1*|14|*(x0,y0)=(2*ox-px,2*oy-py)*|*(px,py)= (2*ox-px, 2*oy-py) (ox,oy)=(x1,y1)*
G1 Smooth Cubic|`SCUBIC_TO`|*x1,y1,x2,y2*|16|*(x0,y0)=(2*ox-px,2*oy-py)*|*(px,py)=(x1,y1) (ox,oy)=(x2,y2)*
Small CCW Arc|`SCCWARC_TO|*rh,rv,rot,x0,y0*|18||*(px,py)=(ox,oy)=(x0,y0)*
Small CW Arc|`SCWARC_TO|*rh,rv,rot,x0,y0*|20||*(px,py)=(ox,oy)=(x0,y0)*
Large CCW|`LCCWARC_TO|*rh,rv,rot,x0,y0*|22||*(px,py)=(ox,oy)=(x0,y0)*
Arc|||||
Large CW Arc|`LCWARC_TO`|*rh,rv,rot,x0,y0*|24||*(px,py)=(ox,oy)=(x0,y0)*
Reserved|Reserved||26,28,30||

*Table 6: Path Segment Commands*

Each segment type may be defined using either absolute or relative coordinates. A relative coordinate $(x, y)$ is added to $(ox, oy)$ to obtain the corresponding absolute coordinate $(ox + x, oy + y)$. Relative coordinates are converted to absolute coordinates immediately as each segment is encountered during rendering.

The `HLINE_TO` and `VLINE_TO` segment types are provided in order to avoid the need for an SVG viewing application (for example) to perform its own relative to absolute conversions when parsing path data.

In SVG, the behavior of smooth quadratic and cubic segments differs slightly from the behavior defined above. If a smooth quadratic segment does not follow a quadratic segment, or a smooth cubic segment does not follow a cubic segment, the initial control point $(x0, y0)$ is placed at $(ox, oy)$ instead of being computed as the reflection of $(px, py)$.This behavior may be emulated by converting an SVG smooth segment into a regular segment with all of its control points specified when the preceding segment is of a different degree.

Note that the coordinates of a path are defined even if the path begins with a segment type other than `MOVE_TO` (including `HLINE_TO`, `VLINE_TO`, or relative segment types) since the coordinates are based on the initial values of $(ox, oy)$, $(sx, sy)$, and *(px, py)* which are each defined as (0, 0).

### 8.5.3 Coordinate Data Formats
<a name="Coordinate Data Formats"></a>

Coordinate and parameter data (henceforth called simply coordinate data) may be expressed in the set of formats shown in Table 7 below. Multi-byte coordinate data (*i*.*e*., `S_16`, `S_32` and F datatypes) are represented in application memory using the native byte order (endianness) of the platform. Implementations may quantize incoming data in the `S_32` and F formats to a lesser number of bits, provided at least 16 bits of precision are maintained.

Judicious use of smooth curve segments and 8- and 16-bit datatypes can result in substantial memory savings for common path data, such as font glyphs. Using smaller datatypes also conserves bus bandwidth when transferring paths from application memory to OpenVG.

_**Datatype**_|`VG_PATH_DATATYPE` _**Suffix**_|_**bytes**_|_**Value**_
--------------|-------------------------------|-----------|-----------
8-bit signed integer|S_8|1|0
16-bit signed integer|S_16|2|1
32-bit signed integer|S_32|4|2
IEEE 754 floating-point|F|4|3

*Table 7: Path Coordinate Datatypes*

#### VGPathDatatype
<a name="VGPathDatatype"></a>

The `VGPathDatatype` enumeration defines values describing the possible numerical datatypes for path coordinate data.

```
typedef enum {
VG_PATH_DATATYPE_S_8 = 0,
VG_PATH_DATATYPE_S_16 = 1,
VG_PATH_DATATYPE_S_32 = 2,
VG_PATH_DATATYPE_F = 3
} VGPathDatatype;
```

###8.5.4 Segment Type Marker Definitions

Segment type markers are defined as 8-bit integers, with the leading 3 bits reserved for future use, the next 4 bits containing the segment command type, and the least significant bit indicating absolute vs. relative coordinates (0 for absolute, 1 for relative). The reserved bits must be set to 0.

For the `CLOSE_PATH` segment command, the value of the Abs/Rel bit is ignored.

<img src="figures/Figure 7.PNG"/>

*Figure 7: Segment Type Marker Layout*

#### VGPathAbsRel
<a name=" VGPathAbsRel"></a>

The `VGPathAbsRel` enumeration defines values indicating absolute (`VG_ABSOLUTE`) and relative (`VG_RELATIVE`) values.

```
typedef enum {
VG_ABSOLUTE = 0,
VG_RELATIVE = 1
} VGPathAbsRel;
```

#### VGPathSegment
<a name="VGPathSegment"></a>

The `VGPathSegment` enumeration defines values for each segment command type. The values are pre-shifted by 1 bit to allow them to be combined easily with values from `VGPathAbsRel`.

```
typedef enum {
VG_CLOSE_PATH = ( 0 << 1),
VG_MOVE_TO = ( 1 << 1),
VG_LINE_TO = ( 2 << 1),
VG_HLINE_TO = ( 3 << 1),
VG_VLINE_TO = ( 4 << 1),
VG_QUAD_TO = ( 5 << 1),
VG_CUBIC_TO = ( 6 << 1),
VG_SQUAD_TO = ( 7 << 1),
VG_SCUBIC_TO = ( 8 << 1),
VG_SCCWARC_TO = ( 9 << 1),
VG_SCWARC_TO = (10 << 1),
VG_LCCWARC_TO = (11 << 1),
VG_LCWARC_TO = (12 << 1)
} VGPathSegment;
```
#### VGPathCommand
<a name="VGPathCommand"></a>

The `VGPathCommand` enumeration defines combined values for each segment command type and absolute/relative value. The values are shifted left by one bit and ORed bitwise (*i*.*e*., using the C | operator) with the appropriate value from `VGPathAbsRel` to obtain a complete segment command value.

```
typedef enum {
VG_MOVE_TO_ABS = VG_MOVE_TO | VG_ABSOLUTE,
VG_MOVE_TO_REL = VG_MOVE_TO | VG_RELATIVE,
VG_LINE_TO_ABS = VG_LINE_TO | VG_ABSOLUTE,
VG_LINE_TO_REL = VG_LINE_TO | VG_RELATIVE,
VG_HLINE_TO_ABS = VG_HLINE_TO | VG_ABSOLUTE,
VG_HLINE_TO_REL = VG_HLINE_TO | VG_RELATIVE,
VG_VLINE_TO_ABS = VG_VLINE_TO | VG_ABSOLUTE,
VG_VLINE_TO_REL = VG_VLINE_TO | VG_RELATIVE,
VG_QUAD_TO_ABS = VG_QUAD_TO | VG_ABSOLUTE,
VG_QUAD_TO_REL = VG_QUAD_TO | VG_RELATIVE,
VG_CUBIC_TO_ABS = VG_CUBIC_TO | VG_ABSOLUTE,
VG_CUBIC_TO_REL = VG_CUBIC_TO | VG_RELATIVE,
VG_SQUAD_TO_ABS = VG_SQUAD_TO | VG_ABSOLUTE,
VG_SQUAD_TO_REL = VG_SQUAD_TO | VG_RELATIVE,
VG_SCUBIC_TO_ABS = VG_SCUBIC_TO | VG_ABSOLUTE,
VG_SCUBIC_TO_REL = VG_SCUBIC_TO | VG_RELATIVE,
VG_SCCWARC_TO_ABS = VG_SCCWARC_TO | VG_ABSOLUTE,
VG_SCCWARC_TO_REL = VG_SCCWARC_TO | VG_RELATIVE,
VG_SCWARC_TO_ABS = VG_SCWARC_TO | VG_ABSOLUTE,
VG_SCWARC_TO_REL = VG_SCWARC_TO | VG_RELATIVE,
VG_LCCWARC_TO_ABS = VG_LCCWARC_TO | VG_ABSOLUTE,
VG_LCCWARC_TO_REL = VG_LCCWARC_TO | VG_RELATIVE,
VG_LCWARC_TO_ABS = VG_LCWARC_TO | VG_ABSOLUTE,
VG_LCWARC_TO_REL = VG_LCWARC_TO | VG_RELATIVE
} VGPathCommand;

```

### 8.5.5 Path Example
<a name="Path Example"></a>

The following code example shows how to traverse path data stored in application memory using the standard representation. A byte is read containing a segment command, and the segment command type and relative/absolute flag are extracted by application-defined `SEGMENT_COMMAND` and `SEGMENT_ABS_REL` macros. The number of coordinates and number of bytes per coordinate (for the given data format) are also determined using lookup tables. Finally, the relevant portion of the path data stream representing the current segment is copied into a temporary buffer and used as an argument to a user-defined **processSegment** function that may perform further processing.

```
#define PATH_MAX_COORDS 6 /* Maximum number of coordinates/command */
#define PATH_MAX_BYTES 4 /* Bytes in largest data type */
#define SEGMENT_COMMAND(command) /* Extract segment type */ \
((command) & 0x1e)
#define SEGMENT_ABS_REL(command) /* Extract absolute/relative bit */ \
((command) & 0x1)
/* Number of coordinates for each command */
static const VGint numCoords[] = {0,2,2,1,1,4,6,2,4,5,5,5,5};
/* Number of bytes for each datatype */
static const VGint numBytes[] = {1,2,4,4};
/* User-defined function to process a single segment */
extern void
processSegment(VGPathSegment command, VGPathAbsRel absRel,
VGPathDatatype datatype,
void * segmentData);
/* Process a path in the standard format, one segment at a time. */
void
processPath(const VGubyte * pathSegments, const void * pathData,
int numSegments, VGPathDatatype datatype)
{
VGubyte segmentType, segmentData[PATH_MAX_COORDS*PATH_MAX_BYTES];
VGint segIdx = 0, dataIdx = 0;
VGint command, absRel, numBytes;
while (segIdx < numSegments) {
segmentType = pathSegments[segIdx++];
command = SEGMENT_COMMAND(segmentType);
absRel = SEGMENT_ABS_REL(segmentType);
numBytes = numCoords[command]*numBytes[datatype];
/* Copy segment data for further processing */
memcpy(segmentData, &pathData[dataIdx], numBytes);
/* Process command */
processSegment(command, absRel, datatype, (void *) segmentData);
dataIdx += numBytes;
}
}
```

## 8.6 Path Operations
<a name="Path Operations"></a>

In addition to filling or stroking a path, the API allows the following basic operations on paths:

• Create a path with a given set of capabilities (**vgCreatePath**)

• Remove data from a path (**vgClearPath**)

• Deallocate a path (**vgDestroyPath**)

• Query path information (**using vgGetParameter**)

• Query the set of capabilities for a path (**vgGetPathCapabilities**)

• Reduce the set of capabilities for a path (**vgRemovePathCapabilities**)

• Append data from one path onto another (**vgAppendPath**)

• Append data onto a path (**vgAppendPathData**)

• Modify coordinates stored in a path (**vgModifyPathCoords**)

• Transform a path (**vgTransformPath**)

• Interpolate between two paths (**vgInterpolatePath**)

• Determine the geometrical length of a path (**vgPathLength**)

• Get position and tangent information for a point at a given geometric distance
along path (**vgPointAlongPath**)

• Get an axis-aligned bounding box for a path (**vgPathBounds**,
**vgTransformedPathBounds**)

Higher-level geometric primitives are defined in the optional `VGU` utility library (see
Section 17):

• Append a line to a path (**vguLine**)

• Append a polyline (connected sequence of line segments) or polygon to a
path (**vguPolygon**)

• Append a rectangle to a path (**vguRect**)

• Append a round-cornered rectangle to a path (**vguRoundRect**)

• Append an ellipse to a path (**vguEllipse**)

• Append a circular arc to a path (**vguArc**)

### 8.6.1 Storage of Paths
<a name="Storage of Paths"></a>

OpenVG stores path data internally to the implementation. Paths are referenced via opaque VGPath handles. Applications may initialize paths using the memory representation defined above or other representations defined by extensions. It is possible for an implementation to store path data in hardware-accelerated memory. Implementations may also make use of their own internal representation of path segments. The intent is for applications to be able to define a set of paths, for example one for each glyph in the current typeface, and to be able to re-render each previously defined path with maximum efficiency.

#### VGPath
<a name="VGPath"></a>

`VGPath` represents an opaque handle to a path.

```
typedef VGHandle VGPath;
```

### 8.6.2 Creating and Destroying Paths
<a name="Creating and Destroying Paths"></a>

Paths are created and destroyed using the **vgCreatePath** and **vgDestroyPath** functions. During the lifetime of a path, an application may indicate which path operations it plans to perform using path capability flags defined by the `VGPathCapabilities` enumeration.

#### _**VGPathCapabilities**_
<a name="VGPathCapabilities"></a>

The `VGPathCapabilities` enumeration defines a set of constants specifying which operations may be performed on a given path object. At the time a path is defined, the application specifies which operations it wishes to be able to perform on the path. Over time, the application may disable previously enabled capabilities, but it may not reenable capabilities once they have been disabled. This feature allows OpenVG implementations to make use of internal path representations that may not support all path operations, possibly resulting in higher performance on paths where those operations will not be performed.

The capability bits and the functionality they allow are described below:

• `VG_PATH_CAPABILITY_APPEND_FROM` – use path as the 'srcPath' argument to **vgAppendPath**

• `VG_PATH_CAPABILITY_APPEND_TO` – use path as the 'dstPath' argument to **vgAppendPath** and **vgAppendPathData**

• `VG_PATH_CAPABILITY_MODIFY` – use path as the 'dstPath' argument to **vgModifyPathCoords**

•`VG_PATH_CAPABILITY_TRANSFORM_FROM` – use path as the 'srcPath argument to **vgTransformPath**

• `VG_PATH_CAPABILITY_TRANSFORM_TO` – use path as the 'dstPath' argument to **vgTransformPath**

• `VG_PATH_CAPABILITY_INTERPOLATE_FROM` – use path as the `startPath` or `endPath` argument to **vgInterpolatePath**

• `VG_PATH_CAPABILITY_INTERPOLATE_TO` – use path as the `dstPath` argument to **vgInterpolatePath**

• `VG_PATH_CAPABILITY_PATH_LENGTH` – use path as the `path` argument to **vgPathLength**

• `VG_PATH_CAPABILITY_POINT_ALONG_PATH` – use path as the `path` argument to **vgPointAlongPath**

• `VG_PATH_CAPABILITY_TANGENT_ALONG_PATH` – use path as the `path` argument to **vgPointAlongPath** with non-`NULL tangentX` and `tangentY` arguments

• `VG_PATH_CAPABILITY_PATH_BOUNDS` – use path as the `path` argument to **vgPathBounds**

• `VG_PATH_CAPABILITY_PATH_TRANSFORMED_BOUNDS` – use path as the `path` argument to **vgPathTransformedBounds**

• `VG_PATH_CAPABILITY_ALL` – a bitwise OR of all the defined path capabilities

```
typedef enum {
VG_PATH_CAPABILITY_APPEND_FROM = (1 << 0),
VG_PATH_CAPABILITY_APPEND_TO = (1 << 1),
VG_PATH_CAPABILITY_MODIFY = (1 << 2),
VG_PATH_CAPABILITY_TRANSFORM_FROM = (1 << 3),
VG_PATH_CAPABILITY_TRANSFORM_TO = (1 << 4),
VG_PATH_CAPABILITY_INTERPOLATE_FROM = (1 << 5),
VG_PATH_CAPABILITY_INTERPOLATE_TO = (1 << 6),
VG_PATH_CAPABILITY_PATH_LENGTH = (1 << 7),
VG_PATH_CAPABILITY_POINT_ALONG_PATH = (1 << 8),
VG_PATH_CAPABILITY_TANGENT_ALONG_PATH = (1 << 9),
VG_PATH_CAPABILITY_PATH_BOUNDS = (1 << 10),
VG_PATH_CAPABILITY_PATH_TRANSFORMED_BOUNDS = (1 << 11),
VG_PATH_CAPABILITY_ALL = (1 << 12) - 1
} VGPathCapabilities;
```

It is legal to call **vgCreatePath**, **vgClearPath**, and **vgDestroyPath** regardless of the current setting of the path’s capability bits, as these functions discard the existing path definition.

#### vgCreatePath
<a name="vgCreatePath"></a>

**vgCreatePath** creates a new path that is ready to accept segment data and returns a `VGPath` handle to it. The path data will be formatted in the format given by `pathFormat`, typically `VG_PATH_FORMAT_STANDARD`. The `datatype` parameter contains a value from the `VGPathDatatype` enumeration indicating the datatype that will be used for coordinate data. The `capabilities` argument is a bitwise OR of the desired `VGPathCapabilities` values. Bits of `capabilities` that do not correspond to values from `VGPathCapabilities` have no effect. If an error occurs, `VG_INVALID_HANDLE` is returned.


The `scale` and `bias` parameters are used to interpret each coordinate of the path data; an incoming coordinate value *v* will be interpreted as the value *(scale*v* + *bias*). `scale` must not equal 0. The datatype, scale, and bias together define a valid coordinate data range for the path; segment commands that attempt to place a coordinate in the path that is outside this range will overflow silently, resulting in an undefined coordinate value. Functions that query a path containing such values, such as **vgPathLength** and **vgPointAlongPath**, also return undefined results.

The `segmentCapacityHint` parameter provides a hint as to the total number of segments that will eventually be stored in the path. The `coordCapacityHint` parameter provides a hint as to the total number of specified coordinates (as defined in the “Coordinates” column of Table 6) that will eventually be stored in the path. A value less than or equal to 0 for either hint indicates that the capacity is unknown. The path storage space will in any case grow as needed, regardless of the hint values. However, supplying hints may improve performance by reducing the need to allocate additional space as the path grows. Implementations should allow applications to append segments and coordinates up to the stated capacity in small batches without degrading performance due to excessive memory reallocation.

```
VGPath vgCreatePath(VGint pathFormat,
VGPathDatatype datatype,
VGfloat scale, VGfloat bias,
VGint segmentCapacityHint,
VGint coordCapacityHint,
VGbitfield capabilities)
```

> **_ERRORS_**
>
> `VG_UNSUPPORTED_PATH_FORMAT_ERROR`
> * if `pathFormat` is not a supported format `VG_ILLEGAL_ARGUMENT_ERROR`
> * if `datatype` is not a valid value from the `VGPathDatatype` enumeration
> * if `scale` is equal to 0

#### vgClearPath
<a name="vgClearPath"></a>

**vgClearPath** removes all segment command and coordinate data associated with a path. The handle continues to be valid for use in the future, and the path format and datatype retain their existing values. The `capabilities` argument is a bitwise OR of the desired VGPathCapabilities values. Bits of `capabilities` that do not correspond to values from `VGPathCapabilities` have no effect. Using **vgClearPath** may be more efficient than destroying and re-creating a path for short-lived paths.

```
void vgClearPath(VGPath path, VGbitfield capabilities)
```
> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context

#### vgDestroyPath
<a name=" vgDestroyPath"></a>

**vgDestroyPath** releases any resources associated with `path`, and makes the handle invalid in all contexts that shared it.

```
void vgDestroyPath(VGPath path)
```
> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context

### 8.6.3 Path Queries
<a name="Path Queries"></a>

#### VGPathParamType
<a name="VGPathParamType"></a>

Values from the `VGPathParamType` enumeration may be used as the `paramType` argument to **vgGetParameter** to query various features of a path. All of the parameters defined by `VGPathParamType` are read-only. Table 8 shows the datatypes for each parameter type.

```
typedef enum {
VG_PATH_FORMAT = 0x1600,
VG_PATH_DATATYPE = 0x1601,
VG_PATH_SCALE = 0x1602,
VG_PATH_BIAS = 0x1603,
VG_PATH_NUM_SEGMENTS = 0x1604,
VG_PATH_NUM_COORDS = 0x1605
} VGPathParamType;
```

_**Parameter**_ | _**Datatype**_
--------------- | --------------
VG_PATH_FORMAT|VGint
VG_PATH_DATATYPE|VGint
VG_PATH_SCALE|VGfloat
VG_PATH_BIAS|VGfloat
VG_PATH_NUM_SEGMENTS|VGint
VG_PATH_NUM_COORDS|VGint

*Table 8: VGPathParamType Datatypes*

#### Path Format
<a name="Path Format"></a>

The command format of a path is queried as an integer value using the `VG_PATH_FORMAT` parameter:

```
VGPath path;
VGint pathFormat = vgGetParameteri(path, VG_PATH_FORMAT);
```


#### Path Datatype
<a name="Path Datatypet"></a>

The coordinate datatype of a path is queried as an integer value using the `VG_PATH_DATATYPE` parameter. The returned integral value should be cast to the `VGPathDatatype` enumeration:

```
GPath path;
VGPathDatatype pathDatatype =
(VGPathDatatype)vgGetParameteri(path, VG_PATH_DATATYPE);
```

#### Path Scale
<a name="Path Scale"></a>

The scale factor of the path is queried as a floating-point value using the `VG_PATH_SCALE` parameter:
```
VGPath path;
VGfloat pathScale = vgGetParameterf(path, VG_PATH_SCALE);
```
#### Path Bias
<a name="Path Bias"></a>

The bias of the path is queried as a floating-point value using the `VG_PATH_BIAS` parameter:

```
VGPath path;
VGfloat pathBias = vgGetParameterf(path, VG_PATH_BIAS);
```

#### Number of Segments
<a name="Number of Segments"></a>

The number of segments stored in the path is queried as an integer value using the `VG_PATH_NUM_SEGMENTS` parameter:
```
VGPath path;
VGint pathNumSegments = vgGetParameteri(path, VG_PATH_NUM_SEGMENTS);
```
#### Number of Coordinates
<a name="Number of Coordinates"></a>

The total number of specified coordinates (*i*.*e*., those defined in the “Coordinates” column of Table 6) stored in the path is queried as an integer value using the `VG_PATH_NUM_COORDS` parameter:
```
VGPath path;
VGint pathNumCoords = vgGetParameteri(path, VG_PATH_NUM_COORDS);
```

### 8.6.4 Querying and Modifying Path Capabilities
<a name="Querying and Modifying Path Capabilities"></a>

#### vgGetPathCapabilities
<a name="vgGetPathCapabilities"></a>

The **vgGetPathCapabilities** function returns the current capabilities of the `path`, as a bitwise OR of `VGPathCapabilities` constants. If an error occurs, 0 is returned.

```
VGbitfield vgGetPathCapabilities(VGPath path)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context

#### vgRemovePathCapabilities
<a name="vgRemovePathCapabilities"></a>

The **vgRemovePathCapabilities** function requests the set of capabilities specified in the `capabilities` argument to be disabled for the given `path`. The `capabilities` argument is a bitwise OR of the `VGPathCapabilities` values whose removal is requested. Attempting to remove a capability that is already disabled has no effect. Bits of `capabilities` that do not correspond to values from `VGPathCapabilities` have no effect.


An implementation may choose to ignore the request to remove a particular capability if no significant performance improvement would result. In this case, **vgGetPathCapabilities** will continue to report the capability as enabled.
```
void vgRemovePathCapabilities(VGPath path, VGbitfield capabilities)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context

### 8.6.5 Copying Data Between Paths
<a name="Copying Data Between Paths"></a>

#### vgAppendPath
<a name="vgAppendPath"></a>

**vgAppendPath** appends a copy of all path segments from `srcPath` onto the end of the existing data in `dstPath`. It is legal for `srcPath` and `dstPath` to be handles to the same path object, in which case the contents of the path are duplicated. If `srcPath` and `dstPath` are handles to distinct path objects, the contents of srcPath will not be affected by the call.

The `VG_PATH_CAPABILITY_APPEND_FROM` capability must be enabled for `srcPath`, and the `VG_PATH_CAPABILITY_APPEND_TO` capability must be enabled for `dstPath`.


If the scale and bias of `dstPath` define a narrower range than that of `srcPath`, overflow may occur silently.
```
void vgAppendPath(VGPath dstPath, VGPath srcPath)
```
> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if either `dstPath` or `srcPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> if `VG_PATH_CAPABILITY_APPEND_FROM` is not enabled for srcPath
> if `VG_PATH_CAPABILITY_APPEND_TO` is not enabled for dstPath

### 8.6.6 Appending Data to a Path
<a name=" Appending Data to a Path"></a>

#### vgAppendPathData
<a name="vgAppendPathData"></a>

**vgAppendPathData** appends data taken from `pathData` to the given path `dstPath`. The data are formatted using the path format of `dstPath` (as returned by querying the path’s `VG_PATH_FORMAT` parameter using **vgGetParameteri**). The `numSegments` parameter gives the total number of entries in the `pathSegments` array, and must be greater than 0. Legal values for the **pathSegments** array are the values from the `VGPathCommand` enumeration as well as `VG_CLOSE_PATH` and (`VG_CLOSE_PATH` | `VG_RELATIVE`) (which are synonymous).

The `pathData` pointer must be aligned on a 1-, 2-, or 4-byte boundary (as defined in the “Bytes” column of Table 7) depending on the size of the coordinate datatype (as returned by querying the path’s `VG_PATH_DATATYPE` parameter using **vgGetParameteri**). The `VG_PATH_CAPABILITY_APPEND_TO` capability must be enabled for `path`.

Each incoming coordinate value, regardless of datatype, is transformed by the scale
factor and bias of the path.

```
void vgAppendPathData(VGPath dstPath,
VGint numSegments,
const VGubyte * pathSegments,
const void * pathData)
```
> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `dstPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> * if `VG_PATH_CAPABILITY_APPEND_TO` is not enabled for dstPath `VG_ILLEGAL_ARGUMENT_ERROR`
> * if `pathSegments` or `pathData` is `NULL`
> * if `pathData` is not properly aligned
> * if `numSegments` is less than or equal to 0
> * if `pathSegments` contains an illegal command

### 8.6.7 Modifying Path Data
<a name=" Modifying Path Data"></a>

Coordinate data in an existing path may be modified, for example to create animation
effects. Implementations should choose an internal representation for paths that have the `VG_PATH_CAPABILITY_MODIFY` capability enabled that allows for efficient modification of the coordinate data.

#### vgModifyPathCoords
<a name="vgModifyPathCoords"></a>

**vgModifyPathCoords** modifies the coordinate data for a contiguous range of segments of `dstPath`, starting at `startIndex` (where 0 is the index of the first path segment) and having length `numSegments`. The data in `pathData` must be formatted in exactly the same manner as the original coordinate data for the given segment range, unless the path has been transformed using **vgTransformPath** or interpolated using **vgInterpolatePath**. In these cases, the path will have been subject to the segment promotion rules specified in those functions.

The `pathData` pointer must be aligned on a 1-, 2-, or 4-byte boundary
depending on the size of the coordinate datatype (as returned by querying the
path’s `VG_PATH_DATATYPE` parameter using **vgGetParameteri**). The
`VG_PATH_CAPABILITY_MODIFY` capability must be enabled for path

Each incoming coordinate value, regardless of datatype, is transformed by the
scale factor and bias of the path.
```
void vgModifyPathCoords(VGPath dstPath,
VGint startIndex, VGint numSegments,
const void * pathData)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `dstPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> * if `VG_PATH_CAPABILITY_APPEND_TO` is not enabled for dstPath `VG_ILLEGAL_ARGUMENT_ERROR`
> * if `pathData` is `NULL`
> * if `pathData` is not properly aligned
> * if `startIndex` is less than 0
> * if `numSegments` is less than or equal to 0
> * if `startIndex + numSegments` is greater than the number of segments in the path

### 8.6.8 Transforming a Path
<a name="Transforming a Path"></a>

#### vgTransformPath
<a name="vgTransformPath"></a>

**vgTransformPath** appends a transformed copy of `srcPath` to the current contents of
dstPath. The appended path is equivalent to the results of applying the current pathuser-
to-surface transformation (`VG_MATRIX_PATH_USER_TO_
SURFACE`) to `srcPath`.

It is legal for `srcPath` and `dstPath` to be handles to the same path object, in
which case the transformed path will be appended to the existing path. If
`srcPath` and `dstPath` are handles to distinct path objects, the contents of
`srcPath` will not be affected by the call.

All `HLINE_TO_*` and `VLINE_TO_*` segments present in `srcPath` are implicitly
converted to `LINE_TO_*` segments prior to applying the transformation. The original
copies of these segments in `srcPath` remain unchanged.


Any `*ARC_TO` segments are transformed, but the endpoint parametrization of the
resulting arc segments are implementation-dependent. The results of calling
**vgInterpolatePath** on a transformed path that contains such segments are undefined.


The `VG_PATH_CAPABILITY_TRANSFORM_FROM` capability must be enabled for
`srcPath`, and the` VG_PATH_CAPABILITY_TRANSFORM_TO` capability must be
enabled for `dstPath`.

Overflow may occur silently if coordinates are transformed outside the datatype range of
dstPath.
```
void vgTransformPath(VGPath dstPath, VGPath srcPath)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if either `dstPath` or `srcPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> * if `VG_PATH_CAPABILITY_TRANSFORM_FROM` is not enabled for srcPath
> * if `VG_PATH_CAPABILITY_TRANSFORM_TO` is not enabled for dstPath

### 8.6.9 Interpolating Between Paths
<a name="Interpolating Between Paths"></a>

Interpolation takes two compatible paths, in a sense described below, and defines a new
path that interpolates between them by a parameter `amount`. When `amount` is equal to
0, the result is equivalent to the first path; when `amount` is equal to 1, the result is
equivalent to the second path. Values between 0 and 1 produce paths that smoothly
interpolate between the two extremes. Values outside the [0, 1] range produce
extrapolated paths. Conceptually, interpolation occurs as follows. First, the two path
parameters are copied and the copies are normalized by:

• Converting all coordinates to floating-point format, applying the path scale and bias
parameters

• Converting all relative segments to absolute form

• Converting `{H,V}LINE_TO_* `segments to `LINE_TO form`

• Converting `(S)QUAD_TO_*/SCUBIC_TO_*` segments to `CUBIC_TO` form

• Retaining all `*ARC_TO_*` and `CLOSE_PATH` segments

If, following normalization, both paths have the same sequence of segment types
(treating all forms of arc as the same), interpolation proceeds by linearly interpolating
between each corresponding pair of segment parameters in the normalized paths. If the
starting arc type differs from the final arc type, the starting arc type is used for values of
amount less than 0.5, and the final arc type is used for values greater than or equal to
0.5. Finally, the coordinates are converted to the data type of the destination.

#### vgInterpolatePath
<a name="vgInterpolatePath"></a>

The **vgInterpolatePath** function appends a path, defined by interpolation (or
extrapolation) between the paths `startPath` and `endPath` by the given `amount`, to
the path `dstPath`. It returns `VG_TRUE` if interpolation was successful (*i*.*e*., the paths
had compatible segment types after normalization), and `VG_FALSE` otherwise. If
interpolation is unsuccessful, `dstPath` is left unchanged.


It is legal for `dstPath` to be a handle to the same path object as either
`startPath` or `endPath` or both, in which case the contents of the source path
or paths referenced by `dstPath` will have the interpolated path appended. If
`dstPath` is not the a handle to the same path object as either `startPath` or
`endPath`, the contents of `startPath` and `endPath` will not be affected by the
call.

Overflow may occur silently if the datatype of `dstPath` has insufficient range to store
an interpolated coordinate value.

The `VG_PATH_CAPABILITY_INTERPOLATE_FROM` capability must be enabled
for both of `startPath` and `endPath`, and the `INTERPOLATE_TO` capability
must be enabled for `dstPath`.

```
VGboolean vgInterpolatePath(VGPath dstPath,
VGPath startPath,
VGPath endPath,
VGfloat amount)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if any of `dstPath`, `startPath`, or `endPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> * if `VG_PATH_CAPABILITY_PATH_INTERPOLATE_TO` is not enabled for dstPath
> * if `VG_PATH_CAPABILITY_PATH_INTERPOLATE_FROM` is not enabled for `startPath` or `endPath`

### 8.6.10 Length of a Path
<a name="Length of a Path"></a>

An approximation to the geometric length of a portion of a path may be obtained by
calling the **vgPathLength** function. `MOVE_TO` segments and implicit path closures (see
Section 8.7.1) do not contribute to the path length. `CLOSE_PATH` segments have the
same length as a `LINE_TO` segment with the same endpoints.

#### vgPathLength
<a name="vgPathLength"></a>

The **vgPathLength** function returns the length of a given portion of a path in the user
coordinate system (that is, in the path’s own coordinate system, disregarding any matrix
settings). Only the subpath consisting of the `numSegments` path segments beginning
with `startSegment` (where the initial path segment has index 0) is used. If an
error occurs, -1.0f is returned.
The `VG_PATH_CAPABILITY_PATH_LENGTH` capability must be enabled for `path`.

```
VGfloat vgPathLength(VGPath path,
VGint startSegment, VGint numSegments);
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context `VG_PATH_CAPABILITY_ERROR`
> if `VG_PATH_CAPABILITY_PATH_LENGTH` is not enabled for `path VG_ILLEGAL_ARGUMENT_ERROR`
> * if startSegment is less than 0 or greater than the index of the final path segment
> * if `numSegments` is less than or equal to 0
> * if `(startSegment + numSegments – 1)` is greater than the index of the final path segment

### 8.6.11 Position and Tangent Along a Path
<a name="Position and Tangent Along a Path"></a>

Some path operations, such as the placement and orientation of text along a path, require
the computation of a set of points along a path as well as a normal (perpendicular) vector
at each point. The **vgPointAlongPath** function provides points along the path as well
as normalized tangent vectors (from which normals may easily be derived).

#### The Tangents of a Path Segment
<a name="The Tangents of a Path Segment"></a>

The tangent at a given point along a path is defined as a vector pointing in the same
direction as the path at that point. The tangent at any point of a line segment is parallel to
the line segment; the tangent at any point along a Bézier curve or elliptical arc segment
may be defined using the derivatives of the parametric equations *x(t)* and *y(t)* that define
the curve. The incoming tangent at a point is defined using the direction in which the
curve is “traveling” prior to arriving at the point; the outgoing tangent is defined using
the direction the curve is traveling as it leaves the point. The incoming and outgoing
tangents may differ at a vertex joining different curve segments, or at a sharp “cusp” in a
curve.


If a point along a path segment has no tangent defined, for example where a path
segment has collapsed to a single point, the following algorithm is used to define
incoming and outgoing tangents at the point. Search backwards until a segment is found
with a tangent defined at its end point, or the start of the current path is reached; if a
tangent is found, use it as the incoming tangent. Search forwards until a segment is found
with a tangent defined at its starting point, or the end of the current path is reached; if a
tangent is found, use it as the outgoing tangent. If these searches produce exactly one
defined tangent, that tangent is used as both the incoming and outgoing tangent. If the
searches produced no defined tangent, the incoming and outgoing tangents are both
assigned the value (1, 0). Tangent vectors are normalized to have unit length.

#### vgPointAlongPath
<a name="vgPointAlongPath"></a>

The **vgPointAlongPath** function returns the point lying a given distance along a given
portion of a path and the unit-length tangent vector at that point. Only the subpath
consisting of the `numSegments` path segments beginning with `startSegment`
(where the initial path segment has index 0) is used. For the remainder of this
section we refer only to this subpath when discussing paths.
If `distance` is less than or equal to 0, the starting point of the path is used. If
`distance` is greater than or equal to the path length (*i*.*e*., the value returned by
**vgPathLength** when called with the same `startSegment` and `numSegments`
parameters), the visual ending point of the path is used.
Intermediate values return the $(x, y)$ coordinates and tangent vector of the point at the
given distance along the path. Because it is not possible in general to compute exact
distances along a path, an implementation is not required to use exact
computation even for segments where such computation would be possible. For
example, the path:

`MOVE_TO 0, 0; LINE_TO 10, 0 // draw a line of length 10`

`MOVE_TO 10, 10 // create a discontinuity`

`LINE_TO 10, 20 // draw a line of length 10`

may return either (10, 0) or (10, 10) (or points nearby) as the point at distance
10.0. Implementations are not required to compute distances exactly, as long as
they satisfy the constraint that as `distance` increases monotonically the
returned point and tangent move forward monotonically along the path.

Where the implementation is able to determine that the point being queried
lies exactly at a discontinuity or cusp, the incoming point and tangent should be
returned. In the example above, returning the pre-discontinuity point (10, 0) and
incoming tangent (1, 0) is preferred to returning the post-discontinuity point (10,10) and outgoing tangent (0, 1).

The `VG_PATH_CAPABILITY_POINT_ALONG_PATH` capability must be enabled for
path.

If the reference arguments x and y are both non-`NULL`, and the
`VG_PATH_CAPABILITY_POINT_ALONG_PATH` capability is enabled for `path`, the
point $(x, y)$ is returned in *x* and *y*. Otherwise the variables referenced by *x* and *y* are not
written.

If the reference arguments `tangentX` and `tangentY` are both non-`NULL`, and the
`VG_PATH_CAPABILITY_TANGENT_ALONG_PATH` capability is enabled for `path`,
the geometric tangent vector at the point $(x, y)$ is returned in `tangentX` and
`tangentY`. Otherwise the variables referenced by `tangentX` and `tangentY` are not
written.

Where the incoming tangent is defined, **vgPointAlongPath** returns it. Where only the
outgoing tangent is defined, the outgoing tangent is returned.

The points returned by **vgPointAlongPath** are not guaranteed to match the path as
rendered; some deviation is to be expected.

```
void vgPointAlongPath(VGPath path,
VGint startSegment, VGint numSegments,
VGfloat distance,
VGfloat * x, VGfloat * y,
VGfloat * tangentX, VGfloat * tangentY)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context `VG_PATH_CAPABILITY_ERROR`
> * If x and y are both non-`NULL`, and the `VG_PATH_CAPABILITY_POINT_ALONG_PATH` is not enabled for `path`
> * If `tangentX` and `tangentY` are both non-`NULL`, and the `VG_PATH_CAPABILITY_TANGENT_ALONG_PATH` capability is not enabled for `path`
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if startSegment is less than 0 or greater than the index of the final path segment
> * if `numSegments` is less than or equal to 0
> * if (startSegment + numSegments – 1) is less than 0 or greater than the index of the final path segment
> * if x, y, tangentX or tangentY is not properly aligned

### 8.6.12 Querying the Bounding Box of a Path
<a name="Querying the Bounding Box of a Path"></a>

To draw complex scenes efficiently, it is important to avoid drawing objects that do not appear in the region being drawn. A simple way to determine whether an object may be visible is to determine whether its *bounding box* – an axis-aligned rectangle that is guaranteed to contain the entire object – intersects the drawn region. The **vgPathBounds** and **vgPathTransformedBounds** functions provide bounding box information.

Two types of bounding boxes may be obtained for a path. The first, obtained by calling **vgPathBounds**, returns a tight axis-aligned bounding box for the area contained within the path in its own coordinate system. The second, obtained by calling **vgPathTransformedBounds**, returns an axis-aligned bounding box for the path as it will appear when drawn on the drawing surface (*i*.*e*., following application of the current path-user-to-surface transform). The latter function does not guarantee to bound the shape tightly, but still may provide tighter bounds than those obtained by transforming the result of **vgPathBounds**, at a lower cost.


The bounding box of a path is defined to contain all points along the path, including isolated points created by `MOVE_TO` segments. The fill rule has no effect on the determination of the bounding box. If the path is to be stroked, the application must adjust the bounding box to take the stroking parameters into account. Note that Miter joins in particular may extend far outside the bounding box.

#### vgPathBounds
<a name="vgPathBounds"></a>

The **vgPathBounds** function returns an axis-aligned bounding box that tightly bounds the interior of the given path. Stroking parameters are ignored. If path is empty, `minX` and `minY` are set to 0 and `width` and `height` are set to -1. If `path` contains a single point, `minX` and `minY` are set to the coordinates of the point and `width` and `height` are set to 0.

The `VG_PATH_CAPABILITY_PATH_BOUNDS` capability must be enabled for path

```
void vgPathBounds(VGPath path,
VGfloat * minX, VGfloat * minY,
VGfloat * width, VGfloat * height)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context `VG_PATH_CAPABILITY_ERROR`
> * if minX, minY, width, or height is `NULL`
> * if minX, minY, width, or height is not properly aligned `VG_PATH_CAPABILITY_ERROR`
> if `VG_PATH_CAPABILITY_PATH_BOUNDS` is not enabled for path


#### vgPathTransformedBounds
<a name="vgPathTransformedBounds"></a>

The **vgPathTransformedBounds** function returns an axis-aligned bounding box that is guaranteed to enclose the geometry of the given `path` following transformation by the current path-user-to-surface transform. The returned bounding box is not guaranteed to fit tightly around the path geometry. If `path` is empty, `minX` and `minY` are set to 0 and `width` and `height` are set to -1. If `path` contains a single point, `minX` and `minY` are set to the coordinates of the point and `width` and `height` are set to 0.

The `VG_PATH_CAPABILITY_PATH_BOUNDS` capability must be enabled for
path.

```
void vgPathBounds(VGPath path,
VGfloat * minX, VGfloat * minY,
VGfloat * width, VGfloat * height)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context `VG_PATH_CAPABILITY_ERROR`
> * if minX, minY, width, or height is `NULL`
> * if minX, minY, width, or height is not properly aligned `VG_PATH_CAPABILITY_ERROR`
> if `VG_PATH_CAPABILITY_PATH_TRANSFORMED_BOUNDS` is not enabled for path

## 8.7 Interpretation of Paths
<a name="Interpretation of Paths"></a>

The interpretation of a path, composed of a sequence of one or more subpaths, depends on whether it is to be stroked or filled. For stroked paths, each subpath has stroking parameters applied to it separately, with the dash phase at the end of each subpath used at the beginning of the next subpath. This process results in a set of stroked shapes. The union of these shapes then defines the outline path to be filled. For filled paths, the interior of the path (as defined below) is filled.

### 8.7.1 Filling Paths
<a name="Filling Paths"></a>
A simple, non-self-intersecting closed path divides the plane into two regions, a bounded *inside* region and an unbounded *outside* region. Note that knowing the orientation of the outermost path (*i*.*e*., clockwise or counter-clockwise) is not necessary to differentiate between the inside and outside regions.

A path that self-intersects, or that has multiple overlapping subpaths, requires additional information in order to define the inside region. Two rules that provide different definitions for the area enclosed by such paths, known as the non-zero and even/odd fill rules, are supported by OpenVG. To determine whether any point in the plane is contained in the inside region, imagine drawing a line from that point out to infinity in any direction such that the line does not cross any vertex of the path. For each edge that is crossed by the line, add 1 to the counter if the edge crosses from left to right, as seen by an observer walking along the line towards infinity, and subtract 1 if the edge crosses from right to left. In this way, each region of the plane will receive an integer value.

The non-zero fill rule says that the point is inside the shape if the resulting sum is not equal to 0. The even/odd rule says that the point is inside the shape if the resulting sum is odd, regardless of sign (*e*.*g*., -7 is odd, 0 is even). Consider the star-shaped path shown in Figure 8 below, indicated with solid lines. The orientation of the lines making up the path is indicated with arrows. An imaginary line to infinity starting in the central region of the star is shown as a dashed line pointing to the right. Two edges of the star cross the line to infinity going left to right, indicated by the downward-pointing arrows. The central region therefore has a count of +2. According to the even/odd rule, it is outside the path, whereas according to the non-zero rule it is inside. Implementations must be able to deal with paths having up to 255 crossings along any line. The behavior of more complex paths is undefined.

<img src="figures/Figure 8.PNG"/>

*Figure 8: Even/Odd Fill Rule*

#### Creating Holes in Paths
<a name="Creating Holes in Paths"></a>

The fill rule is applied with respect to all subpaths simultaneously during filling. Thus, one subpath may be used to create a hole inside an enclosing subpath by defining the two subpaths with opposing orientations (clockwise versus counter-clockwise). Note that the orientation of extremely small paths may depend on the numerical precision of the internal representation of points. Care should be taken to avoid the use of paths that have nearly collapsed to a line or a point.

The relative orientation of subpaths, along with the fill rule, determines whether overlapping subpaths will result in holes, as shown in Figure 9 below.

||_**Even/Old Fil Rule**_|_**Non-Zero Fill Rule**_|
|-|-------|-------|
|_**Same Orientation**_|<img src="figures/Figure 9-1.PNG"/>|<img src="figures/Figure 9-2.PNG"/>|
|_**Opposing Orientation**_|<img src="figures/Figure 9-3.PNG"/>|<img src="figures/Figure 9-4.PNG"/>|


#### _Implicit Closure of Filled Subpaths_
<a name="Implicit_Closure_of_Filled_Subpaths"></a>
When filling a path, any subpaths that do not end with a `CLOSE_PATH` segment command (_i.e_., that are terminated with a `MOVE_TO_ABS` or `MOVE_TO_REL` segment command, or that contain the final segment of the path) are implicitly closed, without affecting the position of any other vertices of the path or the $\left( sx, sy\right)$, $\left( px, py\right)$ or $\left( ox, oy\right)$ variables. For example, consider the sequence of segment commands:

`MOVE_TO_ABS 0, 0`; `LINE_TO_ABS 10, 10`; `LINE_TO_ABS 10, 0`
`MOVE_TO_REL 10, 2`; `LINE_TO_ABS 30, 12`; `LINE_TO_ABS 30, 2`

If filled, this sequence will result in one filled triangle with vertices $\left( 0, 0\right)$, $\left( 10, 10\right)$, and $\left( 10, 0\right)$ and another filled triangle with vertices $\left( 20, 2\right)$, $\left( 30, 12\right)$, and $\left( 30, 2\right)$. Note that the implicit closure of the initial subpath prior to the `MOVE_TO_REL` segment command has no effect on the starting coordinate of the second triangle; it is computed by adding the relative offset $\left( 10, 2\right)$ to the final coordinate of the previous segment $\left( 10, 0\right)$ to obtain $\left( 20, 2\right)$ and is not altered by the (virtual) insertion of the line connecting the first subpath’s final vertex $\left( 10, 0\right)$ to its initial vertex $\left( 0, 0\right)$). Figure 10 illustrates this process, with the resulting filled areas highlighted. When stroking a path, no implicit closure takes place, as shown in Figure 11. Implicit closure affects only the output when filling a path, and does not alter the path data in any way.
![figure10](figures/figure10.PNG)
_Figure 10: Implicit Closure of Filled Paths_
<a name="Figure10:Implicit_Closure_of_Filled_Paths"></a>

![figure11](figures/figure11.PNG)
_Figure 11: Stroked Paths Have No Implicit Closure_
<a name="Figure11:Stroked_Paths_Have_No_Implicit_Closure"></a>

### _8.7.2 Stroking Paths_
<a name="Stroking_Paths"></a>
Stroking a path consists of “widening” the edges of the path using a straight-line pen held perpendicularly to the path. At the start and end vertices of the path, an additional end-cap style is applied. At interior vertices of the path, a line join style is applied. At a cusp of a Bézier segment, the pen is rotated smoothly between the incoming and outgoing tangents.

Conceptually, stroking of a path is performed in two steps. First, the stroke parameters are applied in the user coordinate system to form a new shape representing the end result of dashing, widening the path, and applying the end cap and line join styles. Second, a path is created that defines the outline of this stroked shape. This path is transformed using the path-user-to-surface transformation (possibly involving shape distortions due to non-uniform scaling or shearing). Finally, the resulting path is filled with paint in exactly the same manner as when filling a user-defined path using the non-zero fill rule.

Stroking a path applies a single “layer” of paint, regardless of any intersections between portions of the thickened path. Figure 12 illustrates this principle. A single stroke (above) is drawn with a black color and an alpha value of 50%, compared with two separate strokes (below) drawn with the same color and alpha values. The single stroke produces a shape with a uniform color of 50% gray, as if a single layer of translucent paint has been applied, even where portions of the path overlap one another. By contrast, the separate strokes produce two applications of the translucent paint in the area of overlap, resulting in a darkened area.
![figure12](figures/figure12.PNG)
_Figure 12: Each Stroke Applies a Single Layer of Paint_
<a name="Figure12:_Each_Stroke_Applies_a_Single_Layer_of_Paint"></a>

### _8.7.3 Stroke Parameters_
<a name="Stroke_Parameters"></a>
Stroking a path involves the following parameters, set on a context:
* Line width in user coordinate system units
* End cap style – one of Butt, Round, or Square
* Line join style – one of Miter, Round, or Bevel
* Miter limit – if using Miter join style
* Dash pattern – array of dash on/off lengths in user units
* Dash phase – initial offset into the dash pattern

These parameters are set on the current context using the variants of the **vgSet** function. The values most recently set prior to calling **vgDrawPath** (see Section 8.8) are applied to generate the stroke.

#### _End Cap Styles_
<a name="End_Cap_Styles"></a>
Figure 13 illustrates the Butt (top), Round (center), and Square (bottom) end cap styles applied to a path consisting of a single line segment. Figure 14 highlights the additional geometry created by the end caps. The Butt end cap style terminates each segment with a line perpendicular to the tangent at each endpoint. The Round end cap style appends a semicircle with a diameter equal to the line width centered around each endpoint. The Square end cap style appends a rectangle with two sides of length equal to the line width perpendicular to the tangent, and two sides of length equal to half the line width parallel to the tangent, at each endpoint. The outgoing tangent is used at the left endpoint and the incoming tangent is used at the right endpoint.
![figure13](figures/figure13.PNG)
_Figure 13: End Cap Styles_
<a name="Figure13:End_Cap_Styles"></a>

![figure14](figures/figure14.PNG)
_Figure 14: End Cap Styles with Additional Geometry Highlighted_
<a name="Figure14:End_Cap_Styles_with_Additional_Geometry_Highlighted"></a>

#### _Line Join Styles_
<a name="Line_Join_Styles"></a>
Figure 15 illustrates the Bevel (left), Round (center), and Miter (right) line join styles applied to a pair of line segments. Figure 16 highlights the additional geometry created by the line joins. The Bevel join style appends a triangle with two vertices at the outer endpoints of the two “fattened” lines and a third vertex at the intersection point of the two original lines. The Round join style appends a wedge-shaped portion of a circle, centered at the intersection point of the two original lines, having a radius equal to half the line width. The Miter join style appends a trapezoid with one vertex at the intersection point of the two original lines, two adjacent vertices at the outer endpoints of the two “fattened” lines and a fourth vertex at the extrapolated intersection point of the outer perimeters of the two “fattened” lines.

When stroking using the Miter join style, the _miter length_ (_i.e_., the length between the intersection points of the inner and outer perimeters of the two “fattened” lines) is compared to the product of the user-set miter limit and the line width. If the miter length exceeds this product, the Miter join is not drawn and a Bevel join is substituted.
![figure15](figures/figure15.PNG)
_Figure 15: Line Join Styles_
<a name="Figure15:Line_Join_Styles"></a>

![figure16](figures/figure16.PNG)
_Figure 16: Line Join Styles with Additional Geometry Highlighted_
<a name="Figure16:Line_Join_Styles_with_Additional_Geometry_Highlighted"></a>

#### _Miter Length_
<a name="Miter_Length"></a>
The ratio of miter length to line width may be computed directly from the angle $\theta$ between the two line segments being joined as ${ 1 }/{ \sin { \left( { \theta  }/{ 2 } \right)}}$. A number of angles with their corresponding miter limits for a line width of 1 are shown in Table 9.

| _Angle (degrees)_ | _Miter Limit_ | _Angle (degrees)_ |  _Miter Limit_ |
| :---: | :---: | :---: | :---: |
| 10 | 11.47 | 45 | 2.61 |
| 11.47 | 10 | 60 | 2 |
| 23 | 5 | 90 | 1.41 |
| 28.95 | 4 | 120 | 1.15 |
| 30 | 3.86 | 150 | 1.03 |
| 38.94 | 3 | 180 | 1 |
_Table 9: Corresponding Angles and Miter_
<a name="Table9:Corresponding_Angles_and_Miter"></a>

#### _Dashing_
<a name="Dashing"></a>
The dash pattern consists of a sequence of lengths of alternating “on” and “off” dash segments. The first value of the dash array defines the length, in user coordinates, of the first “on” dash segment. The second value defines the length of the following “off” segment. Each subsequent pair of values defines one “on” and one “off” segment.

The dash phase defines the starting point in the dash pattern that is associated with the start of the first segment of the path. For example, if the dash pattern is [ 10 20 30 40 ] and the dash phase is 35, the path will be stroked with an “on” segment of length 25 (skipping the first “on” segment of length 10, the following “off” segment of length 20, and the first 5 units of the next “on” segment), followed by an “off” segment of length 40. The pattern will then repeat from the beginning, with an “on” segment of length 10, an “off” segment of length 20, an “on” segment of length 30, etc. Figure 17 illustrates this dash pattern.

Conceptually, dashing is performed by breaking the path into a set of subpaths according to the dash pattern. Each subpath is then drawn independently using the end cap, line join style, and miter limit that were set for the path as a whole.

Dashes of length 0 are drawn only if the end cap style is `VG_CAP_ROUND` or `VG_CAP_SQUARE`. The incoming and outgoing tangents (which may differ if the dash falls at a vertex of the path) are evaluated at the point, using the **vgPointAlongPath** algorithm. The end caps are drawn using the orientation of each tangent, and a join is drawn between them if the tangent directions differ. If the end cap style is `VG_CAP_BUTT`, nothing will be drawn.

A dash, or space between dashes, with length less than 0 is treated as having a length of 0.

A negative dash phase is equivalent to the positive phase obtained by adding a suitable multiple of the dash pattern length.

![figure17](figures/figure17.PNG)
_Figure 17: Dash Pattern and Phase Example_
<a name="Figure17:Dash_Pattern_and_Phase_Example"></a>

### _8.7.4 Stroke Generation_
<a name="Stroke_Generation"></a>
The algorithm for generating a stroke is as follows. The steps described in this section conceptually take place in user coordinates, on a copy of the path being stroked in which all relative and implicit coordinates have been converted to absolute coordinates. An initial `MOVE_TO 0,0` segment is added if the path does not begin with a `MOVE_TO`.

The path to be stroked is divided into subpaths, each ending with a `MOVE_TO` or `CLOSE_PATH` segment command or with the final path segment. Subpaths consisting of only a single `MOVE_TO` segment are discarded.

A subpath consisting of a single point (_i.e_., a `MOVE_TO` segment followed by a sequence of `LINE_TO`, `QUAD_TO`, `CUBIC_TO`, and/or `ARC_TO` segments with all control points equal to the current point, possibly followed by a `CLOSE_PATH` segment) is collapsed to a lone vertex, which is marked as an END vertex (for later generation of end caps). A tangent vector of (1, 0) is used for Square end caps.

Subpaths that do not consist only of a single point have any zero-length segments removed.

If a subpath does not end with a `CLOSE_PATH` segment command, its first and last vertices are marked as END vertices. All the internal vertices that begin or end path segments within the subpath, as well as the initial/final vertex if the subpath ends with a `CLOSE_PATH` segment, are marked as JOIN vertices (for later generation of line joins).

Each subpath is processed in turn as described below until all subpaths have been stroked.

If dashing is enabled, the dash pattern and phase are used to break the subpath into a series of smaller subpaths representing the “on” portions of the dash pattern. New vertices are created at the endpoints of each dash subpath and marked as END vertices. The old subpath is discarded and replaced with the dash subpaths for the remainder of the stroke processing. The dash phase is advanced for each subsequent segment by the length of the previous segment (where `CLOSE_PATH` segments are treated as `LINE_TO`segments). If `VG_DASH_PHASE_RESET` is disabled (set to `VG_FALSE`), the final dash phase at the end of the subpath is used as the initial dash phase for the next subpath. Otherwise, the original dash phase is used for all subpaths.

For each END vertex, an end cap is created (if Square or Round end caps have been requested) using the orientation given by the tangent vector. The tangent vector is defined in the same manner as for the **vgPointAlongPath** function (see Section 8.6.11).

For each JOIN vertex, a line join is created using the orientations given by the tangent vectors of the two adjacent path segments. If Miter joins are being used, the length of the miter is computed and compared to the product of the line width and miter limit; if the miter would be too long, a Bevel join is substituted.

### _8.7.5 Setting Stroke Parameters_
<a name="Setting_Stroke_Parameters"></a>
Setting the line width of a stroke is performed using **vgSetf** with a `paramType`argument of `VG_STROKE_LINE_WIDTH`. A line width less than or equal to 0 prevents stroking from taking place.
```
VGfloat lineWidth;
vgSetf(VG_STROKE_LINE_WIDTH, lineWidth);
```

#### _VGCapStyle_
<a name="VGCapStyle"></a>
The `VGCapStyle` enumeration defines constants for the Butt, Round, and Square end cap styles:
```
typedef enum {
  VG_CAP_BUTT = 0x1700,
  VG_CAP_ROUND = 0x1701,
  VG_CAP_SQUARE = 0x1702
} VGCapStyle;
```
Setting the end cap style is performed using **vgSeti** with a `paramType` argument of `VG_STROKE_CAP_STYLE` and a value from the `VGCapStyle` enumeration.
```
VGCapStyle capStyle;
vgSeti(VG_STROKE_CAP_STYLE, capStyle);
```
#### _VGJoinStyle_
<a name="VGJoinStyle"></a>
The `VGJoinStyle` enumeration defines constants for the Miter, Round, and Bevel line join styles:
```
typedef enum {
  VG_JOIN_MITER = 0x1800,
  VG_JOIN_ROUND = 0x1801,
  VG_JOIN_BEVEL = 0x1802
} VGJoinStyle;
```
Setting the line join style is performed using **vgSeti** with a `paramType` argument of `VG_STROKE_JOIN_STYLE` and a value from the `VGJoinStyle` enum.
```
VGJoinStyle joinStyle;
vgSeti(VG_STROKE_JOIN_STYLE, joinStyle);
```
Setting the miter limit is performed using **vgSetf** with a `paramType` argument of `VG_STROKE_MITER_LIMIT`:
```
VGfloat miterLimit;
vgSetf(VG_STROKE_MITER_LIMIT, miterLimit);
```
Miter limit values less than 1 are silently clamped to 1.


#### _VG_MAX_DASH_COUNT_
<a name="VG_MAX_DASH_COUNT"></a>
The `VG_MAX_DASH_COUNT` parameter contains the maximum number of dash segments that may be supplied for the `VG_STROKE_DASH_PATTERN` parameter. All implementations must must support at least 16 dash segments (8 on/off pairs). If there is no implementation-defined limit, a value of `VG_MAXINT` may be returned. The value may be retrieved by calling **vgGeti**:
```
VGint maxDashCount = vgGeti(VG_MAX_DASH_COUNT);
```

#### _Setting the Dash Pattern_
<a name="Setting_the_Dash_Pattern"></a>
The dash pattern is set using **vgSetfv** with a `paramType` argument of `VG_STROKE_DASH_PATTERN`:
```
VGfloat dashPattern[DASH_COUNT];
VGint count = DASH_COUNT;
vgSetfv(VG_STROKE_DASH_PATTERN, count, dashPattern);
```
Dashing may be disabled by calling **vgSetfv** with a `count` of 0:
```
vgSetfv(VG_STROKE_DASH_PATTERN, 0, NULL);
```
The dash phase is set using **vgSetf** with a `paramType` argument of `VG_STROKE_DASH_PHASE`. The resetting behavior of the dash phase when advancing to a new subpath is set using **vgSeti** with a `paramType` argument of `VG_STROKE_DASH_PHASE_RESET`:
```
VGfloat dashPhase;
VGboolean dashPhaseReset;
vgSetf(VG_STROKE_DASH_PHASE, dashPhase);
vgSeti(VG_STROKE_DASH_PHASE_RESET, dashPhaseReset);
```
If the dash pattern has length 0, dashing is not performed. If the dash pattern has an odd number of elements, the final element is ignored. Note that this behavior is different from that defined by SVG; the SVG behavior may be implemented by duplicating the oddlength dash pattern to obtain one with even length.

If more than `VG_MAX_DASH_COUNT` dashes are specified, those beyond the first `VG_MAX_DASH_COUNT` are discarded immediately (and will not be returned by **vgGet**).

### _8.7.6 Non-Scaling Strokes_
<a name="Non-Scaling_Strokes"></a>
In some cases, applications may wish stroked geometry to appear with a particular stroke width in the surface coordinate system, independent of the current user-to-surface transformation. For example, a stroke representing a road on a map might stay the same width as the user zooms in and out of the map, since the stroke width is intended to indicate the type of road (_e.g_., one-way street, divided road, interstate highway or Autobahn) rather than its true width on the ground.

OpenVG does not provide direct support for this “non-scaling stroke” behavior. However, the behavior may be obtained relatively simply using a combination of features.

If the current user-to-surface transformation consists only of uniform scaling, rotation, and translation (_i.e_., no shearing or non-uniform scaling), then the stroke width may be set to the desired stroke width in drawing surface coordinates, divided by the scaling factor introduced by the transformation. This scaling factor may be known to the application _a priori_, or else it may be computed as the square root of the absolute value of the determinant $\left( sx\ast sy-shx\ast shy \right)$ of the user-to-surface transformation.

If the user-to-surface transformation includes shearing or non-uniform scaling, the geometry to be stroked must be transformed into surface coordinates prior to stroking. The paint transformation must also be set to the concatenation of the paint-to-user and user-to-surface transformations in order to allow correct painting of the stroked geometry. The following code illustrates this technique:
```
VGPath srcPath; /* Path to be drawn with non-scaling stroke */
VGPath dstPath; /* Path in drawing surface coordinates */
VGfloat strokePaintToUser[9]; /* Paint-to-user transformation */
VGfloat pathUserToSurface[9]; /* User-to-surface transformation */

/* Transform the geometry into surface coordinates. */
vgSeti(VG_MATRIX_MODE, VG_MATRIX_PATH_USER_TO_SURFACE);
vgLoadMatrix(pathUserToSurface);
vgTransformPath(dstPath, srcPath);

/* Use the identity matrix for drawing the stroked path. */
vgLoadIdentity();

/* Set the paint transformation to the concatenation of the
 * paint-to-user and user-to-surface transformations.
 */
vgSeti(VG_MATRIX_MODE, VG_MATRIX_FILL_PAINT_TO_USER);
vgLoadMatrix(pathUserToSurface);
vgMultMatrix(strokePaintToUser);

/* Stroke the transformed path. */
vgDrawPath(dstPath, VG_STROKE_PATH);
```

## _8.8 Filling or Stroking a Path_
<a name="Filling_or_Stroking_a_Path"></a>
#### _VGFillRule_
<a name="VGFillRule"></a>
The `VGFillRule` enumeration defines constants for the even/odd and non-zero fill rules.
```
typedef enum {
  VG_EVEN_ODD = 0x1900,
  VG_NON_ZERO = 0x1901
} VGFillRule;
```
To set the rule for filling, call **vgSeti** with a `type` parameter value of `VG_FILL_RULE` and a `value` parameter defined using a value from the `VGFillRule` enumeration. When the path is filled, the most recent setting of the fill rule on the current context is used. The fill rule setting has no effect on stroking.
```
VGFillRule fillRule;
vgSeti(VG_FILL_RULE, fillRule);
```
#### _VGPaintMode_
<a name="VGPaintMode"></a>
The `VGPaintMode` enumeration defines constants for stroking and filling paths, to be used by the **vgDrawPath**, **vgSetPaint**, and **vgGetPaint** functions.
```
typedef enum {
  VG_STROKE_PATH = (1 << 0),
  VG_FILL_PATH   = (1 << 1)
} VGPaintMode;
```
#### _vgDrawPath_
<a name="vgDrawPath"></a>
Filling and stroking are performed by the **vgDrawPath** function. The `paintModes` argument is a bitwise OR of values from the `VGPaintMode` enumeration, determining whether the path is to be filled (`VG_FILL_PATH`), stroked (`VG_STROKE_PATH`), or both (`VG_FILL_PATH` | `VG_STROKE_PATH`). If both filling and stroking are to be performed, the path is first filled, then stroked.
```
void vgDrawPath(VGPath path, VGbitfield paintModes)
```

> **_ERRORS_**
>
> `VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if `paintModes` is not a valid bitwise OR of values from the `VGPaintMode` enumeration

#### _Filling a Path_
<a name="Filling_a_Path"></a>
Calling **vgDrawPath** with a `paintModes` argument of `VG_FILL_PATH` causes the given path to be filled, using the paint defined for the `VG_FILL_PATH` paint mode and the current fill rule.

The matrix currently set for the `VG_MATRIX_FILL_PAINT_TO_USER` matrix mode is applied to the paint used to fill the path outline. The matrix currently set for the `VG_MATRIX_PATH_USER_TO_SURFACE` matrix mode is used to transform the outline of the path and the paint into surface coordinates.
```
vgDrawPath(VGPath path, VG_FILL_PATH);
```

#### _Stroking a Path_
<a name="Stroking_a_Path"></a>
Calling **vgDrawPath** with a `paintModes` argument of `VG_STROKE_PATH` causes the given path to be stroked, using the paint defined for the `VG_STROKE_PATH` paint mode and the current set of stroke parameters.

The matrix currently set for the `VG_MATRIX_STROKE_PAINT_TO_USER` matrix mode is applied to the paint used to fill the stroked path outline. The matrix currently set for the `VG_MATRIX_PATH_USER_TO_SURFACE` matrix mode is used to transform the outline of the stroked path and the paint into surface coordinates.
```
vgDrawPath(VGPath path, VG_STROKE_PATH);
```
The following code sample shows how an application might set stroke parameters using variants of **vgSet**, and stroke a path object (defined elsewhere):
```
VGPath path;

/* Set the line width to 2.5 */
vgSetf(VG_STROKE_LINE_WIDTH, 2.5f);
/* Set the miter limit to 10.5 */
vgSetf(VG_STROKE_MITER_LIMIT, 10.5f);
/* Set the cap style to CAP_SQUARE */
vgSeti(VG_STROKE_CAP_STYLE, VG_CAP_SQUARE);
/* Set the join style to JOIN_MITER */
vgSeti(VG_STROKE_JOIN_STYLE, VG_JOIN_MITER);

/* Set the dash pattern */
VGfloat dashes[] = { 1.0f, 2.0f, 2.0f, 2.0f };
vgSetfv(VG_STROKE_DASH_PATTERN, 4, dashes);

/* Set the dash phase to 0.5 and reset it for every subpath */
vgSetf(VG_STROKE_DASH_PHASE, 0.5f);
vgSeti(VG_STROKE_DASH_PHASE_RESET, VG_TRUE);

/* Stroke the path */
vgDrawPath(path, VG_STROKE_PATH);
```

#### _Filling and Stroking a Path_
<a name="Filling_and_Stroking_a_Path"></a>
Calling **vgDrawPath** with a `paintModes` argument of (`VG_FILL_PATH` | `VG_STROKE_PATH`) causes the given path to be first filled, then stroked, exactly as if **vgDrawPath** were called twice in succession, first with a `paintModes` argument of `VG_FILL_PATH` and second with a `paintModes` argument of `VG_STROKE_PATH`.
```
vgDrawPath(VGPath path, VG_FILL_PATH | VG_STROKE_PATH);
```

In this section, we define the standard data format for paths that may be used to definesequences of various types of path segments. Extensions may define other path data formats.


#### VG_PATH_FORMAT_STANDARD
<a name="VG_PATH_FORMAT_STANDARD"></a>

The `VG_PATH_FORMAT_STANDARD `macro defines a constant to be used as an argument to **vgCreatePath** to indicate that path data are stored using the standard format. As this API is revised, the lower 16 bits of version number may increase. Each version of OpenVG will accept formats defined in all prior specification versions with which it is backwards-compatible.

Extensions wishing to define additional path formats may register for format identifiers that will differ in their upper 16 bits;the lower 16 bits may be used by the extension vendor for versioning purposes.

```
#define VG_PATH_FORMAT_STANDARD 0;
```

### 8.5.1 Path Segment Command Side Effects
<a name="Path Segment Command Side Effects"></a>

In order to define the semantics of each segment command type, we define three reference points (all are initially (0, 0)):

• *(sx, sy)*: the beginning of the current subpath,*i*.*e*., the position of the last ``MOVE_TO`` segment.

• $(ox, oy)$: the last point of the previous segment.

• $(px, py)$: the last internal control point of the previous segment, if the segment was a (regular or smooth) quadratic or cubic Bézier, or else the last point of the previous segment.

Figure 6 illustrates the locations of these points at the end of a sequence of segment commands ``{ `MOVE_TO`, LINE_TO, CUBIC_TO }``.

<img src="figures/Figure 6.PNG"/>

*Figure 6: Segment Reference Points*

We define points *(x0, y0)*, *(x1, y1)*, and *(x2, y2)* in the discussion below as absolute coordinates. For segments defined using relative coordinates, *(x0, y0)*, etc., are defined as the incoming coordinate values added to $(ox, oy)$. Ellipse rh, rv, and rot parameters are unaffected by the use of relative coordinates. Each segment (except for `MOVE_TO` segments) begins at the point $(ox, oy)$ defined by the previous segment.

A path consists of a sequence of subpaths. As path segment commands are encountered, each segment is appended to the current subpath. The current subpath is ended by a `MOVE_TO` or `CLOSE_PATH` segment, and a new current subpath is begun. The end of the path data also ends the current subpath.

### 8.5.2 Segment Commands
<a name="Segment Commands"></a>

The following table describes each segment command type along with its prefix, the number of specified coordinates and parameters it requires, the numerical value of the segment command, the formulas for any implicit coordinates, and the side effects of the segment command on the points $(ox, oy)$, *(sx, sy)*, and $(px, py)$ and on the termination of the current subpath.

_**Type**_ | _**VGPathSegment**_ | _**Coordinates**_ | _**Value**_ | _**Implicit Points**_ | _**Side Effects**_
---- | ------------- | ----------- | ----- | --------------- | ------------
Close Path| `CLOSE_PATH` | *none* | 0 | | *(px,py)=(ox,oy)=(sx,sy)* End current subpath
Move|`MOVE_TO`|*x0,y0*|2||*(sx,sy)=(px,py)=(ox,oy)=(x0,y0)* End current subpath
Line|`LINE_TO`|*x0,y0*|4||*(px,py)=(ox,oy)=(x0,y0)*
Horiz Line|`HLINE_TO`|*x0*|6|*y0=oy*|*(px,py)=(x0,oy) ox=x0*
Vertical Line|`VLINE_TO`|*y0*|8|*x0=ox*|*(px,py)=(ox,y0) oy=y0*
Quadratic|`QUAD_TO`|*x0,y0,x1,y1*|10||*(px,py)=(x0,y0) (ox,oy)=(x1,y1)*
Cubic|`CUBIC_TO`|*x0,y0,x1,y1,x2,y2*|12||*(px,py)=(x1,y1) (ox,oy)=(x2,y2)*
G1 Smooth Quad|`SQUAD_TO`|*x1,y1*|14|*(x0,y0)=(2*ox-px,2*oy-py)*|*(px,py)= (2*ox-px, 2*oy-py) (ox,oy)=(x1,y1)*
G1 Smooth Cubic|`SCUBIC_TO`|*x1,y1,x2,y2*|16|*(x0,y0)=(2*ox-px,2*oy-py)*|*(px,py)=(x1,y1) (ox,oy)=(x2,y2)*
Small CCW Arc|`SCCWARC_TO|*rh,rv,rot,x0,y0*|18||*(px,py)=(ox,oy)=(x0,y0)*
Small CW Arc|`SCWARC_TO|*rh,rv,rot,x0,y0*|20||*(px,py)=(ox,oy)=(x0,y0)*
Large CCW|`LCCWARC_TO|*rh,rv,rot,x0,y0*|22||*(px,py)=(ox,oy)=(x0,y0)*
Arc|||||
Large CW Arc|`LCWARC_TO`|*rh,rv,rot,x0,y0*|24||*(px,py)=(ox,oy)=(x0,y0)*
Reserved|Reserved||26,28,30||

*Table 6: Path Segment Commands*

Each segment type may be defined using either absolute or relative coordinates. A relative coordinate $(x, y)$ is added to $(ox, oy)$ to obtain the corresponding absolute coordinate $(ox + x, oy + y)$. Relative coordinates are converted to absolute coordinates immediately as each segment is encountered during rendering.

The `HLINE_TO` and `VLINE_TO` segment types are provided in order to avoid the need for an SVG viewing application (for example) to perform its own relative to absolute conversions when parsing path data.

In SVG, the behavior of smooth quadratic and cubic segments differs slightly from the behavior defined above. If a smooth quadratic segment does not follow a quadratic segment, or a smooth cubic segment does not follow a cubic segment, the initial control point $(x0, y0)$ is placed at $(ox, oy)$ instead of being computed as the reflection of $(px, py)$.This behavior may be emulated by converting an SVG smooth segment into a regular segment with all of its control points specified when the preceding segment is of a different degree.

Note that the coordinates of a path are defined even if the path begins with a segment type other than `MOVE_TO` (including `HLINE_TO`, `VLINE_TO`, or relative segment types) since the coordinates are based on the initial values of $(ox, oy)$, $(sx, sy)$, and *(px, py)* which are each defined as (0, 0).

### 8.5.3 Coordinate Data Formats
<a name="Coordinate Data Formats"></a>

Coordinate and parameter data (henceforth called simply coordinate data) may be expressed in the set of formats shown in Table 7 below. Multi-byte coordinate data (*i*.*e*., `S_16`, `S_32` and F datatypes) are represented in application memory using the native byte order (endianness) of the platform. Implementations may quantize incoming data in the `S_32` and F formats to a lesser number of bits, provided at least 16 bits of precision are maintained.

Judicious use of smooth curve segments and 8- and 16-bit datatypes can result in substantial memory savings for common path data, such as font glyphs. Using smaller datatypes also conserves bus bandwidth when transferring paths from application memory to OpenVG.

_**Datatype**_|`VG_PATH_DATATYPE` _**Suffix**_|_**bytes**_|_**Value**_
--------------|-------------------------------|-----------|-----------
8-bit signed integer|S_8|1|0
16-bit signed integer|S_16|2|1
32-bit signed integer|S_32|4|2
IEEE 754 floating-point|F|4|3

*Table 7: Path Coordinate Datatypes*

#### VGPathDatatype
<a name="VGPathDatatype"></a>

The `VGPathDatatype` enumeration defines values describing the possible numerical datatypes for path coordinate data.

```
typedef enum {
VG_PATH_DATATYPE_S_8 = 0,
VG_PATH_DATATYPE_S_16 = 1,
VG_PATH_DATATYPE_S_32 = 2,
VG_PATH_DATATYPE_F = 3
} VGPathDatatype;
```

###8.5.4 Segment Type Marker Definitions

Segment type markers are defined as 8-bit integers, with the leading 3 bits reserved for future use, the next 4 bits containing the segment command type, and the least significant bit indicating absolute vs. relative coordinates (0 for absolute, 1 for relative). The reserved bits must be set to 0.

For the `CLOSE_PATH` segment command, the value of the Abs/Rel bit is ignored.

<img src="figures/Figure 7.PNG"/>

*Figure 7: Segment Type Marker Layout*

#### VGPathAbsRel
<a name=" VGPathAbsRel"></a>

The `VGPathAbsRel` enumeration defines values indicating absolute (`VG_ABSOLUTE`) and relative (`VG_RELATIVE`) values.

```
typedef enum {
VG_ABSOLUTE = 0,
VG_RELATIVE = 1
} VGPathAbsRel;
```

#### VGPathSegment
<a name="VGPathSegment"></a>

The `VGPathSegment` enumeration defines values for each segment command type. The values are pre-shifted by 1 bit to allow them to be combined easily with values from `VGPathAbsRel`.

```
typedef enum {
VG_CLOSE_PATH = ( 0 << 1),
VG_MOVE_TO = ( 1 << 1),
VG_LINE_TO = ( 2 << 1),
VG_HLINE_TO = ( 3 << 1),
VG_VLINE_TO = ( 4 << 1),
VG_QUAD_TO = ( 5 << 1),
VG_CUBIC_TO = ( 6 << 1),
VG_SQUAD_TO = ( 7 << 1),
VG_SCUBIC_TO = ( 8 << 1),
VG_SCCWARC_TO = ( 9 << 1),
VG_SCWARC_TO = (10 << 1),
VG_LCCWARC_TO = (11 << 1),
VG_LCWARC_TO = (12 << 1)
} VGPathSegment;
```
#### VGPathCommand
<a name="VGPathCommand"></a>

The `VGPathCommand` enumeration defines combined values for each segment command type and absolute/relative value. The values are shifted left by one bit and ORed bitwise (*i*.*e*., using the C | operator) with the appropriate value from `VGPathAbsRel` to obtain a complete segment command value.

```
typedef enum {
VG_MOVE_TO_ABS = VG_MOVE_TO | VG_ABSOLUTE,
VG_MOVE_TO_REL = VG_MOVE_TO | VG_RELATIVE,
VG_LINE_TO_ABS = VG_LINE_TO | VG_ABSOLUTE,
VG_LINE_TO_REL = VG_LINE_TO | VG_RELATIVE,
VG_HLINE_TO_ABS = VG_HLINE_TO | VG_ABSOLUTE,
VG_HLINE_TO_REL = VG_HLINE_TO | VG_RELATIVE,
VG_VLINE_TO_ABS = VG_VLINE_TO | VG_ABSOLUTE,
VG_VLINE_TO_REL = VG_VLINE_TO | VG_RELATIVE,
VG_QUAD_TO_ABS = VG_QUAD_TO | VG_ABSOLUTE,
VG_QUAD_TO_REL = VG_QUAD_TO | VG_RELATIVE,
VG_CUBIC_TO_ABS = VG_CUBIC_TO | VG_ABSOLUTE,
VG_CUBIC_TO_REL = VG_CUBIC_TO | VG_RELATIVE,
VG_SQUAD_TO_ABS = VG_SQUAD_TO | VG_ABSOLUTE,
VG_SQUAD_TO_REL = VG_SQUAD_TO | VG_RELATIVE,
VG_SCUBIC_TO_ABS = VG_SCUBIC_TO | VG_ABSOLUTE,
VG_SCUBIC_TO_REL = VG_SCUBIC_TO | VG_RELATIVE,
VG_SCCWARC_TO_ABS = VG_SCCWARC_TO | VG_ABSOLUTE,
VG_SCCWARC_TO_REL = VG_SCCWARC_TO | VG_RELATIVE,
VG_SCWARC_TO_ABS = VG_SCWARC_TO | VG_ABSOLUTE,
VG_SCWARC_TO_REL = VG_SCWARC_TO | VG_RELATIVE,
VG_LCCWARC_TO_ABS = VG_LCCWARC_TO | VG_ABSOLUTE,
VG_LCCWARC_TO_REL = VG_LCCWARC_TO | VG_RELATIVE,
VG_LCWARC_TO_ABS = VG_LCWARC_TO | VG_ABSOLUTE,
VG_LCWARC_TO_REL = VG_LCWARC_TO | VG_RELATIVE
} VGPathCommand;

```

### 8.5.5 Path Example
<a name="Path Example"></a>

The following code example shows how to traverse path data stored in application memory using the standard representation. A byte is read containing a segment command, and the segment command type and relative/absolute flag are extracted by application-defined `SEGMENT_COMMAND` and `SEGMENT_ABS_REL` macros. The number of coordinates and number of bytes per coordinate (for the given data format) are also determined using lookup tables. Finally, the relevant portion of the path data stream representing the current segment is copied into a temporary buffer and used as an argument to a user-defined **processSegment** function that may perform further processing.

```
#define PATH_MAX_COORDS 6 /* Maximum number of coordinates/command */
#define PATH_MAX_BYTES 4 /* Bytes in largest data type */
#define SEGMENT_COMMAND(command) /* Extract segment type */ \
((command) & 0x1e)
#define SEGMENT_ABS_REL(command) /* Extract absolute/relative bit */ \
((command) & 0x1)
/* Number of coordinates for each command */
static const VGint numCoords[] = {0,2,2,1,1,4,6,2,4,5,5,5,5};
/* Number of bytes for each datatype */
static const VGint numBytes[] = {1,2,4,4};
/* User-defined function to process a single segment */
extern void
processSegment(VGPathSegment command, VGPathAbsRel absRel,
VGPathDatatype datatype,
void * segmentData);
/* Process a path in the standard format, one segment at a time. */
void
processPath(const VGubyte * pathSegments, const void * pathData,
int numSegments, VGPathDatatype datatype)
{
VGubyte segmentType, segmentData[PATH_MAX_COORDS*PATH_MAX_BYTES];
VGint segIdx = 0, dataIdx = 0;
VGint command, absRel, numBytes;
while (segIdx < numSegments) {
segmentType = pathSegments[segIdx++];
command = SEGMENT_COMMAND(segmentType);
absRel = SEGMENT_ABS_REL(segmentType);
numBytes = numCoords[command]*numBytes[datatype];
/* Copy segment data for further processing */
memcpy(segmentData, &pathData[dataIdx], numBytes);
/* Process command */
processSegment(command, absRel, datatype, (void *) segmentData);
dataIdx += numBytes;
}
}
```

## 8.6 Path Operations
<a name="Path Operations"></a>

In addition to filling or stroking a path, the API allows the following basic operations on paths:

• Create a path with a given set of capabilities (**vgCreatePath**)

• Remove data from a path (**vgClearPath**)

• Deallocate a path (**vgDestroyPath**)

• Query path information (**using vgGetParameter**)

• Query the set of capabilities for a path (**vgGetPathCapabilities**)

• Reduce the set of capabilities for a path (**vgRemovePathCapabilities**)

• Append data from one path onto another (**vgAppendPath**)

• Append data onto a path (**vgAppendPathData**)

• Modify coordinates stored in a path (**vgModifyPathCoords**)

• Transform a path (**vgTransformPath**)

• Interpolate between two paths (**vgInterpolatePath**)

• Determine the geometrical length of a path (**vgPathLength**)

• Get position and tangent information for a point at a given geometric distance
along path (**vgPointAlongPath**)

• Get an axis-aligned bounding box for a path (**vgPathBounds**,
**vgTransformedPathBounds**)

Higher-level geometric primitives are defined in the optional `VGU` utility library (see
Section 17):

• Append a line to a path (**vguLine**)

• Append a polyline (connected sequence of line segments) or polygon to a
path (**vguPolygon**)

• Append a rectangle to a path (**vguRect**)

• Append a round-cornered rectangle to a path (**vguRoundRect**)

• Append an ellipse to a path (**vguEllipse**)

• Append a circular arc to a path (**vguArc**)

### 8.6.1 Storage of Paths
<a name="Storage of Paths"></a>

OpenVG stores path data internally to the implementation. Paths are referenced via opaque VGPath handles. Applications may initialize paths using the memory representation defined above or other representations defined by extensions. It is possible for an implementation to store path data in hardware-accelerated memory. Implementations may also make use of their own internal representation of path segments. The intent is for applications to be able to define a set of paths, for example one for each glyph in the current typeface, and to be able to re-render each previously defined path with maximum efficiency.

#### VGPath
<a name="VGPath"></a>

`VGPath` represents an opaque handle to a path.

```
typedef VGHandle VGPath;
```

### 8.6.2 Creating and Destroying Paths
<a name="Creating and Destroying Paths"></a>

Paths are created and destroyed using the **vgCreatePath** and **vgDestroyPath** functions. During the lifetime of a path, an application may indicate which path operations it plans to perform using path capability flags defined by the `VGPathCapabilities` enumeration.

#### _**VGPathCapabilities**_
<a name="VGPathCapabilities"></a>

The `VGPathCapabilities` enumeration defines a set of constants specifying which operations may be performed on a given path object. At the time a path is defined, the application specifies which operations it wishes to be able to perform on the path. Over time, the application may disable previously enabled capabilities, but it may not reenable capabilities once they have been disabled. This feature allows OpenVG implementations to make use of internal path representations that may not support all path operations, possibly resulting in higher performance on paths where those operations will not be performed.

The capability bits and the functionality they allow are described below:

• `VG_PATH_CAPABILITY_APPEND_FROM` – use path as the 'srcPath' argument to **vgAppendPath**

• `VG_PATH_CAPABILITY_APPEND_TO` – use path as the 'dstPath' argument to **vgAppendPath** and **vgAppendPathData**

• `VG_PATH_CAPABILITY_MODIFY` – use path as the 'dstPath' argument to **vgModifyPathCoords**

•`VG_PATH_CAPABILITY_TRANSFORM_FROM` – use path as the 'srcPath argument to **vgTransformPath**

• `VG_PATH_CAPABILITY_TRANSFORM_TO` – use path as the 'dstPath' argument to **vgTransformPath**

• `VG_PATH_CAPABILITY_INTERPOLATE_FROM` – use path as the `startPath` or `endPath` argument to **vgInterpolatePath**

• `VG_PATH_CAPABILITY_INTERPOLATE_TO` – use path as the `dstPath` argument to **vgInterpolatePath**

• `VG_PATH_CAPABILITY_PATH_LENGTH` – use path as the `path` argument to **vgPathLength**

• `VG_PATH_CAPABILITY_POINT_ALONG_PATH` – use path as the `path` argument to **vgPointAlongPath**

• `VG_PATH_CAPABILITY_TANGENT_ALONG_PATH` – use path as the `path` argument to **vgPointAlongPath** with non-`NULL tangentX` and `tangentY` arguments

• `VG_PATH_CAPABILITY_PATH_BOUNDS` – use path as the `path` argument to **vgPathBounds**

• `VG_PATH_CAPABILITY_PATH_TRANSFORMED_BOUNDS` – use path as the `path` argument to **vgPathTransformedBounds**

• `VG_PATH_CAPABILITY_ALL` – a bitwise OR of all the defined path capabilities

```
typedef enum {
VG_PATH_CAPABILITY_APPEND_FROM = (1 << 0),
VG_PATH_CAPABILITY_APPEND_TO = (1 << 1),
VG_PATH_CAPABILITY_MODIFY = (1 << 2),
VG_PATH_CAPABILITY_TRANSFORM_FROM = (1 << 3),
VG_PATH_CAPABILITY_TRANSFORM_TO = (1 << 4),
VG_PATH_CAPABILITY_INTERPOLATE_FROM = (1 << 5),
VG_PATH_CAPABILITY_INTERPOLATE_TO = (1 << 6),
VG_PATH_CAPABILITY_PATH_LENGTH = (1 << 7),
VG_PATH_CAPABILITY_POINT_ALONG_PATH = (1 << 8),
VG_PATH_CAPABILITY_TANGENT_ALONG_PATH = (1 << 9),
VG_PATH_CAPABILITY_PATH_BOUNDS = (1 << 10),
VG_PATH_CAPABILITY_PATH_TRANSFORMED_BOUNDS = (1 << 11),
VG_PATH_CAPABILITY_ALL = (1 << 12) - 1
} VGPathCapabilities;
```

It is legal to call **vgCreatePath**, **vgClearPath**, and **vgDestroyPath** regardless of the current setting of the path’s capability bits, as these functions discard the existing path definition.

#### vgCreatePath
<a name="vgCreatePath"></a>

**vgCreatePath** creates a new path that is ready to accept segment data and returns a `VGPath` handle to it. The path data will be formatted in the format given by `pathFormat`, typically `VG_PATH_FORMAT_STANDARD`. The `datatype` parameter contains a value from the `VGPathDatatype` enumeration indicating the datatype that will be used for coordinate data. The `capabilities` argument is a bitwise OR of the desired `VGPathCapabilities` values. Bits of `capabilities` that do not correspond to values from `VGPathCapabilities` have no effect. If an error occurs, `VG_INVALID_HANDLE` is returned.


The `scale` and `bias` parameters are used to interpret each coordinate of the path data; an incoming coordinate value *v* will be interpreted as the value *(scale*v* + *bias*). `scale` must not equal 0. The datatype, scale, and bias together define a valid coordinate data range for the path; segment commands that attempt to place a coordinate in the path that is outside this range will overflow silently, resulting in an undefined coordinate value. Functions that query a path containing such values, such as **vgPathLength** and **vgPointAlongPath**, also return undefined results.

The `segmentCapacityHint` parameter provides a hint as to the total number of segments that will eventually be stored in the path. The `coordCapacityHint` parameter provides a hint as to the total number of specified coordinates (as defined in the “Coordinates” column of Table 6) that will eventually be stored in the path. A value less than or equal to 0 for either hint indicates that the capacity is unknown. The path storage space will in any case grow as needed, regardless of the hint values. However, supplying hints may improve performance by reducing the need to allocate additional space as the path grows. Implementations should allow applications to append segments and coordinates up to the stated capacity in small batches without degrading performance due to excessive memory reallocation.

```
VGPath vgCreatePath(VGint pathFormat,
VGPathDatatype datatype,
VGfloat scale, VGfloat bias,
VGint segmentCapacityHint,
VGint coordCapacityHint,
VGbitfield capabilities)
```

> **_ERRORS_**
>
> `VG_UNSUPPORTED_PATH_FORMAT_ERROR`
> * if `pathFormat` is not a supported format `VG_ILLEGAL_ARGUMENT_ERROR`
> * if `datatype` is not a valid value from the `VGPathDatatype` enumeration
> * if `scale` is equal to 0

#### vgClearPath
<a name="vgClearPath"></a>

**vgClearPath** removes all segment command and coordinate data associated with a path. The handle continues to be valid for use in the future, and the path format and datatype retain their existing values. The `capabilities` argument is a bitwise OR of the desired VGPathCapabilities values. Bits of `capabilities` that do not correspond to values from `VGPathCapabilities` have no effect. Using **vgClearPath** may be more efficient than destroying and re-creating a path for short-lived paths.

```
void vgClearPath(VGPath path, VGbitfield capabilities)
```
> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context

#### vgDestroyPath
<a name=" vgDestroyPath"></a>

**vgDestroyPath** releases any resources associated with `path`, and makes the handle invalid in all contexts that shared it.

```
void vgDestroyPath(VGPath path)
```
> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context

### 8.6.3 Path Queries
<a name="Path Queries"></a>

#### VGPathParamType
<a name="VGPathParamType"></a>

Values from the `VGPathParamType` enumeration may be used as the `paramType` argument to **vgGetParameter** to query various features of a path. All of the parameters defined by `VGPathParamType` are read-only. Table 8 shows the datatypes for each parameter type.

```
typedef enum {
VG_PATH_FORMAT = 0x1600,
VG_PATH_DATATYPE = 0x1601,
VG_PATH_SCALE = 0x1602,
VG_PATH_BIAS = 0x1603,
VG_PATH_NUM_SEGMENTS = 0x1604,
VG_PATH_NUM_COORDS = 0x1605
} VGPathParamType;
```

_**Parameter**_ | _**Datatype**_
--------------- | --------------
VG_PATH_FORMAT|VGint
VG_PATH_DATATYPE|VGint
VG_PATH_SCALE|VGfloat
VG_PATH_BIAS|VGfloat
VG_PATH_NUM_SEGMENTS|VGint
VG_PATH_NUM_COORDS|VGint

*Table 8: VGPathParamType Datatypes*

#### Path Format
<a name="Path Format"></a>

The command format of a path is queried as an integer value using the `VG_PATH_FORMAT` parameter:

```
VGPath path;
VGint pathFormat = vgGetParameteri(path, VG_PATH_FORMAT);
```


#### Path Datatype
<a name="Path Datatypet"></a>

The coordinate datatype of a path is queried as an integer value using the `VG_PATH_DATATYPE` parameter. The returned integral value should be cast to the `VGPathDatatype` enumeration:

```
GPath path;
VGPathDatatype pathDatatype =
(VGPathDatatype)vgGetParameteri(path, VG_PATH_DATATYPE);
```

#### Path Scale
<a name="Path Scale"></a>

The scale factor of the path is queried as a floating-point value using the `VG_PATH_SCALE` parameter:
```
VGPath path;
VGfloat pathScale = vgGetParameterf(path, VG_PATH_SCALE);
```
#### Path Bias
<a name="Path Bias"></a>

The bias of the path is queried as a floating-point value using the `VG_PATH_BIAS` parameter:

```
VGPath path;
VGfloat pathBias = vgGetParameterf(path, VG_PATH_BIAS);
```

#### Number of Segments
<a name="Number of Segments"></a>

The number of segments stored in the path is queried as an integer value using the `VG_PATH_NUM_SEGMENTS` parameter:
```
VGPath path;
VGint pathNumSegments = vgGetParameteri(path, VG_PATH_NUM_SEGMENTS);
```
#### Number of Coordinates
<a name="Number of Coordinates"></a>

The total number of specified coordinates (*i*.*e*., those defined in the “Coordinates” column of Table 6) stored in the path is queried as an integer value using the `VG_PATH_NUM_COORDS` parameter:
```
VGPath path;
VGint pathNumCoords = vgGetParameteri(path, VG_PATH_NUM_COORDS);
```

### 8.6.4 Querying and Modifying Path Capabilities
<a name="Querying and Modifying Path Capabilities"></a>

#### vgGetPathCapabilities
<a name="vgGetPathCapabilities"></a>

The **vgGetPathCapabilities** function returns the current capabilities of the `path`, as a bitwise OR of `VGPathCapabilities` constants. If an error occurs, 0 is returned.

```
VGbitfield vgGetPathCapabilities(VGPath path)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context

#### vgRemovePathCapabilities
<a name="vgRemovePathCapabilities"></a>

The **vgRemovePathCapabilities** function requests the set of capabilities specified in the `capabilities` argument to be disabled for the given `path`. The `capabilities` argument is a bitwise OR of the `VGPathCapabilities` values whose removal is requested. Attempting to remove a capability that is already disabled has no effect. Bits of `capabilities` that do not correspond to values from `VGPathCapabilities` have no effect.


An implementation may choose to ignore the request to remove a particular capability if no significant performance improvement would result. In this case, **vgGetPathCapabilities** will continue to report the capability as enabled.
```
void vgRemovePathCapabilities(VGPath path, VGbitfield capabilities)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context

### 8.6.5 Copying Data Between Paths
<a name="Copying Data Between Paths"></a>

#### vgAppendPath
<a name="vgAppendPath"></a>

**vgAppendPath** appends a copy of all path segments from `srcPath` onto the end of the existing data in `dstPath`. It is legal for `srcPath` and `dstPath` to be handles to the same path object, in which case the contents of the path are duplicated. If `srcPath` and `dstPath` are handles to distinct path objects, the contents of srcPath will not be affected by the call.

The `VG_PATH_CAPABILITY_APPEND_FROM` capability must be enabled for `srcPath`, and the `VG_PATH_CAPABILITY_APPEND_TO` capability must be enabled for `dstPath`.


If the scale and bias of `dstPath` define a narrower range than that of `srcPath`, overflow may occur silently.
```
void vgAppendPath(VGPath dstPath, VGPath srcPath)
```
> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if either `dstPath` or `srcPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> if `VG_PATH_CAPABILITY_APPEND_FROM` is not enabled for srcPath
> if `VG_PATH_CAPABILITY_APPEND_TO` is not enabled for dstPath

### 8.6.6 Appending Data to a Path
<a name=" Appending Data to a Path"></a>

#### vgAppendPathData
<a name="vgAppendPathData"></a>

**vgAppendPathData** appends data taken from `pathData` to the given path `dstPath`. The data are formatted using the path format of `dstPath` (as returned by querying the path’s `VG_PATH_FORMAT` parameter using **vgGetParameteri**). The `numSegments` parameter gives the total number of entries in the `pathSegments` array, and must be greater than 0. Legal values for the **pathSegments** array are the values from the `VGPathCommand` enumeration as well as `VG_CLOSE_PATH` and (`VG_CLOSE_PATH` | `VG_RELATIVE`) (which are synonymous).

The `pathData` pointer must be aligned on a 1-, 2-, or 4-byte boundary (as defined in the “Bytes” column of Table 7) depending on the size of the coordinate datatype (as returned by querying the path’s `VG_PATH_DATATYPE` parameter using **vgGetParameteri**). The `VG_PATH_CAPABILITY_APPEND_TO` capability must be enabled for `path`.

Each incoming coordinate value, regardless of datatype, is transformed by the scale
factor and bias of the path.

```
void vgAppendPathData(VGPath dstPath,
VGint numSegments,
const VGubyte * pathSegments,
const void * pathData)
```
> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `dstPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> * if `VG_PATH_CAPABILITY_APPEND_TO` is not enabled for dstPath `VG_ILLEGAL_ARGUMENT_ERROR`
> * if `pathSegments` or `pathData` is `NULL`
> * if `pathData` is not properly aligned
> * if `numSegments` is less than or equal to 0
> * if `pathSegments` contains an illegal command

### 8.6.7 Modifying Path Data
<a name=" Modifying Path Data"></a>

Coordinate data in an existing path may be modified, for example to create animation
effects. Implementations should choose an internal representation for paths that have the `VG_PATH_CAPABILITY_MODIFY` capability enabled that allows for efficient modification of the coordinate data.

#### vgModifyPathCoords
<a name="vgModifyPathCoords"></a>

**vgModifyPathCoords** modifies the coordinate data for a contiguous range of segments of `dstPath`, starting at `startIndex` (where 0 is the index of the first path segment) and having length `numSegments`. The data in `pathData` must be formatted in exactly the same manner as the original coordinate data for the given segment range, unless the path has been transformed using **vgTransformPath** or interpolated using **vgInterpolatePath**. In these cases, the path will have been subject to the segment promotion rules specified in those functions.

The `pathData` pointer must be aligned on a 1-, 2-, or 4-byte boundary
depending on the size of the coordinate datatype (as returned by querying the
path’s `VG_PATH_DATATYPE` parameter using **vgGetParameteri**). The
`VG_PATH_CAPABILITY_MODIFY` capability must be enabled for path

Each incoming coordinate value, regardless of datatype, is transformed by the
scale factor and bias of the path.
```
void vgModifyPathCoords(VGPath dstPath,
VGint startIndex, VGint numSegments,
const void * pathData)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `dstPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> * if `VG_PATH_CAPABILITY_APPEND_TO` is not enabled for dstPath `VG_ILLEGAL_ARGUMENT_ERROR`
> * if `pathData` is `NULL`
> * if `pathData` is not properly aligned
> * if `startIndex` is less than 0
> * if `numSegments` is less than or equal to 0
> * if `startIndex + numSegments` is greater than the number of segments in the path

### 8.6.8 Transforming a Path
<a name="Transforming a Path"></a>

#### vgTransformPath
<a name="vgTransformPath"></a>

**vgTransformPath** appends a transformed copy of `srcPath` to the current contents of
dstPath. The appended path is equivalent to the results of applying the current pathuser-
to-surface transformation (`VG_MATRIX_PATH_USER_TO_
SURFACE`) to `srcPath`.

It is legal for `srcPath` and `dstPath` to be handles to the same path object, in
which case the transformed path will be appended to the existing path. If
`srcPath` and `dstPath` are handles to distinct path objects, the contents of
`srcPath` will not be affected by the call.

All `HLINE_TO_*` and `VLINE_TO_*` segments present in `srcPath` are implicitly
converted to `LINE_TO_*` segments prior to applying the transformation. The original
copies of these segments in `srcPath` remain unchanged.


Any `*ARC_TO` segments are transformed, but the endpoint parametrization of the
resulting arc segments are implementation-dependent. The results of calling
**vgInterpolatePath** on a transformed path that contains such segments are undefined.


The `VG_PATH_CAPABILITY_TRANSFORM_FROM` capability must be enabled for
`srcPath`, and the` VG_PATH_CAPABILITY_TRANSFORM_TO` capability must be
enabled for `dstPath`.

Overflow may occur silently if coordinates are transformed outside the datatype range of
dstPath.
```
void vgTransformPath(VGPath dstPath, VGPath srcPath)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if either `dstPath` or `srcPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> * if `VG_PATH_CAPABILITY_TRANSFORM_FROM` is not enabled for srcPath
> * if `VG_PATH_CAPABILITY_TRANSFORM_TO` is not enabled for dstPath

### 8.6.9 Interpolating Between Paths
<a name="Interpolating Between Paths"></a>

Interpolation takes two compatible paths, in a sense described below, and defines a new
path that interpolates between them by a parameter `amount`. When `amount` is equal to
0, the result is equivalent to the first path; when `amount` is equal to 1, the result is
equivalent to the second path. Values between 0 and 1 produce paths that smoothly
interpolate between the two extremes. Values outside the [0, 1] range produce
extrapolated paths. Conceptually, interpolation occurs as follows. First, the two path
parameters are copied and the copies are normalized by:

• Converting all coordinates to floating-point format, applying the path scale and bias
parameters

• Converting all relative segments to absolute form

• Converting `{H,V}LINE_TO_* `segments to `LINE_TO form`

• Converting `(S)QUAD_TO_*/SCUBIC_TO_*` segments to `CUBIC_TO` form

• Retaining all `*ARC_TO_*` and `CLOSE_PATH` segments

If, following normalization, both paths have the same sequence of segment types
(treating all forms of arc as the same), interpolation proceeds by linearly interpolating
between each corresponding pair of segment parameters in the normalized paths. If the
starting arc type differs from the final arc type, the starting arc type is used for values of
amount less than 0.5, and the final arc type is used for values greater than or equal to
0.5. Finally, the coordinates are converted to the data type of the destination.

#### vgInterpolatePath
<a name="vgInterpolatePath"></a>

The **vgInterpolatePath** function appends a path, defined by interpolation (or
extrapolation) between the paths `startPath` and `endPath` by the given `amount`, to
the path `dstPath`. It returns `VG_TRUE` if interpolation was successful (*i*.*e*., the paths
had compatible segment types after normalization), and `VG_FALSE` otherwise. If
interpolation is unsuccessful, `dstPath` is left unchanged.


It is legal for `dstPath` to be a handle to the same path object as either
`startPath` or `endPath` or both, in which case the contents of the source path
or paths referenced by `dstPath` will have the interpolated path appended. If
`dstPath` is not the a handle to the same path object as either `startPath` or
`endPath`, the contents of `startPath` and `endPath` will not be affected by the
call.

Overflow may occur silently if the datatype of `dstPath` has insufficient range to store
an interpolated coordinate value.

The `VG_PATH_CAPABILITY_INTERPOLATE_FROM` capability must be enabled
for both of `startPath` and `endPath`, and the `INTERPOLATE_TO` capability
must be enabled for `dstPath`.

```
VGboolean vgInterpolatePath(VGPath dstPath,
VGPath startPath,
VGPath endPath,
VGfloat amount)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if any of `dstPath`, `startPath`, or `endPath` is not a valid path handle, or is not shared with the current context
> `VG_PATH_CAPABILITY_ERROR`
> * if `VG_PATH_CAPABILITY_PATH_INTERPOLATE_TO` is not enabled for dstPath
> * if `VG_PATH_CAPABILITY_PATH_INTERPOLATE_FROM` is not enabled for `startPath` or `endPath`

### 8.6.10 Length of a Path
<a name="Length of a Path"></a>

An approximation to the geometric length of a portion of a path may be obtained by
calling the **vgPathLength** function. `MOVE_TO` segments and implicit path closures (see
Section 8.7.1) do not contribute to the path length. `CLOSE_PATH` segments have the
same length as a `LINE_TO` segment with the same endpoints.

#### vgPathLength
<a name="vgPathLength"></a>

The **vgPathLength** function returns the length of a given portion of a path in the user
coordinate system (that is, in the path’s own coordinate system, disregarding any matrix
settings). Only the subpath consisting of the `numSegments` path segments beginning
with `startSegment` (where the initial path segment has index 0) is used. If an
error occurs, -1.0f is returned.
The `VG_PATH_CAPABILITY_PATH_LENGTH` capability must be enabled for `path`.

```
VGfloat vgPathLength(VGPath path,
VGint startSegment, VGint numSegments);
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context `VG_PATH_CAPABILITY_ERROR`
> if `VG_PATH_CAPABILITY_PATH_LENGTH` is not enabled for `path VG_ILLEGAL_ARGUMENT_ERROR`
> * if startSegment is less than 0 or greater than the index of the final path segment
> * if `numSegments` is less than or equal to 0
> * if `(startSegment + numSegments – 1)` is greater than the index of the final path segment

### 8.6.11 Position and Tangent Along a Path
<a name="Position and Tangent Along a Path"></a>

Some path operations, such as the placement and orientation of text along a path, require
the computation of a set of points along a path as well as a normal (perpendicular) vector
at each point. The **vgPointAlongPath** function provides points along the path as well
as normalized tangent vectors (from which normals may easily be derived).

#### The Tangents of a Path Segment
<a name="The Tangents of a Path Segment"></a>

The tangent at a given point along a path is defined as a vector pointing in the same
direction as the path at that point. The tangent at any point of a line segment is parallel to
the line segment; the tangent at any point along a Bézier curve or elliptical arc segment
may be defined using the derivatives of the parametric equations *x(t)* and *y(t)* that define
the curve. The incoming tangent at a point is defined using the direction in which the
curve is “traveling” prior to arriving at the point; the outgoing tangent is defined using
the direction the curve is traveling as it leaves the point. The incoming and outgoing
tangents may differ at a vertex joining different curve segments, or at a sharp “cusp” in a
curve.


If a point along a path segment has no tangent defined, for example where a path
segment has collapsed to a single point, the following algorithm is used to define
incoming and outgoing tangents at the point. Search backwards until a segment is found
with a tangent defined at its end point, or the start of the current path is reached; if a
tangent is found, use it as the incoming tangent. Search forwards until a segment is found
with a tangent defined at its starting point, or the end of the current path is reached; if a
tangent is found, use it as the outgoing tangent. If these searches produce exactly one
defined tangent, that tangent is used as both the incoming and outgoing tangent. If the
searches produced no defined tangent, the incoming and outgoing tangents are both
assigned the value (1, 0). Tangent vectors are normalized to have unit length.

#### vgPointAlongPath
<a name="vgPointAlongPath"></a>

The **vgPointAlongPath** function returns the point lying a given distance along a given
portion of a path and the unit-length tangent vector at that point. Only the subpath
consisting of the `numSegments` path segments beginning with `startSegment`
(where the initial path segment has index 0) is used. For the remainder of this
section we refer only to this subpath when discussing paths.
If `distance` is less than or equal to 0, the starting point of the path is used. If
`distance` is greater than or equal to the path length (*i*.*e*., the value returned by
**vgPathLength** when called with the same `startSegment` and `numSegments`
parameters), the visual ending point of the path is used.
Intermediate values return the $(x, y)$ coordinates and tangent vector of the point at the
given distance along the path. Because it is not possible in general to compute exact
distances along a path, an implementation is not required to use exact
computation even for segments where such computation would be possible. For
example, the path:

`MOVE_TO 0, 0; LINE_TO 10, 0 // draw a line of length 10`

`MOVE_TO 10, 10 // create a discontinuity`

`LINE_TO 10, 20 // draw a line of length 10`

may return either (10, 0) or (10, 10) (or points nearby) as the point at distance
10.0. Implementations are not required to compute distances exactly, as long as
they satisfy the constraint that as `distance` increases monotonically the
returned point and tangent move forward monotonically along the path.

Where the implementation is able to determine that the point being queried
lies exactly at a discontinuity or cusp, the incoming point and tangent should be
returned. In the example above, returning the pre-discontinuity point (10, 0) and
incoming tangent (1, 0) is preferred to returning the post-discontinuity point (10,10) and outgoing tangent (0, 1).

The `VG_PATH_CAPABILITY_POINT_ALONG_PATH` capability must be enabled for
path.

If the reference arguments x and y are both non-`NULL`, and the
`VG_PATH_CAPABILITY_POINT_ALONG_PATH` capability is enabled for `path`, the
point $(x, y)$ is returned in *x* and *y*. Otherwise the variables referenced by *x* and *y* are not
written.

If the reference arguments `tangentX` and `tangentY` are both non-`NULL`, and the
`VG_PATH_CAPABILITY_TANGENT_ALONG_PATH` capability is enabled for `path`,
the geometric tangent vector at the point $(x, y)$ is returned in `tangentX` and
`tangentY`. Otherwise the variables referenced by `tangentX` and `tangentY` are not
written.

Where the incoming tangent is defined, **vgPointAlongPath** returns it. Where only the
outgoing tangent is defined, the outgoing tangent is returned.

The points returned by **vgPointAlongPath** are not guaranteed to match the path as
rendered; some deviation is to be expected.

```
void vgPointAlongPath(VGPath path,
VGint startSegment, VGint numSegments,
VGfloat distance,
VGfloat * x, VGfloat * y,
VGfloat * tangentX, VGfloat * tangentY)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context `VG_PATH_CAPABILITY_ERROR`
> * If x and y are both non-`NULL`, and the `VG_PATH_CAPABILITY_POINT_ALONG_PATH` is not enabled for `path`
> * If `tangentX` and `tangentY` are both non-`NULL`, and the `VG_PATH_CAPABILITY_TANGENT_ALONG_PATH` capability is not enabled for `path`
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if startSegment is less than 0 or greater than the index of the final path segment
> * if `numSegments` is less than or equal to 0
> * if (startSegment + numSegments – 1) is less than 0 or greater than the index of the final path segment
> * if x, y, tangentX or tangentY is not properly aligned

### 8.6.12 Querying the Bounding Box of a Path
<a name="Querying the Bounding Box of a Path"></a>

To draw complex scenes efficiently, it is important to avoid drawing objects that do not appear in the region being drawn. A simple way to determine whether an object may be visible is to determine whether its *bounding box* – an axis-aligned rectangle that is guaranteed to contain the entire object – intersects the drawn region. The **vgPathBounds** and **vgPathTransformedBounds** functions provide bounding box information.

Two types of bounding boxes may be obtained for a path. The first, obtained by calling **vgPathBounds**, returns a tight axis-aligned bounding box for the area contained within the path in its own coordinate system. The second, obtained by calling **vgPathTransformedBounds**, returns an axis-aligned bounding box for the path as it will appear when drawn on the drawing surface (*i*.*e*., following application of the current path-user-to-surface transform). The latter function does not guarantee to bound the shape tightly, but still may provide tighter bounds than those obtained by transforming the result of **vgPathBounds**, at a lower cost.


The bounding box of a path is defined to contain all points along the path, including isolated points created by `MOVE_TO` segments. The fill rule has no effect on the determination of the bounding box. If the path is to be stroked, the application must adjust the bounding box to take the stroking parameters into account. Note that Miter joins in particular may extend far outside the bounding box.

#### vgPathBounds
<a name="vgPathBounds"></a>

The **vgPathBounds** function returns an axis-aligned bounding box that tightly bounds the interior of the given path. Stroking parameters are ignored. If path is empty, `minX` and `minY` are set to 0 and `width` and `height` are set to -1. If `path` contains a single point, `minX` and `minY` are set to the coordinates of the point and `width` and `height` are set to 0.

The `VG_PATH_CAPABILITY_PATH_BOUNDS` capability must be enabled for path

```
void vgPathBounds(VGPath path,
VGfloat * minX, VGfloat * minY,
VGfloat * width, VGfloat * height)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context `VG_PATH_CAPABILITY_ERROR`
> * if minX, minY, width, or height is `NULL`
> * if minX, minY, width, or height is not properly aligned `VG_PATH_CAPABILITY_ERROR`
> if `VG_PATH_CAPABILITY_PATH_BOUNDS` is not enabled for path


#### vgPathTransformedBounds
<a name="vgPathTransformedBounds"></a>

The **vgPathTransformedBounds** function returns an axis-aligned bounding box that is guaranteed to enclose the geometry of the given `path` following transformation by the current path-user-to-surface transform. The returned bounding box is not guaranteed to fit tightly around the path geometry. If `path` is empty, `minX` and `minY` are set to 0 and `width` and `height` are set to -1. If `path` contains a single point, `minX` and `minY` are set to the coordinates of the point and `width` and `height` are set to 0.

The `VG_PATH_CAPABILITY_PATH_BOUNDS` capability must be enabled for
path.

```
void vgPathBounds(VGPath path,
VGfloat * minX, VGfloat * minY,
VGfloat * width, VGfloat * height)
```

> **_ERRORS_**
>
>`VG_BAD_HANDLE_ERROR`
> * if `path` is not a valid path handle, or is not shared with the current context `VG_PATH_CAPABILITY_ERROR`
> * if minX, minY, width, or height is `NULL`
> * if minX, minY, width, or height is not properly aligned `VG_PATH_CAPABILITY_ERROR`
> if `VG_PATH_CAPABILITY_PATH_TRANSFORMED_BOUNDS` is not enabled for path

## 8.7 Interpretation of Paths
<a name="Interpretation of Paths"></a>

The interpretation of a path, composed of a sequence of one or more subpaths, depends on whether it is to be stroked or filled. For stroked paths, each subpath has stroking parameters applied to it separately, with the dash phase at the end of each subpath used at the beginning of the next subpath. This process results in a set of stroked shapes. The union of these shapes then defines the outline path to be filled. For filled paths, the interior of the path (as defined below) is filled.

### 8.7.1 Filling Paths
<a name="Filling Paths"></a>
A simple, non-self-intersecting closed path divides the plane into two regions, a bounded *inside* region and an unbounded *outside* region. Note that knowing the orientation of the outermost path (*i*.*e*., clockwise or counter-clockwise) is not necessary to differentiate between the inside and outside regions.

A path that self-intersects, or that has multiple overlapping subpaths, requires additional information in order to define the inside region. Two rules that provide different definitions for the area enclosed by such paths, known as the non-zero and even/odd fill rules, are supported by OpenVG. To determine whether any point in the plane is contained in the inside region, imagine drawing a line from that point out to infinity in any direction such that the line does not cross any vertex of the path. For each edge that is crossed by the line, add 1 to the counter if the edge crosses from left to right, as seen by an observer walking along the line towards infinity, and subtract 1 if the edge crosses from right to left. In this way, each region of the plane will receive an integer value.

The non-zero fill rule says that the point is inside the shape if the resulting sum is not equal to 0. The even/odd rule says that the point is inside the shape if the resulting sum is odd, regardless of sign (*e*.*g*., -7 is odd, 0 is even). Consider the star-shaped path shown in Figure 8 below, indicated with solid lines. The orientation of the lines making up the path is indicated with arrows. An imaginary line to infinity starting in the central region of the star is shown as a dashed line pointing to the right. Two edges of the star cross the line to infinity going left to right, indicated by the downward-pointing arrows. The central region therefore has a count of +2. According to the even/odd rule, it is outside the path, whereas according to the non-zero rule it is inside. Implementations must be able to deal with paths having up to 255 crossings along any line. The behavior of more complex paths is undefined.

<img src="figures/Figure 8.PNG"/>

*Figure 8: Even/Odd Fill Rule*

#### Creating Holes in Paths
<a name="Creating Holes in Paths"></a>

The fill rule is applied with respect to all subpaths simultaneously during filling. Thus, one subpath may be used to create a hole inside an enclosing subpath by defining the two subpaths with opposing orientations (clockwise versus counter-clockwise). Note that the orientation of extremely small paths may depend on the numerical precision of the internal representation of points. Care should be taken to avoid the use of paths that have nearly collapsed to a line or a point.

The relative orientation of subpaths, along with the fill rule, determines whether overlapping subpaths will result in holes, as shown in Figure 9 below.

||_**Even/Old Fil Rule**_|_**Non-Zero Fill Rule**_|
|-|-------|-------|
|_**Same Orientation**_|<img src="figures/Figure 9-1.PNG"/>|<img src="figures/Figure 9-2.PNG"/>|
|_**Opposing Orientation**_|<img src="figures/Figure 9-3.PNG"/>|<img src="figures/Figure 9-4.PNG"/>|


$$v'_{repeat} = vâˆ’|v|$$

In reflect mode, the offset value v is mapped to a new value vÂ´ that is guaranteed to liebetween 0 and 1. Following this mapping, the color is defined as for pad mode:

$$
v'_{reflect} =
\begin{cases}
 & v-|v| \text{, if |v| is even }  \\
 & 1-(v-|v|) \text{, if |v| is odd }
\end{cases}
$$

### 9.3.4 Gradient Examples
<a name="Gradient_Examples"></a>

Figure 20 shows a square from (0, 0) to (400, 400) painted with a set of linear gradientswith (x0, y0) = (100, 100), (x1, y1) = (300, 300).

Figure 21 shows the same square painted with radial gradients with centered and noncentered focal points. The centered gradient, shown in the top row, has its center (cx, cy)and focal point (fx, fy) both at (200, 200). The non-centered gradient, shown in thebottom row, has its center (cx, cy) at (200, 200) and its focal point (fx, fy) at (250, 250).The radius r for both gradients is equal to 100.

All the gradients shown in this section utilize a color ramp with stops at offsets 0.0,0.33, 0.66, and 1.0 colored white, red, green, and blue, respectively, as shown in Figure22.

<img src="figures/figure20.png"/>

Figure 20: Linear Gradients

<img src="figures/figure21.png"/>

Figure 21: Centered and Non-Centered Radial Gradients

<img src="figures/figure22.png"/>

Figure 22: Color Ramp used for Gradient Examples

## 9.4 Pattern Paint
<a name="Pattern_Paint"></a>

Pattern paint defines a rectangular pattern of colors based on the pixel values of an image. Images are described below in Section 10. Each pixel (x, y) of the pattern imagedefines a point of color at the pixel center (x + Â½, y + Â½).

Filtering may be used to construct an interpolated pattern value at the sample point,based on the pattern image pixel values. The pattern tiling mode is used to define valuesfor pixel centers in the pattern space that lie outside of the bounds of the pattern.

Interpolation may be performed between multiple pixels of the pattern image to producean antialiased pattern value. The image quality setting at the time of drawing (determinedby the `VG_IMAGE_QUALITY` parameter) is used to control the quality of patterninterpolation. If the image quality is set `toVG_IMAGE_QUALITY_NONANTIALIASED`, nearest-neighbor interpolation (pointsampling) is used. If the image quality is set to `VG_IMAGE_QUALITY_FASTER` or `VG_IMAGE_QUALITY_BETTER`, higher-quality interpolation will b...(line truncated)...

#### vgPaintPattern
<a name="vgPaintPattern"></a>

The `vgPaintPattern` function replaces any previous pattern image defined on thegiven paint object for the given set of paint modes with a new pattern image. Avalue of `VG_INVALID_HANDLE` for the pattern parameter removes the currentpattern image from the paint object.

If the current paint object has its `VG_PAINT_TYPE` parameter set to `VG_PAINT_TYPE_PATTERN`, but no pattern image is set, the paint object behaves as if `VG_PAINT_TYPE` were set to `VG_PAINT_TYPE_COLOR`.

While an image is set as the paint pattern for any paint object, it may not be used as arendering target. Conversely, an image that is currently a rendering target may not be setas a paint pattern.

```c
void vgPaintPattern(VGPaint paint, VGImage pattern)
```

> **_ERRORS_**
>
> `VG_BAD_HANDLE_ERROR`
> * if paint is not a valid paint handle, or is not shared with the current context
> * if pattern is neither a valid image handle nor equal to `VG_INVALID_HANDLE`, or is not shared with the current context
>
> `VG_IMAGE_IN_USE_ERROR`
> * if pattern is currently a rendering targe

### 9.4.1 Pattern Tiling
<a name="Pattern_Tiling"></a>

Patterns may be extended (tiled) using one of four possible tiling modes, defined by the `VGTilingMode` enumeration.

#### VGTilingMode
<a name="VGTilingMode"></a>

The `VGTilingMode` enumeration defines possible methods for defining colors forsource pixels that lie outside the bounds of the source image.

The `VG_TILE_FILL` condition specifies that pixels outside the bounds of the sourceimage should be taken as the color `VG_TILE_FILL_COLOR`. The color is expressed asa non-premultiplied sRGBA color and alpha value. Values outside the [0, 1] range areinterpreted as the nearest endpoint of the range.

The `VG_TILE_PAD` condition specifies that pixels outside the bounds of the sourceimage should be taken as having the same color as the closest edge pixel of the sourceimage. That is, a pixel (x, y) has the same value as the image pixel (max(0, min(x, widthâ€“ 1)), max(0, min(y, height â€“ 1))).

The `VG_TILE_REPEAT` condition specifies that the source image should be repeatedindefinitely in all directions. That is, a pixel (x, y) has the same value as the image pixel(x mod width, y mod height) where the operator â€˜a mod bâ€™ returns a value between 0 and(b â€“ 1) such that a = k*b + (a mod b) for some integer k.

The `VG_TILE_REFLECT` condition specifies that the source image should be reflectedindefinitely in all directions. That is, a pixel (x, y) has the same value as the image pixel(xâ€™, yâ€™) where:

$$
x' =
\begin{cases}
  & \text{x mod width, if floor(x/width) is even} \\
  & \text{width - 1 - x mod width, otherwise}
\end{cases}
$$

$$
y' =
\begin{cases}
  & \text{y mod height, if floor(y/height) is even} \\
  & \text{height - 1 - y mod height, otherwise}
\end{cases}
$$

```c
typedef enum {
  VG_TILE_FILL = 0x1D00,
  VG_TILE_PAD = 0x1D01,
  VG_TILE_REPEAT = 0x1D02,
  VG_TILE_REFLECT = 0x1D03,
} VGTilingMode;
```

#### Setting the Pattern Tiling Mode

The pattern tiling mode is set using vgSetParameteri with a paramType argument of `VG_PAINT_PATTERN_TILING_MODE`.

```c
VGPaint myFillPaint, myStrokePaint;
VGImage myFillPaintPatternImage, myStrokePaintPatternImage;
VGTilingMode fill_tilingMode, stroke_tilingMode;
vgSetParameteri(myFillPaint, VG_PAINT_TYPE,
VG_PAINT_TYPE_PATTERN);
vgSetParameteri(myFillPaint, VG_PAINT_PATTERN_TILING_MODE,
fill_tilingMode);
vgPaintPattern(myFillPaint, myFillPaintPatternImage);
vgSetParameteri(myStrokePaint, VG_PAINT_TYPE,
VG_PAINT_TYPE_PATTERN);
vgSetParameteri(myStrokePaint, VG_PAINT_PATTERN_TILING_MODE,
stroke_tilingMode);
vgPaintPattern(myStrokePaint, myStrokePaintPatternImage);
```

# 10 Images
<a name="Chapter10"></a>
<a name="Images"></a>

Images are rectangular collections of pixels. Image data may be inserted or extracted in avariety of formats with varying bit depths, color spaces, and alpha channel types. Theactual storage format of an image is implementation-dependent, and may be optimizedfor a given device, but must allow pixels to be read and written losslessly. Images may bedrawn to a drawing surface, used to define paint patterns, or operated on directly byimage filter operations.

## 10.1 Image Coordinate Systems
<a name="Image_Coordinate_Systems"></a>

An image defines a coordinate system in which pixels are indexed using integercoordinates, with each integer corresponding to a distinct pixel. The lower-left pixel hasa coordinate of (0, 0), the x coordinate increases horizontally from left to right, and the ycoordinate increases vertically from bottom to top. Note that this orientation is consistentwith the other coordinate systems used in the OpenVG API, but differs from the top-tobottom orientation used by many other imaging systems.

The â€œenergyâ€ of a pixel is located at the pixel center; that is, the pixel with coordinate (x,y) has its energy at the point (x + Â½, y + Â½). The color at a point not located at a pixelcenter may be defined by applying a suitable filter to the colors defined at a set of nearbypixel centers.

## 10.2 Image Formats
<a name="Image_Formats"></a>

#### VGImageFormat
<a name="VGImageFormat"></a>

The VGImageFormat enumeration defines the set of supported pixel formats and colorspaces for images:

```c
typedef enum {
	/* RGB{A,X} channel ordering */
	VG_sRGBX_8888 = 0,
	VG_sRGBA_8888 = 1,
	VG_sRGBA_8888_PRE = 2,
	VG_sRGB_565 = 3,
	VG_sRGBA_5551 = 4,
	VG_sRGBA_4444 = 5,
	VG_sL_8 = 6,
	VG_lRGBX_8888 = 7,
	VG_lRGBA_8888 = 8,
	VG_lRGBA_8888_PRE = 9,
	VG_lL_8 = 10,
	VG_A_8 = 11,
	VG_BW_1 = 12,
	VG_A_1 = 13,
	VG_A_4 = 14,
	/* {A,X}RGB channel ordering */
	VG_sXRGB_8888 = 0 | (1 << 6),
	VG_sARGB_8888 = 1 | (1 << 6),
	VG_sARGB_8888_PRE = 2 | (1 << 6),
	VG_sARGB_1555 = 4 | (1 << 6),
	VG_sARGB_4444 = 5 | (1 << 6),
	VG_lXRGB_8888 = 7 | (1 << 6),
	VG_lARGB_8888 = 8 | (1 << 6),
	VG_lARGB_8888_PRE = 9 | (1 << 6),
	/* BGR{A,X} channel ordering */
	VG_sBGRX_8888 = 0 | (1 << 7),
	VG_sBGRA_8888 = 1 | (1 << 7),
	VG_sBGRA_8888_PRE = 2 | (1 << 7),
	VG_sBGR_565 = 3 | (1 << 7),
	VG_sBGRA_5551 = 4 | (1 << 7),
	VG_sBGRA_4444 = 5 | (1 << 7),
	VG_lBGRX_8888 = 7 | (1 << 7),
	VG_lBGRA_8888 = 8 | (1 << 7),
	VG_lBGRA_8888_PRE = 9 | (1 << 7),
	/* {A,X}BGR channel ordering */
	VG_sXBGR_8888 = 0 | (1 << 6) | (1 << 7),
	VG_sABGR_8888 = 1 | (1 << 6) | (1 << 7),
	VG_sABGR_8888_PRE = 2 | (1 << 6) | (1 << 7),
	VG_sABGR_1555 = 4 | (1 << 6) | (1 << 7),
	VG_sABGR_4444 = 5 | (1 << 6) | (1 << 7),
	VG_lXBGR_8888 = 7 | (1 << 6) | (1 << 7),
	VG_lABGR_8888 = 8 | (1 << 6) | (1 << 7),
	VG_lABGR_8888_PRE = 9 | (1 << 6) | (1 << 7)
} VGImageFormat;
```

The letter A denotes an alpha (Î±) channel , R denotes red, G denotes green, and Bdenotes blue. X denotes a padding byte that is ignored. L denotes grayscale, and BWdenotes (linear) bi-level grayscale (black-and-white), with 0 representing black and 1representing white in either case. A lower-case letter s represents a non-linear,perceptually-uniform color space, as in sRGB and sL; a lower-case letter l represents alinear color space using the sRGB primaries. Formats with a suffix of _PRE store pixelvalues i...(line truncated)...

Bit 6 of the numeric values of the enumeration indicates the position of the alpha channel(or unused byte for formats that do not include alpha). If bit 6 is disabled, the alpha orunused channel appears as the last channel, otherwise it appears as the first channel. Bit 7indicates the ordering of the RGB color channels. If bit 7 is disabled, the color channelsappear in RGB order, otherwise they appear in BGR order.

The VG_A_8 format is treated as though it were VG_lRGBA_8888, withR=G=B=1. Color information is discarded when placing an RGBA value into aVG_A_8 pixel.

Abbreviated names such as lL or sRGBA_PRE are used in this document where theexact number of bits per channel is not relevant, such as when pixel values areconsidered to have been remapped to a [0, 1] range. Such abbreviated names are not anofficial part of the API.

The bits for each color channel are stored within a machine word representing a singlepixel from left to right (MSB to LSB) in the order indicated by the pixel format name.For example, in a pixel with a format of VG_sRGB_565, the bits representing the redchannel may be obtained by shifting right by 11 bits (to remove 6 bits of green and 5 bitsof blue) and masking with the 5-bit wide mask value 0x1f. Note that this definition isindependent of the endianness of the underlying platform as sub-word memory addre...(line truncated)...

Table 11 summarizes the symbols used in image format names.

Table 12 lists the size of a single pixel for each image format, in terms of bytes and bits.Note that all formats other than VG_BW_1, VG_A_1, and VG_A_4 use a whole numberof bytes per pixel.

Formats having linear-light coding (`VG_lRGBX_8888`, `VG_lRGBA_8888`,`VG_lRGBA_8888_PRE`, and `VG_lL8`) are liable to exhibit banding (or contouring)artifacts when viewed with a contrast ratio greater than about 10:1 [POYN03] and areintended mainly for inputting existing linearly-coded imagery. For high-quality imaging,consider using one of the non-linear, perceptually uniform image formats such asVG_sRGBX_8888, VG_sRGBA_8888, VG_sRGBA_8888_PRE, and VG_sL_8.

|Symbol|Interperetation|
|-----|-----|
|A|Alpha channel|
|R|Red color channel|
|G|Green color channel|
|B|Blue color channel|
|X|Uninterpreted padding byte|
|L|Grayscale|
|BW|1-bit Black and White|
|l|Linear color space|
|s|Non-linear (sRGB) color space|
|PRE|Alpha values are premultiplied|

|Format|Bytes Per Pixel|Bits Per Pixel|
|-----|-----|----|
|VG_sRGBX_8888|4|32|
|VG_sRGBA_8888|4|32|
|VG_sRGBA_8888_PRE|4|32|
|VG_sRGB_565|2|16|
|VG_sRGBA_5551|2|16|
|VG_sRGBA_4444|2|16|
|VG_sL_8|1|8|
|VG_lRGBX_8888|4|32|
|VG_lRGBA_8888|4|32|

|Format|Bytes Per Pixel|Bits Per Pixel|
|-----|-----|-----|
|VG_lRGBA_8888_PRE|4|32|
|VG_lL_8|1|8|
|VG_A_1|n/a|1|
|VG_A_4|n/a|4|
|VG_A_8|1|8|
|VG_BW_1|n/a|1|

## 10.3 Creating and Destroying Images
<a name="Creating_and_Destroying_Images"></a>

#### VGImage
<a name="VGImage"></a>

Images are accessed using opaque handles of type VGImage.

```c
typedef VGHandle VGImage;
```

#### VGImageQuality
<a name="VGImageQuality"></a>

The `VGImageQuality` enumeration defines varying levels of resamplingquality to be used when drawing images.

The `VG_IMAGE_QUALITY_NONANTIALIASED` setting disables resampling;images are drawn using point sampling (also known as nearest-neighborinterpolation) only. `VG_IMAGE_QUALITY_FASTER` enables low-to-mediumquality resampling that does not require extensive additional resource allocation. `VG_IMAGE_QUALITY_BETTER` enables high-quality resampling that may allocateadditional memory for pre-filtering, tables, and the like. Implementations are notrequired to provide three distinct resampling algorithms, but the non...(line truncated)...

```c
typedef enum {
	VG_IMAGE_QUALITY_NONANTIALIASED = (1 << 0),
	VG_IMAGE_QUALITY_FASTER = (1 << 1),
	VG_IMAGE_QUALITY_BETTER = (1 << 2)
} VGImageQuality;
```

Use vgSeti with a parameter type of `VG_IMAGE_QUALITY` to set the filter type to beused for image drawing:

```c
VGImageQuality quality;
vgSeti(VG_IMAGE_QUALITY, quality);
```

#### VG_MAX_IMAGE_WIDTH
<a name="VG_MAX_IMAGE_WIDTH"></a>

The `VG_MAX_IMAGE_WIDTH` read-only parameter contains the largest legal valueof the width parameter to the vgCreateImage and vgCreateMask functions. Allimplementations must define `VG_MAX_IMAGE_WIDTH` to be an integer no smallerthan 256. If there is no implementation-defined limit, a value of `VG_MAXINT` may bereturned. The value may be retrieved by calling vgGeti:

```c
VGint imageMaxWidth = vgGeti(VG_MAX_IMAGE_WIDTH);
```

#### VG_MAX_IMAGE_HEIGHT
<a name="VG_MAX_IMAGE_HEIGHT"></a>

The `VG_MAX_IMAGE_HEIGHT` read-only parameter contains the largest legal valueof the height parameter to the vgCreateImage and vgCreateMask functions. Allimplementations must define `VG_MAX_IMAGE_HEIGHT` to be an integer no smallerthan 256. If there is no implementation-defined limit, a value of `VG_MAXINT` may bereturned. The value may be retrieved by calling vgGeti:

```c
VGint imageMaxHeight = vgGeti(VG_MAX_IMAGE_HEIGHT);
````

#### VG_MAX_IMAGE_PIXELS
<a name="VG_MAX_IMAGE_PIXELS"></a>

The `VG_MAX_IMAGE_PIXELS` read-only parameter contains the largest legal valueof the product of the width and height parameters to the vgCreateImage andvgCreateMask functions. All implementations must define `VG_MAX_IMAGE_PIXELS` to be an integer no smaller than 65536. If there is no implementation-defined limit, avalue of VG_MAXINT may be returned. The value may be retrieved by calling vgGeti:

```c
VGint imageMaxPixels = vgGeti(VG_MAX_IMAGE_PIXELS);
```

#### VG_MAX_IMAGE_BYTES
<a name="VG_MAX_IMAGE_BYTES"></a>

The `VG_MAX_IMAGE_BYTES` read-only parameter contains the largest number of bytes that may make up the image data passed to the vgCreateImage function. Allimplementations must define `VG_MAX_IMAGE_BYTES` to be an integer no smaller than65536. If there is no implementation-defined limit, a value of `VG_MAXINT` may bereturned. The value may be retrieved by calling vgGeti:

```c
VGint imageMaxBytes = vgGeti(VG_MAX_IMAGE_BYTES);
```

#### vgCreateImage
<a name="vgCreateImage"></a>

vgCreateImage creates an image with the given width, height, and pixel formatand returns a `VGImage` handle to it. If an error occurs, `VG_INVALID_HANDLE` isreturned. All color and alpha channel values are initially set to zero. The formatparameter must contain a value from the `VGImageFormat` enumeration.

The allowed Quality parameter is a bitwise OR of values from the `VGImageQuality` enumeration, indicating which levels of resampling quality may beused to draw the image. It is always possible to draw an image using the `VG_IMAGE_QUALITY_NONANTIALIASED` quality setting even if it is not explicitlyspecified.

```c
VGImage vgCreateImage(VGImageFormat format,
      VGint width, VGint height,
      VGbitfield allowedQuality)
```

> **_ERRORS_**
>
> `VG_UNSUPPORTED_IMAGE_FORMAT_ERROR`
> * if format is not a valid value from the `VGImageFormat` enumeration
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height are less than or equal to 0
> * if width is greater than `VG_MAX_IMAGE_WIDTH`
> * if height is greater than `VG_MAX_IMAGE_HEIGHT`
> * if width*height is greater than `VG_MAX_IMAGE_PIXELS`
> * if width\*height\*(pixel size of format) is greater than
>
> `VG_MAX_IMAGE_BYTES`
> * if `allowedQuality` is not a bitwise OR of values from the `VGImageQuality` enumeration

#### vgDestroyImage
<a name="vgDestoryImage"></a>

The resources associated with an image may be deallocated by callin `vgDestroyImage`. Following the call, the image handle is no longer valid in anycontext that shared it. If the image is currently in use as a rendering target, is theancestor of another image (see `vgChildImage`), is set as a paint pattern image ona VGPaint object, or is set as a glyph an a VGFont object, its definition remainsavailable to those consumers as long as they remain valid, but the handle may nolonger be used. When those uses cea...(line truncated)...

```c
void vgDestroyImage(VGImage image);
```

> **_ERRORS_**
>
> `VG_BAD_HANDLE_ERROR`
> * if image is not a valid image handle, or is not shared with the current context

## 10.4 Querying Images
<a name="Querying_Images"></a>

#### VGImageParamType
<a name="VGImageParamType"></a>

Values from the `VGImageParamType` enumeration may be used as the paramTypeargument to `vgGetParameter` to query various features of an image. All of theparameters defined by `VGImageParamType` have integer values and are read-only.

```c
typedef enum {
  VG_IMAGE_FORMAT = 0x1E00,
  VG_IMAGE_WIDTH = 0x1E01,
  VG_IMAGE_HEIGHT = 0x1E02
} VGImageParamType;
```

#### Image Format
<a name="Image_Formats"></a>

The value of the format parameter that was used to define the image may be queriedusing the VG_IMAGE_FORMAT parameter. The returned integral value should becast to the VGImageFormat enumeration:

```c
VGImage image;
VGImageFormat imageFormat =
  (VGImageFormat)vgGetParameteri(image, VG_IMAGE_FORMAT);
```

#### Image Width
<a name="Image_Width"></a>

The value of the width parameter that was used to define the image may be queriedusing the `VG_IMAGE_WIDTH` parameter:

```c
VGImage image;
VGint imageWidth = vgGetParameteri(image, VG_IMAGE_WIDTH);
```

#### Image Height
<a name="Image_Height"></a>

The value of the height parameter that was used to define the image may be queriedusing the `VG_IMAGE_HEIGHT` parameter:

```c
VGImage image;
VGint imageHeight = vgGetParameteri(image, VG_IMAGE_HEIGHT);
```

## 10.5 Reading and Writing Image Pixels
<a name="Reading_and_Writing_Image_Pixels"></a>

#### vgClearImage
<a name="vgClearImage"></a>

The `vgClearImage` function fills a given rectangle of an image with the color specifiedby the `VG_CLEAR_COLOR` parameter. The rectangle to be cleared is given by x, y,width, and height, which must define a positive region. The rectangle isclipped to the bounds of the image.

```c
void vgClearImage(VGImage image,
VGint x, VGint y, VGint width, VGint height)
```

> **_ERRORS_**
>
> `VG_BAD_HANDLE_ERROR`
> * if image is not a valid image handle, or is not shared with the current
>
> context
> `VG_IMAGE_IN_USE_ERROR`
> * if image is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height is less than or equal to 0

#### vgImageSubData
<a name="vgImageSubData"></a>

The `vgImageSubData` function reads pixel values from memory, performs formatconversion if necessary, and stores the resulting pixels into a rectangular portion of animage.

Pixel values are read starting at the address given by the pointer data; adjacentscanlines are separated by dataStride bytes. Negative or zero values ofdataStride are allowed. The region to be written is given by x, y, width, andheight, which must define a positive region. Pixels that fall outside the boundsof the image are ignored.

Pixel values in memory are formatted according to the dataFormat parameter, whichmust contain a value from the `VGImageFormat` enumeration. The data pointer mustbe aligned according to the number of bytes of the pixel format specified bydataFormat, unless dataFormat is equal to VG_BW_1, VG_A_1, or VG_A_4, in which case 1 byte alignment is sufficient. Each pixel is converted into the format ofthe destination image as it is written.

If dataFormat is not equal to `VG_BW_1`, `VG_A_1`, or `VG_A_4`, the destination imagepixel (x + i, y + j) for 0 â‰¤ i < width and 0 â‰¤ j < height is taken from the N bytes ofmemory starting at data + j*dataStride + i*N, where N is the number of bytes per pixelgiven in Table 12. For multi-byte pixels, the bits are arranged in the same order used tostore native multi-byte primitive datatypes. For example, a 16-bit pixel would be writtento memory in the same format as when writing through a pointer with a native ...(line truncated)...

If dataFormat is equal to VG_BW_1 or VG_A_1, pixel (x + i, y + j) of thedestination image is taken from the bit at position (i % 8) within the byte at data +j *dataStride + floor(i/8) where the least significant bit (LSB) of a byte is considered tobe at position 0 and the most significant bit (MSB) is at position 7. Each scanline mustbe padded to a multiple of 8 bits. Note that dataStride is always given in terms ofbytes, not bits.

If dataFormat is equal to VG_A_4, pixel (x + i, y + j) of the destination image istaken from the 4 bits from position (4*(i % 2)) to (4*(i % 2) + 3) within the byte at data+ j*dataStride + floor(i/2). Each scanline must be padded to a multiple of 8 bits.

If dataFormat specifies a premultiplied format (`VG_sRGBA_8888_PRE` or `VG_lRGBA_8888_PRE`), color channel values of a pixel greater than theircorresponding alpha value are clamped to the range [0, alpha].

```c
void vgImageSubData(VGImage image,
    const void * data, VGint dataStride,
    VGImageFormat dataFormat,
    VGint x, VGint y, VGint width, VGint height)
```

> **_ERRORS_**
>
> `VG_BAD_HANDLE_ERROR`
> * if image is not a valid image handle, or is not shared with the current
> context
>
> `VG_IMAGE_IN_USE_ERROR`
> * if image is currently a rendering target
>
> `VG_UNSUPPORTED_IMAGE_FORMAT_ERROR`
> * if dataFormat is not a valid value from the VGImageFormat enumeration
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height is less than or equal to 0
> * if data is NULL
> * if data is not properly aligned

#### vgGetImageSubData
<a name="vgGetImageSubData"></a>

The `vgGetImageSubData` function reads pixel values from a rectangular portion of animage, performs format conversion if necessary, and stores the resulting pixels intomemory.

Pixel values are written starting at the address given by the pointer data; adjacentscanlines are separated by dataStride bytes. Negative or zero values ofdataStride are allowed. The region to be read is given by x, y, width, andheight, which must define a positive region. Pixels that fall outside the boundsof the image are ignored.

Pixel values in memory are formatted according to the dataFormat parameter, whichmust contain a value from the `VGImageFormat` enumeration. If dataFormatspecifies a premultiplied format (`VG_sRGBA_8888_PRE` or `VG_lRGBA_8888_PRE`),color channel values of a pixel that are greater than their corresponding alpha value areclamped to the range [0, alpha]. The data pointer alignment and the pixel layout inmemory are as described in the **vgImageSubData** section.

```c
void vgGetImageSubData(VGImage image,
    void * data, VGint dataStride,
    VGImageFormat dataFormat,
    VGint x, VGint y, VGint width, VGint height)
```

> **_ERRORS_**
>
> `VG_BAD_HANDLE_ERROR`
> * if image is not a valid image handle, or is not shared with the current
>
> `VG_IMAGE_IN_USE_ERROR`
> * if image is currently a rendering target
>
> `VG_UNSUPPORTED_IMAGE_FORMAT_ERROR`
> * if dataFormat is not a valid value from the VGImageFormat enumeration
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height is less than or equal to 0
> * if data is NULL
> * if data is not properly aligned

## 10.6 Child Images
<a name="Child_Images"></a>

A child image is an image that shares physical storage with a portion of an existingimage, known as its parent. An image may have any number of children, but each imagehas only one parent (that may be itself). An ancestor of an image is defined as the imageitself, its parent, its parentâ€™s parent, etc. By definition, a pair of images are said to be related if and only if they have a common ancestor. Specifically, two images that are children of a common parent are considered to be related even if their respe...(line truncated)...

A child image remains valid even following a call to `vgDestroyImage` on one of its ancestors (other than itself). When the last image of a set of related images is destroyed,the entire storage will be reclaimed. Implementations may use a reference count todetermine when image storage may be reclaimed.

A child image may not be used as a rendering target. A parent image may not be used asa rendering target until all the child images derived from it have been destroyed.


```c
VGImage A = vgCreateImage(...); // Create a new image A
VGImage B = vgChildImage(A, ...); // Make B a child of A
VGImage C = vgChildImage(B, ...); // Make C a child of B
VGImage parentA = vgGetParent(A); // A has no ancestors, parentA == A
VGImage parentB = vgGetParent(B); // A is B's parent, parentB == A
VGImage parentC1 = vgGetParent(C); // B is C's parent, parentC1 == B
vgDestroyImage(B); // Destroy B
VGImage parentC2 = vgGetParent(C); // B is not valid, parentC2 == A
vgDestroyImage(A); // Destroy A
VGImage parentC3 = vgGetParent(C); // A, B are not valid, parentC3 == C
```

```c
VGImage vgGetParent(VGImage image)
```

> **_ERRORS_**
> `VG_BAD_HANDLE_ERROR`
> * if image is not a valid image handle, or is not shared with the current context
>
> `VG_IMAGE_IN_USE_ERROR`
> * if image is currently a rendering target

## 10.7 Copying Pixels Between Images
<a name="Copying_Pixels_Between_Images"></a>

#### vgCopyImage
<a name="vgCopyImage"></a>

Pixels may be copied between images using the `vgCopyImage` function. The sourceimage pixel (sx + i, sy + j) is copied to the destination image pixel(dx + i, dy + j), for 0 â‰¤ i < width and 0 â‰¤ j < height. Pixels whose source ordestination lie outside of the bounds of the respective image are ignored. Pixelformat conversion is applied as needed.

If the dither flag is equal to `VG_TRUE`, an implementation-dependent ditheringalgorithm may be applied. This may be useful when copying into a destinationimage with a smaller color bit depth than that of the source image. Implementations should choose an algorithm that will provide good resultswhen the output images are displayed as successive frames in an animation.

If src and dst are the same image, or are related, the copy will occur in aconsistent fashion as though the source pixels were first copied into a temporarybuffer and then copied from the temporary buffer to the destination.

```c
void vgCopyImage(VGImage dst, VGint dx, VGint dy,
    VGImage src, VGint sx, VGint sy,
    VGint width, VGint height,
    VGboolean dither)
```

> **_ERRORS_**
> `VG_BAD_HANDLE_ERROR`
> * if either dst or src is not a valid image handle, or is not shared with the current context
>
> `VG_IMAGE_IN_USE_ERROR`
> * if either dst or src is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height is less than or equal to 0

## 10.8 Drawing Images to the Drawing Surface
<a name="Drawing_Images_to_the_Drawing_Surface"></a>

Images may be drawn onto a drawing surface. An affine or projective transformationmay be applied while drawing. The current image and blending modes are used tocontrol how image pixels are combined with the current paint and blended into thedestination. Conversion between the image and destination pixel formats is appliedautomatically.

#### VGImageMode
<a name="VGImageMode"></a>

The `VGImageMode` enumeration is used to select between several styles of imagedrawing, described in the vgDrawImage section below.

```c
typedef enum {
  VG_DRAW_IMAGE_NORMAL = 0x1F00,
  VG_DRAW_IMAGE_MULTIPLY = 0x1F01,
  VG_DRAW_IMAGE_STENCIL = 0x1F02
} VGImageMode;
```

To set the mode, use `vgSeti` with a paramType value of `VG_IMAGE_MODE`:

```c
VGImageMode drawImageMode;
vgSeti(VG_IMAGE_MODE, drawImageMode);
```

#### vgDrawImage
<a name="vgDrawImage"></a>

An image may be drawn to the current drawing surface using the `vgDrawImage` function. The current image-user-to-surface transformation Ti is applied to the image, sothat the image pixel centered at (px + Â½, py + Â½) is mapped to the point (Ti)(px + Â½, py+ Â½). In practice, backwards mapping may be used. That is, a sample located at (x, y) inthe surface coordinate system is colored according to an interpolated image pixel valueat the point (Ti)-1(x, y) in the image coordinate system. If Ti is non-invertible (or nearlyso, within the limits of numerical accuracy), no drawing occurs.

Interpolation is done in the color space of the image. Image color values are processed inpremultiplied alpha format during interpolation. Color channel values are clamped to therange [0, alpha] before interpolation.

When a projective transformation is used (i.e., the bottom row of the image-user-tosurface transformation contains values [ w0 w1 w2 ] different from [ 0 0 1 ]), each cornerpoint (x, y) of the image must result in a positive value of d = (x*w0 + y*w1 + w2), or elsenothing is drawn. This rule prevents degeneracies due to transformed image pointspassing through infinity, which occurs when d passes through 0. By requiring d to bepositive at the corners, it is guaranteed to be positive at all interior points as well.

When a projective transformation is used, the value of the `VG_IMAGE_MODE` parameteris ignored and the behavior of `VG_DRAW_IMAGE_NORMAL` is substituted. This avoidsthe need to generate paint pixels in perspective.

The set of pixels affected consists of the quadrilateral with vertices (Ti)(0, 0), (Ti)(w, 0),(Ti)(w, h), and (Ti)(0, h) (where w and h are respectively the width and height of theimage), plus a boundary of up to 1Â½ pixels for filtering purposes.

Clipping, masking, and scissoring are applied in the same manner as with `vgDrawPath`.To limit drawing to a subregion of the image, create a child image using `vgChildImage`.

The image quality will be the maximum quality allowed by the image (as determined by the allowedQuality parameter to `vgCreateImage`) that is not higher than the currentsetting of `VG_IMAGE_QUALITY`.

```c
void vgDrawImage(VGImage image)
```

> **_ERRORS_**
>
> `VG_BAD_HANDLE_ERROR`
> * if image is not a valid image handle, or is not shared with the current context
>
> `VG_IMAGE_IN_USE_ERROR`
> * if image is currently a rendering target

The effects of `vgDrawImage` depend on the current setting of the `VG_IMAGE_MODE` parameter:

#### VG_DRAW_IMAGE_NORMAL
<a name="VG_DRAW_IMAGE_NORMAL"></a>

When the `VG_IMAGE_MODE` parameter is set to `VG_DRAW_IMAGE_NORMAL`, theimage is drawn. If the image contains an alpha channel, the alpha values associated witheach pixel are used as the source alpha values. Otherwise, the source alpha is taken to be1 at each pixel. No paint generation takes place. When a projective transformation isused, this mode is used regardless of the setting of the `VG_IMAGE_MODE` parameter.

#### VG_DRAW_IMAGE_MULTIPLY
<a name="VG_DRAW_IMAGE_MULTIPLY"></a>

When the `VG_IMAGE_MODE` parameter is set to `VG_DRAW_IMAGE_MULTIPLY`, theimage being drawn is multiplied by the paint color and alpha values. This allows theimage to be drawn translucently (by setting the paint color to R=G=B=1 and A=opacity),or to be modulated in other ways. For example, a gradient paint could be used to create afading effect, or a pattern paint could be used to vary the opacity on a pixel-by-pixelbasis. If the paint color is opaque white (R=G=B=A=1) everywhere, the results areequivalent to those of `VG_DRAW_IMAGE_NORMAL`.

Paint generation (using the `VGPaint` object defined for the `VG_FILL_PATH` paintmode) occurs at each pixel, and the interpolated image and paint color and alpha valuesare multiplied channel-by-channel. The result (considered to be in the same color spaceas the image) is used as the input to the color transform stage, the output of which is usedas the input to the current blend function, and normal blending takes place. Luminanceformats are expanded to RGB using formula (4) of section 3.4.2

Note that the use of a source image having a linear pixel format (e.g., lRGB_888) will result in a brightened output due to the fact that the paint values are not converted froms RGB to linear, yet the results are treated as linear. Therefore the use of a linear sourceimage in this mode is recommended only for special effects.

#### VG_DRAW_IMAGE_STENCIL

When the `VG_IMAGE_MODE` parameter is set to `VG_DRAW_IMAGE_STENCIL`, theimage being drawn acts as a stencil through which the current paint is applied. Thisallows an image to take the place of a geometric path definition in some cases, such asdrawing text glyphs. A special set of blending equations allows the red, green, and bluechannels to be blended using distinct alpha values taken from the image. This featureallows stencils to take advantage of sub-pixel effects on LCD displays.

Paint generation (using the `VGPaint` object defined for the `VG_FILL_PATH` paintmode) occurs at each pixel. The interpolated image and paint color and alpha values arecombined at each pixel as follows. Each image color channel value is multiplied by itscorresponding alpha value (if the image has an alpha channel) and by the paint alphavalue to produce an alpha value associated with that color channel. The current blending equation (see Section 13) is applied separately for each destination color channel, usingthe alpha value computed above as the source alpha value for the blend; the paint colorvalue is used as input to the color transform stage, the output of which is used as thesource color value for blending

In terms of the blending functions Î±(Î±src, Î±dst) and c(csrc, cdst, Î±src, Î±dst) defined inSection 13.2, the stenciled output color and alpha values for an RGB destination are:

$$
a_{tmp} = a*(a_{image}*a_{paint},a_{dst})
$$$$
R_{dst} \leftarrow c*(R_{paint},R_{dst},R_{image}*a_{image}*a_{paint}*a_{dst})/a_{tmp}
$$$$
G_{dst} \leftarrow c*(G_{paint},G_{dst},G_{image}*a_{image}*a_{paint}*a_{dst})/a_{tmp}
$$$$
B_{dst} \leftarrow c*(B_{paint},B_{dst},B_{image}*a_{image}*a_{paint}*a_{dst})/a_{tmp}
$$$$
a_{dst} \leftarrow a_{tmp}
$$

For example, if Porter-Duff â€œSrc **over** Dstâ€ blending is enabled (see Section 13.3), the destination alpha and color values are computed as:

$$
a_{tmp} = a_{image}*a_{paint}+a_{dst}*(1-a_{image}*a_{paint})
$$$$
R_{dst} \leftarrow (a_{image}*a_{paint}*R_{image}*R_{paint}+a_{dst}*R_{dst}*(1-a_{image}*a_{paint}*R_{image}))/a_{tmp}
$$$$
G_{dst} \leftarrow (a_{image}*a_{paint}*G_{image}*G_{paint}+a_{dst}*G_{dst}*(1-a_{image}*a_{paint}*G_{image}))/a_{tmp}
$$$$
B_{dst} \leftarrow (a_{image}*a_{paint}*B_{image}*B_{paint}+a_{dst}*B_{dst}*(1-a_{image}*a_{paint}*B_{image}))/a_{tmp}
$$

If the drawing surface has a luminance-only format, the pixels of the image being drawn are each converted to luminance format using formula (3) of section 3.4.2 prior to applying the stencil equations. In terms of the blending functions Î±(Î±src, Î±dst) andc(csrc, cdst, Î±src, Î±dst) defined in Section 13.2, the stenciled output luminance and alpha values for an luminance-only destination are:

ìˆ˜ì‹

10.9 Reading and Writing Drawing Surface Pixels
<a name="Reading_and_Writing_Drawing_Surface_Pixels"></a>

Several functions are provided to read and write pixels on the drawing surface directly,without applying transformations, masking, or blending. Table 13 below summarizes the `OpenVG` functions that copy between sources and destinations in application memory,`VGImage` handles, and the drawing surface.

When the source of a pixel copy operation is multisampled, and the destination is eithersingle sampled or multisampled with a different sample layout, each source pixel isresolved to a single average value prior to being written to the destination.

If the destination of a pixel copy operation is multisampled, and the source is eithersingle-sampled or multisampled with a different sample layout, the source value is eithercopied to each sample within the destination pixel, or the implementation may performdithering, i.e., write different values to each destination sample in order to ensure that theaverage value within the destination is as close as possible to the incoming value.

|Source/Dest|Memory|VGImage|Surface|
|---|---|---|---|
|Memory|n/a|vgImageSubData|vgWritePixels|
|VGImage|vgGetImageSubData|vgCopyImage|vgSetPixels|
|Surface|vgReadPixels|vgGetPixels|vgCopyPixels|
Table 13: Pixel Copy Functions

### 10.9.1 Writing Drawing Surface Pixels
<a name="Writing_Drawing_Surface_Pixels"></a>

#### vgSetPixels
<a name="vgSetPixels"></a>

The `vgSetPixels` function copies pixel data from the image src onto the drawingsurface. The image pixel (sx + i, sy + j) is copied to the drawing surface pixel (dx + i,dy + j), for 0 â‰¤ i < width and 0 â‰¤ j < height. Pixels whose source lies outside ofthe bounds of src or whose destination lies outside the bounds of the drawing surfaceare ignored. Pixel format conversion is applied as needed. Scissoring takes placenormally. Transformations, masking, and blending are not applied.

```c
void vgSetPixels(VGint dx, VGint dy,
    VGImage src, VGint sx, VGint sy,
    VGint width, VGint height)
```

> **_ERRORS_**
> `VG_BAD_HANDLE_ERROR`
> * if src is not a valid image handle, or is not shared with the current context
>
> `VG_IMAGE_IN_USE_ERROR`
> * if src is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height is less than or equal to 0

#### vgWritePixels
<a name="vgWritePixels"></a>

The vgWritePixels function allows pixel data to be copied to the drawing surfacewithout the creation of a VGImage object. The pixel values to be drawn are taken fromthe data pointer at the time of the vgWritePixels call, so future changes to the data haveno effect. The effects of changes to the data by another thread at the time of the call tovgWritePixels are undefined.

The dataFormat parameter must contain a value from the `VGImage` Format enumeration. The alignment and layout of pixels is the same as for `vgImageSubData`.

If dataFormat specifies a premultiplied format (VG_sRGBA_8888_PRE orVG_lRGBA_8888_PRE), color channel values of a pixel greater than theircorresponding alpha value are clamped to the range [0, alpha].

Pixels whose destination coordinate lies outside the bounds of the drawingsurface are ignored. Pixel format conversion is applied as needed. Scissoringtakes place normally. Transformations, masking, and blending are not applied.

```c
void vgWritePixels(const void * data, VGint dataStride,
    VGImageFormat dataFormat,
    VGint dx, VGint dy,
    VGint width, VGint height)
```

> **_ERRORS_**
>
> `VG_UNSUPPORTED_IMAGE_FORMAT_ERROR`
> * if dataFormat is not a valid value from the `VGImageFormat` enumeration
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height is less than or equal to 0
> * if data is NULL
> * if data is not properly aligned

The code:

```c
void * data;
VGImageFormat dataFormat;
VGint dataStride;
VGint dx, dy, width, height;
vgWritePixels(data, dataStride, dataFormat, dx, dy, width, height);
```

is equivalent to the code:

```c
VGImage image;
void * data;
VGImageFormat dataFormat;
VGint dataStride;
VGint dx, dy, width, height;

image = vgCreateImage(dataFormat, width, height, 0);
vgImageSubData(image, data, dataStride, dataFormat,
    0, 0, width, height);

vgSetPixels(dx, dy, image, width, height);
vgDestroyImage(image);
```

### 10.9.2 Reading Drawing Surface Pixels
<a name="Reading_Drawing_Surface_Pixels"></a>

#### vgGetPixels
<a name="vgGetPixels"></a>

The vgGetPixels function retrieves pixel data from the drawing surface into the imagedst. The drawing surface pixel (sx + i, sy + j) is copied to pixel (dx + i, dy + j) ofthe image dst, for 0 â‰¤ i < width and 0 â‰¤ j < height. Pixels whose source liesoutside of the bounds of the drawing surface or whose destination lies outside the boundsof dst are ignored. Pixel format conversion is applied as needed. The scissoring regiondoes not affect the reading of pixels.

```c
void vgGetPixels(VGImage dst, VGint dx, VGint dy,
VGint sx, VGint sy,
VGint width, VGint height)
```

> **_ERRORS_**
>
> `VG_BAD_HANDLE_ERROR`
> * if dst is not a valid image handle, or is not shared with the current context
>
> `VG_IMAGE_IN_USE_ERROR`
> * if dst is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height is less than or equal to 0

#### vgReadPixels
<a name="vgREadPixels"></a>

The `vgReadPixels` function allows pixel data to be copied from the drawing surface without the creation of a `VGImage` object.

Pixel values are written starting at the address given by the pointer data; adjacentscanlines are separated by dataStride bytes. Negative or zero values ofdataStride are allowed. The region to be read is given by x, y, width, andheight, which must define a positive region.

Pixel values in memory are formatted according to the dataFormat parameter, whichmust contain a value from the `VGImageFormat` enumeration. The data pointeralignment and the pixel layout in memory is as described in the vgImageSubDatasection.

Pixels whose source lies outside of the bounds of the drawing surface areignored. Pixel format conversion is applied as needed. The scissoring regiondoes not affect the reading of pixels.

```c
void vgReadPixels(void * data, VGint dataStride,
    VGImageFormat dataFormat,
    VGint sx, VGint sy,
    VGint width, VGint height)
```

> **_ERRORS_**
>
> `VG_UNSUPPORTED_IMAGE_FORMAT_ERROR`
> * if dataFormat is not a valid value from the `VGImageFormat` enumeration
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height is less than or equal to 0
> * if data is NULL
> * if data is not properly aligned

The code:

```c
void * data;
VGImageFormat dataFormat;
VGint dataStride;
VGint sx, sy, width, height;

vgReadPixels(data, dataStride, dataFormat, sx, sy, width, height);
```

is equivalent to the following code, assuming the specified rectangle lies completely
within the drawing surface bounds :

```c
VGImage image;
void * data;
VGint dataStride;
VGImageFormat dataFormat;
VGint sx, sy, width, height;

image = vgCreateImage(dataFormat, width, height, 0);
vgGetPixels(image, 0, 0, sx, sy, width, height);
vgGetImageSubData(image, data, dataStride, dataFormat, width, height);
vgDestroyImage(image);
```

## 10.10 Copying Portions of the Drawing Surface
<a name="Copying_Portions_of_the_Drawing_Surface"></a>

#### vgCopyPixels
<a name="vgCopyPixels"></a>

The `vgCopyPixels` function copies pixels from one region of the drawing surface toanother. Copies between overlapping regions are allowed and always produce consistentresults identical to copying the entire source region to a scratch buffer followed bycopying the scratch buffer into the destination region.

The drawing surface pixel $(sx + i, sy + j)$ is copied to pixel $(dx + i, dy + j)$ for $0 â‰¤ i < width$ and $0 â‰¤ j < height$. Pixels whose source or destination lies outside of thebounds of the drawing surface are ignored. Transformations, masking, and blending arenot applied. Scissoring is applied to the destination, but does not affect the reading of pixels.

```c
void vgCopyPixels(VGint dx, VGint dy,
    VGint sx, VGint sy,
    VGint width, VGint height)
```

> **_ERRORS_**
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if width or height is less than or equal to 0


# <a name="Chapter11"></a><a name="Text"></a> 11 Text

Several classes of applications were considered in order to determining the set of features supported by the OpenVG text rendering API. E-book readers, scalable user interfaces with text-driven menus, and SVG viewers used to display textintensive content rely on high-quality text rendering using well-hinted fonts. For these applications, the use of unhinted outlines, or the use of hardwareaccelerated glyph scaling that does not support hints, would be detrimental to application rendering quality. Gaming applications that use special custom fonts, applications where text is rotated or placed along a path, or SVG viewers where unhinted SVG fonts are specified are less sensitive to the use of unhinted fonts for text rendering and may benefit from hardware-accelerated glyph scaling. These application requirements made it clear that OpenVG must provide a fast, low-level hardware-accelerated API that is capable of supporting both hinted and unhinted vector glyph outlines, as well as glyphs represented as bitmaps.

## <a name="Chapter11.1"></a><a name="Text_Rendering"></a> _11.1 Text Rendering_

The process of text rendering involves the following steps:

- selection of a font, font style and size;
- scaling of glyphs used in a text fragment, including hint processing;
- composing the text on a page or within a text box;
- rendering of glyph outlines into bitmap images; and
- blitting of bitmap images to a frame buffer or a screen.

Font and glyph scaling is usually done once for each selected text size; however, the rendering of glyph outlines and blitting of bitmaps is repeated routinely. While caching of rendered bitmaps may improve performance of software rendering solutions, hardware acceleration of routine and repetitive tasks may significantly improve the overall performance of applications.

OpenVG provides a mechanism to allow applications to define a `VGFont` object as a collection of glyphs, where each glyph can be represented as either a `VGPath` representing either an original unhinted outline that can be scaled and rendered, or a scaled and hinted outline; or a `VGImage` representing a scaled, optionally hinted, and rendered image of a glyph. Use of a `VGImage` provides the opportunity to use hardware acceleration with bitmap fonts, or when a font size or rendering quality requirement cannot be satisfied by generic outline rendering. No further hinting is applied to image glyphs.

OpenVG can assist applications in text composition by hardware-accelerating glyph positioning calculations; however, the text layout and positioning are the responsibilities of the application.

## <a name="Chapter11.2"></a><a name="Font_Terminology"></a> _11.2 Font Terminology_

In typesetting literature, and throughout this chapter, the terms _character_ and _glyph_ are sometimes used interchangeably to refer to a single letter, number, punctuation mark, accent, or symbol in a string of text, or in a font or a typeface. In strict terms, the term â€œcharacterâ€ refers to a computer code representing the unit of text content (_e.g._, a symbol from a particular alphabet â€“ a Latin character, Chinese character, etc.) while the term â€œglyphâ€ refers to the unit of text display defining an image of a character or group of characters (ligature). Each character may be represented by many different glyphs from multiple typefaces having different styles. In complex scripts, a character can change its appearance depending on its position in a word and on adjacent characters, and can be associated with more than one glyph of the same font.

When fonts are scaled to a small size, there may not be enough pixels to display all the subtleties of the typeface design. Some features of the glyphs may be severely distorted, or may even completely disappear at small sizes. In order to make sure that the original design and legibility of a typeface is preserved, fonts typically contain additional data â€“ a set of special instructions that are executed when a font is scaled to a particular size, known as _hints_. In TrueType and OpenType font formats, the hints are special byte-code instructions that are interpreted and executed by the rasterizer. Hints allow font developers to control the alignment of the outline data points with the pixel grid of the output device to ensure that glyph outlines are always rendered faithfully to the original design.

## <a name="Chapter11.3"></a><a name="Glyph_Positioning_and_Text_Layout"></a> _11.3 Glyph Positioning and Text Layout_

Scalable fonts define glyphs using vector outlines and additional set of data, such as hinting instructions, font and glyph metrics, etc. A typical glyph would be defined as presented in Figure 23 below:

<img src="figures/figure23.PNG"/>

The glyph origin is not always located at the glyph boundary. Glyphs from various custom or script fonts may have swashes and ornamental design with the glyph origin located inside the bounding box, as can be seen (see letter 'p') in the following

<img src="figures/figure23a.PNG"/>

The complexity of text rendering and composition depends on language scripts. In many simple scripts (such as western and eastern European languages) text is composed by simply planking glyphs next to each other along the horizontal baseline. Each scaled and rendered glyph is positioned in such a way that the current glyph origin is located at the same point that is defined by the â€œadvance widthâ€, or _escapement_ of the previous character (see Figure 24 below).

<img src="figures/figure24.PNG"/>

The next glyph origin must be calculated using the escapement for the current glyph. Note that vector defined by two points [glyph_origin, escapement] must be subjected to the same matrix transformation that is applied to a glyph outline when the glyph is scaled. This operation is equivalent to calling the function:

```c
vgTranslate(escapement.x, escapement.y);
```

The glyph origin is stored in the `VG_GLYPH_ORIGIN` parameter of the OpenVG state, and is updated after drawing each glyph of sequence of glyphs.

In some cases, the text composition requires that glyph layout and positioning be adjusted along the baseline (using kerning) to account for the difference in appearance of different glyphs and to achieve uniform typographic color (optical density) of the text (see Figure 25 below).

<img src="figures/figure25.PNG"/>

When two or more language scripts are used in the same text fragment, multiple adjustments for glyph positioning may be required. For example, Latin scripts have lowercase characters that have features descending below the text baseline, while Asian scripts typically have glyphs positioned on the baseline. When combining characters from these two scripts the position of the baseline for Asian characters should be adjusted.

Some complex scripts require glyph positioning be adjusted in both directions. Figure 26 below demonstrates text layout in a complex (Arabic) script, involving diagonal writing, ligatures and glyph substitutions. A sequence of characters (right, reading right to left) is combined to form a resulting Urdu word (left) which is displayed in the â€œNastaliqâ€ style.

<img src="figures/figure26.PNG"/>

Therefore, when a text composition involves support for complex scripts, the inter-character spacing between each pair of glyphs in a text string may have to be defined using the _escapement_ for the current glyph [i], and the additional _adjustment_ vector for the pair of glyphs [i, i+1]. The new glyph origin calculation for the glyph [i+1] is equivalent to performing the following operation:

```c
vgTranslate((escapement.x[i] + adjustment.x[i]),
            (escapement.y[i] + adjustment.y[i]));
```

## <a name="Chapter11.4"></a><a name="Fonts_in_OpenVG"></a> _11.4 Fonts in OpenVG_

### <a name="Chapter11.4.1"></a><a name="VGFont_Objects_and_Glyph_Mapping"></a> _11.4.1 VGFont Objects and Glyph Mapping_

OpenVG provides `VGFont` objects to assist applications with text rendering. Each VGFont object defines a collection of glyphs. Glyphs in OpenVG can be represented either using `VGPath` or `VGImage` data. `VGFont` objects are created by an application, and can contain either a full set of glyphs or a subset of glyphs of an original font. `VGFont` objects do not contain any metric or layout information; instead, applications are responsible for all text layout operations using the information provided by the original fonts.

#### <a name="VGFont"></a> _VGFont_

A `VGFont` is an opaque handle to a font object.

```c
typedef VGHandle VGFont;
```

#### <a name="Glyph_Mapping"></a> _Glyph Mapping_

Glyphs in a VGFont are identified by a glyph index, which is an arbitrary number assigned to a glyph when it is created. This mapping mechanism is similar to the glyph mapping used in standard font formats, such as TrueType or OpenType fonts, where each glyph is assigned an index that is mapped to a particular character code using a separate mapping table. The semantics of the mapping are application-dependent. Possible mappings include:

- _Unicode character codes_

When a `VGFont` is created as a subset that supports only simple language scripts (_e.g._, Latin, with simple one-to-one character-toglyph mapping), the character code values may be used as glyph indices. This eliminates the need for an additional mapping table and simplifies text rendering â€“ a text string may be passed directly as an argument (as an array of glyph indices) to OpenVG API call
for text rendering.

- _Native font glyph indices_

OpenVG applications may re-use native glyph indices from an original TrueType or OpenType font when `VGFont` object is created â€“ this simplifies text composition and layout decisions by re-using OpenType/TrueType layout and character-to-glyph mapping tables (and any platform-supplied text composition engine).

- _Application-defined (custom) glyph indices_

OpenVG applications may assign arbitrary numbers as glyph indices. This may be beneficial for special purpose fonts that have a limited number of glyphs (_e.g._, SVG fonts).

### <a name="Chapter11.4.2"></a><a name="Managing_VGFont_Objects"></a> _11.4.2 Managing VGFont Objects_

`VGFont` objects are created and destroyed using the **vgCreateFont** and **vgDestroyFont** functions. Font glyphs may be added, deleted, or replaced after the font has been created.

#### <a name="vgCreateFont"></a> _vgCreateFont_

**vgCreateFont** creates a new font object and returns a `VGFont` handle to it. The `glyphCapacityHint` argument provides a hint as to the capacity of a `VGFont`, _i.e._, the total number of glyphs that this `VGFont` object will be required to accept. A value of 0 indicates that the value is unknown. If an error occurs during execution, `VG_INVALID_HANDLE` is returned.

```c
VGFont vgCreateFont (VGint glyphCapacityHint);
```



#### <a name="vgDestroyFont"></a> _vgDestroyFont_

**vgDestroyFont** destroys the VGFont object pointed to by the font argument.

Note that **vgDestroyFont** will not destroy underlying objects that were used to define glyphs in the font. It is the responsibility of an application to destroy all `VGPath` or `VGImage` objects that were used in a VGFont, if they are no longer in use.

```c
void vgDestroyFont (VGFont font);
```


### <a name="Chapter11.4.3"></a><a name="Querying_VGFont_Objects"></a> _11.4.3 Querying VGFont Objects_

#### <a name="VGFontParamType"></a> _VGFontParamType_

Values from the `VGFontParamType` enumeration can be used as the `paramType` argument to **vgGetParameter** to query font features. All of the parameters defined by `VGFontParamType` are read-only. In the current specification, the single value `VG_FONT_NUM_GLYPHS` is defined.

```c
typedef enum {
VG_FONT_NUM_GLYPHS = 0x2F00
} VGFontParamType;
```

Parameter                   | Datatype
----------------------------|-----------------------------
`VG_FONT_NUM_GLYPHS`        | `VGint`
_Table 14: `VGFontParamType` Datatypes_

#### <a name="Number_of_Glyphs"></a> _Number of Glyphs_

The actual number of glyphs in a font (not the hinted capacity) is queried using the `VG_FONT_NUM_GLYPHS` parameter.

```c
VGFont font;
VGint numGlyphs = vgGetParameteri(font, VG_FONT_NUM_GLYPHS);
```

### <a name="Chapter11.4.4"></a><a name="Adding_and_Modifying_Glyphs_in_VGFonts"></a> _11.4.4 Adding and Modifying Glyphs in VGFonts_

`VGFonts` are collections of glyph data and may have glyphs represented using `VGPath` objects (for vector outline fonts) or `VGImage` objects (for bitmap fonts). `VGFont` may be created for a particular target text size, where the glyphs can be defined using either scaled and hinted outlines or embedded bitmaps. The **vgSetGlyphToPath**, **vgSetGlyphToImage**, and **vgClearGlyph** functions are provided to add and/or modify glyphs in a `VGFont`.

A call to **vgSetGlyphToPath** or **vgSetGlyphToImage** increases the reference count of the provided `VGPath` or `VGImage` if the function call completes without producing an error. A call to **vgClearGlyph**, setting an existing glyph to a different `VGPath` or `VGImage`, or destroying the `VGFont` decreases the reference count for the referenced object. When the reference count of an object falls to 0, the resources of the object are released.

Applications are responsible for destroying path or image objects they have assigned as font glyphs. It is recommended that applications destroy the path or image using **vgDestroyPath** or **vgDestroyImage** immediately after setting the object as a glyph. Since path and image objects are reference counted, destroying the object will mark its handle as invalid while leaving the resource available to the `VGFont` object. This usage model will prevent inadvertent modification of path and image objects, and may allow implementations to optimize the storage and rendering of the referenced data. Applications can re-assign a new path object to the same `glyphIndex` in a font by simply calling **vgSetGlyphToPath** with the new path argument, in which case the number of glyphs remains the same.

A `VGFont` may have glyphs defined as a mix of vector outlines and bitmaps. The `VG_MATRIX_GLYPH_USER_TO_SURFACE` matrix controls the mapping from glyph coordinates to drawing surface coordinates.

Implementations may improve the quality of text rendering by applying optional auto-hinting of unhinted glyph outlines. Glyph outlines that are scaled and hinted at very small sizes may exhibit missing pixels (dropouts) when rendered in B/W mode without antialiasing. OpenVG implementations may attempt to improve the quality of B/W glyph rendering at small sizes by identifying and drawing such pixels.

It is recommended that when a path object defines the original unhinted glyph outline, the `scale` parameter of the path object should be set to a value of 1/units-per-EM to achieve the effective size of 1 pixel per EM. This allows path data to be independent of the design unit metrics and original font format, and simplifies affine transformations applied to a glyph. For example, applying an affine transform with the matrix elements $sx = sy = 12$ would result in scaling the glyph to 12 pixels (or 12 units in the surface coordinate system). Both the `glyphOrigin` and `escapement` values are scaled identically.

Original font glyphs that are vector outlines are designed in a deviceindependent coordinate system (design units). The scale of the design coordinates is determined by the EM size (defined as â€œunits-per-EMâ€) â€“ a number that represents the distance between two adjacent, non-adjusted
baselines of text.

If a path object defines a scaled and hinted glyph outline, its `scale` parameter should be set to 1. Since the process of scaling and hinting of original glyph outlines is based on fitting the outline contour's control points to the pixel grid of the destination surface, applying affine transformations to a path (other than translations mapped to the pixel grid in surface coordinate system) may reduce glyph legibility and should be avoided as much as possible.

#### <a name="vgSetGlyphToPath"></a> _vgSetGlyphToPath_

**vgSetGlyphToPath** creates a new glyph and assigns the given `path` to a glyph associated with the `glyphIndex` in a font object. The `glyphOrigin` argument defines the coordinates of the glyph origin within the path, and the `escapement` parameter determines the advance width for this glyph (see Figure 24). Both `glyphOrigin` and `escapement` coordinates are defined in the same coordinate system as the path. For glyphs that have no visual representation (_e.g._, the <space> character), a value of `VG_INVALID_HANDLE` is used for path. The reference count for the path is incremented.

The `path` object may define either an original glyph outline, or an outline that has been scaled and hinted to a particular size (in surface coordinate units); this is defined by the `isHinted` parameter, which can be used by implementation for text-specific optimizations (_e.g._, heuristic auto-hinting of unhinted outlines). When `isHinted` is equal to `VG_TRUE`, the implementation will never apply auto-hinting; otherwise, auto hinting will be applied at the implementation's discretion.

```c
void vgSetGlyphToPath(VGFont font,
                      VGuint glyphIndex,
                      VGPath path,
                      VGboolean isHinted,
                      const VGfloat glyphOrigin[2],
                      const VGfloat escapement[2]);
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
> â€“ if `font` is not a valid font handle, or is not shared with the current context
>
> â€“ if `path` is not a valid font handle or `VG_INVALID_HANDLE`, or is not shared
with the current context
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
>
> â€“ if the pointer to `glyphOrigin` or `escapement` is NULL or is not properly
aligned

#### <a name="vgSetGlyphToImage"></a> _vgSetGlyphToImage_

**vgSetGlyphToImage** creates a new glyph and assigns the given `image` into a glyph associated with the `glyphIndex` in a font object. The `glyphOrigin` argument defines the coordinates of the glyph origin within the image, and the `escapement` parameter determines the advance width for this glyph (see Figure 24). Both `glyphOrigin` and `escapement` coordinates are defined in the image coordinate system. Applying transformations to an image (other than translations mapped to pixel grid in surface coordinate system) should be avoided as much as possible. For glyphs that have no visual representation (_e.g._, the <space> character), a value of `VG_INVALID_HANDLE` is used for image. The reference count for the `image` is incremented.

```c
void vgSetGlyphToImage(VGFont font,
                       VGuint glyphIndex,
                       VGImage image,
                       const VGfloat glyphOrigin[2],
                       const VGfloat escapement[2]);
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
> â€“ if `font` is not a valid font handle, or is not shared with the current context
>
> â€“ if `image` is not a valid font handle or `VG_INVALID_HANDLE`, or is not
shared with the current context
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> â€“ if the pointer to `glyphOrigin` or `escapement` is NULL or is not properly
aligned
>
> `VG_IMAGE_IN_USE_ERROR`
>
> â€“ if `image` is currently a rendering target

#### <a name="vgClearGlyph"></a> _vgClearGlyph_

**vgClearGlyph** deletes the glyph defined by a `glyphIndex` parameter from a font. The reference count for the `VGPath` or `VGImage` object to which the glyph was previously set is decremented, and the object's resources are released if the count has fallen to 0.

```c
void vgClearGlyph (VGFont font, VGuint glyphIndex);
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
> â€“ if `font` is not a valid font handle, or is not shared with the current context
`VG_ILLEGAL_ARGUMENT_ERROR`
>
> â€“ if `glyphIndex` is not defined for the `font`

### <a name="Chapter11.4.5"></a><a name="Font_Sharing"></a> _11.4.5 Font Sharing_

Mobile platforms usually provide a limited number of resident fonts. These fonts are available for use by any application that is running on a device, and the same font could be used by more than one application utilizing OpenVG. The sharing of `VGFont` objects may increase the efficiency of using OpenVG memory and other resources.

In order for `VGFont` objects to be shared, the `VGFont` (and underlying `VGPath` and `VGImage` objects) must be bound to a shared context. In addition, applications that create a font must share the following additional information about the font object:

- the relationship between original fonts and `VGFont` objects
created by the application;
- the character subset for which a particular `VGFont` object was
created (if applicable);
- the point or "pixels per EM" size (if applicable), for which a
`VGFont` object was created; and
- the custom mapping between character codes and glyph indices
in the `VGFont` object.

In order to avoid additional complexity associated with character-to-glyph mapping, it is recommended that shared `VGFont` objects utilize character-toglyph mappings based on either Unicode or native OpenType/TrueType glyph indices., as the use of custom glyph indices requires maintaining a standalone character-to glyph mapping table for each `VGFont` object.

## <a name="Chapter11.5"></a><a name="Text_Layout_and_Rendering"></a> _11.5 Text Layout and Rendering_

OpenVG provides a dedicated glyph rendering API to assist applications in compositing, layout, and rendering of text. Implementations may apply specific optimizations for rendering of glyphs. For example, auto-hinting algorithms that attempt to â€œsnapâ€ glyph outlines to the pixel grid may be used to improve the quality of text rendering for `VGFont` objects that contain unhinted glyph outlines. Autohinting may not be appropriate for animated text or when precise glyph placement is required.

#### <a name="vgDrawGlyph"></a> _vgDrawGlyph_

**vgDrawGlyph** renders a glyph defined by the `glyphIndex` using the given `font` object. The user space position of the glyph (the point where the glyph origin will be placed) is determined by value of `VG_GLYPH_ORIGIN`.

**vgDrawGlyph** calculates the new text origin by translating the glyph origin by the escapement vector of the glyph defined by `glyphIndex`. Following the call, the `VG_GLYPH_ORIGIN` parameter will be updated with the new origin.

The `paintModes` parameter controls how glyphs are rendered. If `paintModes` is 0, neither `VGImage-`based nor `VGPath-`based glyphs are drawn. This mode is useful for determining the metrics of the glyph sequence. If `paintModes` is equal to one of `VG_FILL_PATH`, `VG_STROKE_PATH`, or (`VG_FILL_PATH` | `VG_STROKE_PATH`), path-based glyphs are filled, stroked (outlined), or both, respectively, and image-based glyphs are drawn.

When the `allowAutoHinting` flag is set to `VG_FALSE`, rendering occurs without hinting. If `allowAutoHinting` is equal to `VG_TRUE`, autohinting may be optionally applied to alter the glyph outlines slightly for better rendering quality. In this case, the escapement values will be adjusted to match the effects of hinting. Autohinting is not applied to image-based glyphs or path-based glyphs marked as `isHinted` in **vgSetGlyphToPath**.

```c
void vgDrawGlyph(VGFont font, VGuint glyphIndex,
                 VGbitfield paintModes,
                 VGboolean allowAutoHinting);
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
> â€“ if font is not a valid font handle, or is not shared with the current context
`VG_ILLEGAL_ARGUMENT_ERROR`
>
> â€“ if `glyphIndex` has not been defined for a given font object
>
> â€“ if `paintModes` is not a valid bitwise OR of values from the `VGPaintMode`
enumeration, or 0

#### <a name="vgDrawGlyphs"></a> _vgDrawGlyphs_

**vgDrawGlyphs** renders a sequence of glyphs defined by the array pointed to by `glyphIndices` using the given `font` object. The values in the `adjustments_x` and `adjustments_y` arrays define positional adjustment values for each pair of glyphs defined by the `glyphIndices` array. The `glyphCount` parameter defines the number of elements in the `glyphIndices` and `adjustments_x` and `adjustments_y` arrays. The adjustment values defined in these arrays may represent kerning or other positional adjustments required for each pair of glyphs. If no adjustments for glyph positioning in a particular axis are required (all horizontal and/or vertical adjustments are zero), `NULL` pointers may be passed for either or both of `adjustment_x` and `adjustment_y`. The adjustments values should be defined in the same coordinate system as the font glyphs; if the glyphs are defined by path objects with path data scaled (_e.g._, by a factor of 1/units-per-EM), the values in the `adjustment_x` and `adjustment_y` arrays are scaled using the same scale factor.

The user space position of the first glyph (the point where the glyph origin will be placed) is determined by the value of `VG_GLYPH_ORIGIN`.

**vgDrawGlyphs** calculates a new glyph origin for every glyph in the `glyphIndices` array by translating the glyph origin by the `escapement` vector of the current glyph, and applying the necessary positional adjustments (see Section 11.3), taking into account both the escapement values associated with the glyphs as well as the `adjustments_x` and `adjustments_y` parameters. Following the call, the `VG_GLYPH_ORIGIN` parameter will be updated with the new origin.

The `paintModes` parameter controls how glyphs are rendered. If `paintModes` is 0, neither `VGImage-`based nor `VGPath-`based glyphs are drawn. This mode is useful for determining the metrics of the glyph sequence. If `paintModes` equals `VG_FILL_PATH`, `VG_STROKE_PATH`, or `VG_FILL_PATH` | VG_STROKE_PATH, path-based glyphs are filled, stroked (outlined), or both, respectively, and image-based glyphs are drawn.

When the `allowAutoHinting` flag is set to `VG_FALSE`, rendering occurs without hinting. If `allowAutoHinting` is equal to `VG_TRUE`, autohinting may be optionally applied to alter the glyph outlines slightly for better rendering quality. In this case, the escapement values will be adjusted to match the effects of hinting.

```c
void vgDrawGlyphs(VGFont font,
                  VGint glyphCount,
                  const VGuint * glyphIndices,
                  const VGfloat * adjustments_x,
                  const VGfloat * adjustments_y,
                  VGbitfield paintModes,
                  VGboolean allowAutoHinting);
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
> â€“ if font is not a valid font handle, or is not shared with the current context
VG_ILLEGAL_ARGUMENT_ERROR
>
> â€“ if glyphCount is zero or a negative value
>
> â€“ if the pointer to the glyphIndices array is NULL or is not properly
aligned
>
> â€“ if a pointer to either of the adjustments_x or adjustments_y arrays are
non-NULL and are not properly aligned
>
> â€“ if any of the glyphIndices has not been defined in a given font object
>
> â€“ if paintModes is not a valid bitwise OR of values from the VGPaintMode
enumeration, or 0

# <a name="Chapter12"></a><a name="Image Filters"></a> 12 Image Filters

Image filters allow images to be modified and/or combined using a variety of imaging operations. Operations are carried out using a bit depth greater than or equal to the largest bit depth of the supplied images. The lower-left corners of all source and destination images are aligned. The destination area to be written is the intersection of the source and destination image areas. The entire source image area is used as the filter input. The source and destination images involved in the filter operation must not overlap (i.e., have any pixels in common within any common ancestor image). Source and destination images may have a common ancestor as long as they occupy disjoint areas within that area.

## <a name="Chapter2.1"></a><a name="Format_hormalization"></a> 12.1 _Format Normalization_

A series of steps are carried out on application-supplied source images in order to produce normalized source images for filtering. In practice, these normalizations may be combined with the filter operations themselves for efficiency.

The source pixels are converted to one of `sRGBA`, `sRGBA_PRE`, `lRGBA`, or `lRGBA_PRE` formats, as determined by the current values of the `VG_FILTER_FORMAT_PREMULTIPLIED` and `VG_FILTER_FORMAT_LINEAR` parameters. The conversions take place in the following order (equivalent to the conversion rules defined in Section 3.4):

1. Source color and alpha values are scaled linearly to lie in a [0, 1] range. The exact precision of the internal representation is implementation-dependent.
2. If the source image has premultiplied alpha, the alpha values are divided out of each source color channel, and stored for later use. If the source image has no alpha channel, an alpha value of 1 is added to each pixel.
3. If the source pixel is in a grayscale format (`lL` or `sL`), it is converted to an RGB format (`lRGB` or `sRGB`, respectively) by replication.
4. If the `VG_FILTER_FORMAT_LINEAR` parameter is set to `VG_TRUE`, and the source pixel is in non-linear format, it is converted into the corresponding linear format (`sRGBA`â†’`lRGBA`). If the `VG_FILTER_FORMAT_LINEAR` parameter is set to `VG_FALSE`, and the source pixel is in linear format, it is converted into the corresponding non-linear format (`lRGBA`â†’`sRGBA`).
5. If the `VG_FILTER_FORMAT_PREMULTIPLIED` parameter is equal to `VG_TRUE`, each source color channel is multiplied by the corresponding alpha value. Otherwise, the color channels are left undisturbed.

An implementation may collapse steps algebraically; for example, if no conversion is to take place in step 4, the division and multiplication by alpha in steps 2 and 5 may be implemented as a no-op.

The resulting pixel will be in `sRGBA`, `sRGBA_PRE`, `lRGBA`, or `lRGBA_PRE` format. The image filter then processes each of the four source channels in an identical manner, resulting in a set of filtered pixels in the same pixel format as the incoming pixels.

Finally, the filtered pixels are converted into the destination format using the normal pixel format conversion rules, as described in section 3.4. Premultiplied alpha values are divided out prior to color-space conversion, and restored afterwards if necessary. The destination channels specified by the `VG_FILTER_CHANNEL_MASK` parameter (see below) are written into the destination image.

## <a name="Chapter12.2"></a><a name="Channel_Masks"></a> _12.2 Channel Masks_

#### <a name="VGImageChannel"></a> _VGImageChannel_

All image filter functions make use of the `VG_FILTER_CHANNEL_MASK` parameter that specifies which destination channels are to be written. The parameter is supplied as a bitwise OR of values from the `VGImageChannel` enumeration. If the destination pixel format is one of `VG_sL_8`, `VG_lL_8` or `VG_BW_1` pixel format, the parameter is ignored. If the destination pixel format does not contain an alpha channel, the `VG_ALPHA` bit is ignored. Bits other than those defined by the `VGImageChannel` enumeration are ignored.

`VG_FILTER_CHANNEL_MASK` controls which color channels of the filtered image are written into the destination image. In the case where the destination image is premultiplied, and `VG_FILTER_CHANNEL_MASK` does not specify that all channels are to be written, the following steps are taken to ensure consistency:

1. If `VG_FILTER_FORMAT_PREMULTIPLIED` is enabled, the filtered color channels are clamped to the range [0, alpha], and converted into nonpremultiplied form (as described in Section 3.4)
2. The resulting color is converted into the destination color space
3. The destination is read and converted into non-premultiplied form
4. The destination channels specified by `VG_FILTER_CHANNEL_MASK` are replaced by the corresponding filtered values
5. The results are converted into premultiplied form and written to the destination image

```c
typedef enum {
  VG_RED   = (1 << 3),
  VG_GREEN = (1 << 2),
  VG_BLUE  = (1 << 1),
  VG_ALPHA = (1 << 0)
} VGImageChannel;
```

## <a name="Chapter12.3"></a><a name="Color_Combination"></a> _12.3 Color Combination_

Color channel values may be combined using the **vgColorMatrix** function, which computes output colors as linear combinations of input colors.

#### <a name="vgColorMatrix"></a> _vgColorMatrix_

The **vgColorMatrix** function computes a linear combination of color and alpha values $(R_{src}, G_{src}, B_{src}, \alpha_{src})$ from the normalized source image `src` at each pixel:

or:

$$
\left[
  \begin{matrix}
  R_{dst} \newline
  G_{dst} \newline
  B_{dst} \newline
  \alpha_{dst}
  \end{matrix}
\right] =
\left[
  \begin{matrix}
  m_{00} & m_{01} & m_{02} & m_{03} \newline
  m_{10} & m_{11} & m_{12} & m_{13} \newline
  m_{20} & m_{21} & m_{22} & m_{23} \newline
  m_{30} & m_{31} & m_{32} & m_{33}
  \end{matrix}
\right] \cdot
\left[
  \begin{matrix}
  R_{src} \newline
  G_{src} \newline
  B_{src} \newline
  \alpha_{src}
  \end{matrix}
\right] +
\left[
  \begin{matrix}
  m_{04} \newline
  m_{14} \newline
  m_{24} \newline
  m_{34}
  \end{matrix}
\right]
$$$$
R_{dst} =
m_{00}R_{src} +
m_{01}G_{src} +
m_{02}B_{src} +
m_{03}\alpha_{src} +
m_{04}
$$$$
G_{dst} =
m_{10}R_{src} +
m_{11}G_{src} +
m_{12}B_{src} +
m_{13}\alpha_{src} +
m_{14}
$$$$
B_{dst} =
m_{20}R_{src} +
m_{21}G_{src} +
m_{22}B_{src} +
m_{23}\alpha_{src} +
m_{24}
$$$$
\alpha_{dst} =
m_{30}R_{src} +
m_{31}G_{src} +
m_{32}B_{src} +
m_{33}\alpha_{src} +
m_{34}
$$

The matrix entries are supplied in the `matrix` argument in the order ${ m_{00}, m_{10}, m_{20}, m_{30}, m_{01}, m_{11}, m_{21}, m_{31}, m_{02}, m_{12}, m_{22}, m_{32}, m_{03}, m_{13}, m_{23}, m_{33}, m_{04}, m_{14}, m_{24}, m_{34} }$.

```c
void vgColorMatrix(VGImage dst, VGImage src,
                   const VGfloat * matrix)
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
â€“ if either `dst` or `src` is not a valid image handle, or is not shared with the
current context
>
> `VG_IMAGE_IN_USE_ERROR`
>
> â€“ if either dst or src is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
>
> â€“ if `src` and `dst` overlap
>
> â€“ if `matrix` is NULL
>
> â€“ if `matrix` is not properly aligned

## <a name="Chapter12.4"></a><a name="Convolution"></a> _12.4 Convolution_

The **vgConvolve**, **vgSeparableConvolve**, and vgGaussianBlur functions define destination pixels based on a weighted average of neighboring source pixels, a process known as `convolution`. The set of weights, along with their relative locations, is known as the `convolution kernel`. In the discussion below, width and `height` refer to the dimensions of the source image.

#### <a name="VG_MAX_KERNEL_SIZE"></a> _VG_MAX_KERNEL_SIZE_

The `VG_MAX_KERNEL_SIZE` parameter contains the largest legal value of the `width` and `height` parameters to the **vgConvolve** function. All implementations must define `VG_MAX_KERNEL_SIZE` to be an integer no smaller than 7. If there is no implementation-defined limit, a value of `VG_MAXINT` may be returned. The value may be retrieved by calling **vgGeti**:

```c
VGint maxKernelSize = vgGeti(VG_MAX_KERNEL_SIZE);
```

#### <a name="VG_MAX_SEPARABLE_KERNEL_SIZE"></a> _VG_MAX_SEPARABLE_KERNEL_SIZE_

The `VG_MAX_SEPARABLE_KERNEL_SIZE` parameter contains the largest legal value of the `size` parameter to the **vgSeparableConvolve** function. All implementations must define `VG_MAX_SEPARABLE_KERNEL_SIZE` to be an integer no smaller than 15. If there is no implementation-defined limit, a value of `VG_MAXINT` may be returned. The value may be retrieved by calling **vgGeti**:

```c
VGint maxSeparableKernelSize = vgGeti(VG_MAX_SEPARABLE_KERNEL_SIZE);
```

#### <a name="VG_MAX_GAUSSIAN_STD_DEVIATION"></a> _VG_MAX_GAUSSIAN_STD_DEVIATION_

The `VG_MAX_GAUSSIAN_STD_DEVIATION` parameter contains the largest legal value of the `stdDeviationX` and `stdDeviationY` parameters to the **vgGaussianBlur** function. All implementations must define `VG_MAX_GAUSSIAN_STD_DEVIATION` to be an integer no smaller than 16. If there is no implementation-defined limit, a value of `VG_MAXINT` may be returned. The value may be retrieved by calling **vgGeti**:

```c
VGint maxGaussianStdDeviation = vgGeti(VG_MAX_GAUSSIAN_STD_DEVIATION);
```

#### <a name="vgConvolve"></a> _vgConvolve_

The **vgConvolve** function applies a user-supplied convolution kernel to a normalized source image `src`. The dimensions of the kernel are given by `kernelWidth` and `kernelHeight`; the kernel values are specified as `kernelWidth*kernelHeight` `VGshorts` in column-major order. That is, the kernel entry $(i, j)$ is located at position $i*kernelHeight + j$ in the input sequence. The `shiftX` and `shiftY` parameters specify a translation between the source and destination images. The result of the convolution is multiplied by a `scale` factor, and a `bias` is added.

The output pixel $(x, y)$ is defined as:

$$
s(\sum_{0\le i\lt w}\sum_{0\le j\lt h} k_{(w-i-1),(h-j-1)}p(x+i-shiftX,y+j-shiftY))+b,
$$

where w = `kernelWidth`, h = `kernelHeight`, ki,j is the kernel element at position $(i, j), s$ is the `scale`, b is the bias, and $p(x, y)$ is the source pixel at $(x, y)$, or the result of source edge extension defined by `tilingMode`, which takes a value from the `VGTilingMode` enumeration (see Section 9.4.1). Note that the use of the kernel index $(wâ€“iâ€“1, hâ€“jâ€“1)$ implies that the kernel is rotated 180 degrees relative to the source image in order to conform to the mathematical definition of convolution when `shiftX` = w â€“ 1 and `shiftY` = h - 1. Figure 27 depicts the flipping of the kernel relative to the image pixels for a 3x3 kernel.

The operation is applied to all channels (color and alpha) independently. Version 1.1

```c
void vgConvolve(VGImage dst, VGImage src,
                VGint kernelWidth, VGint kernelHeight,
                VGint shiftX, VGint shiftY,
                const VGshort * kernel,
                VGfloat scale,
                VGfloat bias,
                VGTilingMode tilingMode)
```

<img src="figures/figure27.PNG"/>

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
> â€“ if either `dst` or `src` is not a valid image handle, or is not shared with the
current context
>
> `VG_IMAGE_IN_USE_ERROR`
>
> â€“ if either `dst` or `src` is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
>
> â€“ if `src` and `dst` overlap
>
> â€“ if `kernelWidth` or `kernelHeight` is less than or equal to 0 or greater than
>
> `VG_MAX_KERNEL_SIZE`
>
> â€“ if `kernel` is NULL
>
> â€“ if `kernel` is not properly aligned
>
> â€“ if `tilingMode` is not one of the values from the `VGTilingMode`
enumeration

#### <a name="vgSeparableConvolve"></a> _vgSeparableConvolve_

The **vgSeparableConvolve** function applies a user-supplied separable convolution kernel to a normalized source image `src`. A separable kernel is a two-dimensional kernel in which each entry $kij$ is equal to a product $kxi * kyj$ of elements from two onedimensional kernels, one horizontal and one vertical.

The lengths of the one-dimensional arrays `kernelX` and `kernelY` are given by `kernelWidth` and `kernelHeight`, respectively; the kernel values are specified as arrays of `VGshorts`. The `shiftX` and `shiftY` parameters specify a translation between the source and destination images. The result of the convolution is multiplied by a `scale` factor, and a `bias` is added.

The output pixel $(x, y)$ is defined as:



where w = `kernelWidth`, h = `kernelHeight`, $kxi$ is the one-dimensional horizontal kernel element at position $i$, $kyj$ is the one-dimensional vertical kernel element at position $j$, $s$ is the `scale`, b is the bias, and $p(x, y)$ is the source pixel at $(x, y)$, or the result of source edge extension defined by `tilingMode`, which takes a value from the `VGTilingMode` enumeration (see Section 9.4.1). Note that the use of the kernel indices $(wâ€“iâ€“1)$ and $(hâ€“jâ€“1)$ implies that the kernel is rotated 180 degrees relative to the source image in order to conform to the mathematical definition of convolution.

```c
void vgSeparableConvolve(VGImage dst, VGImage src,
                         VGint kernelWidth, VGint kernelHeight,
                         VGint shiftX, VGint shiftY,
                         const VGshort * kernelX,
                         const VGshort * kernelY,
                         VGfloat scale,
                         VGfloat bias,
                         VGTilingMode tilingMode)
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
> â€“ if either `dst` or `src` is not a valid image handle, or is not shared with the
current context
>
> `VG_IMAGE_IN_USE_ERROR`
>
> â€“ if either `dst` or `src` is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
>
> â€“ if `src` and `dst` overlap
>
> â€“ if `kernelWidth` or `kernelHeight` is less than or equal to 0 or greater than
>
> `VG_MAX_SEPARABLE_KERNEL_SIZE`
>
> â€“ if `kernelX` or `kernelY` is NULL
>
> â€“ if `kernelX` or `kernelY` is not properly aligned
>
> â€“ if `tilingMode` is not one of the values from the `VGTilingMode`
enumeration

#### <a name="vgGaussianBlur"></a> _vgGaussianBlur_

The **vgGaussianBlur** function computes the convolution of a normalized source image `src` with a separable kernel defined in each dimension by the Gaussian function $G(x, s)$:

$$G(x,s)=\frac{1}{\sqrt{2\pi s^2}}e^{-\frac{x^2}{2s^2}}$$

where $s$ is the _standard deviation_.

The two-dimensional kernel is defined by multiplying together two one-dimensional kernels, one for each axis:

$$k(x,y)=G(x,s_x)*G(y,s_y)=\frac{1}{2\pi s_xs_y}e^{-(\frac{x^2}{2s_x^2}+\frac{y^2}{2s_y^2})}$$

where $sx$ and $sy$ are the (positive) standard deviations in the horizontal and vertical directions, given by the `stdDeviationX` and `stdDeviationY` parameters respectively. This kernel has special properties that allow for very efficient implementation; for example, the implementation may use multiple passes with simple kernels to obtain the same overall result with higher performance than direct convolution. If `stdDeviationX` and `stdDeviationY` are equal, the kernel is rotationally symmetric.

Source pixels outside the source image bounds are defined by `tilingMode`, which takes a value from the `VGTilingMode` enumeration (see Section 9.4.1)

The operation is applied to all channels (color and alpha) independently.

```c
void vgGaussianBlur(VGImage dst, VGImage src,
                    VGfloat stdDeviationX,
                    VGfloat stdDeviationY,
                    VGTilingMode tilingMode)
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
> â€“ if either `dst` or `src` is not a valid image handle, or is not shared with the
current context
>
> `VG_IMAGE_IN_USE_ERROR`
>
> â€“ if either `dst` or `src` is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
>
> â€“ if `src` and `dst` overlap
>
> â€“ if `stdDeviationX` or `stdDeviationY` is less than or equal to 0 or greater
>
> than `VG_MAX_GAUSSIAN_STD_DEVIATION`
>
> â€“ if `tilingMode` is not one of the values from the `VGTilingMode`
enumeration

## <a name="Chapter12.5"></a><a name="Lookup Tables"></a> _12.5 Lookup Tables_

#### <a name="vgLookup"></a> _vgLookup_

The **vgLookup** function passes each image channel of the normalized source image `src` through a separate lookup table.

Each channel of the normalized source pixel is used as an index into the lookup table for that channel by multiplying the normalized value by 255 and rounding to obtain an 8-bit integral value. Each `LUT` parameter should contain 256 `VGubyte` entries. The outputs of the lookup tables are concatenated to form an `RGBA_8888` pixel value, which is interpreted as `lRGBA_8888`, `lRGBA_8888_PRE`, `sRGBA_8888`, or `sRGBA_8888_PRE`, depending on the values of `outputLinear` and `outputPremultiplied`.

The resulting pixels are converted into the destination format using the normal pixel format conversion rules.

```c
void vgLookup(VGImage dst, VGImage src,
              const VGubyte * redLUT,
              const VGubyte * greenLUT,
              const VGubyte * blueLUT,
              const VGubyte * alphaLUT,
              VGboolean outputLinear,
              VGboolean outputPremultiplied)
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
> â€“ if either `dst` or `src` is not a valid image handle, or is not shared with the
current context
>
> `VG_IMAGE_IN_USE_ERROR`
>
> â€“ if either `dst` or `src` is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
>
> â€“ if `src` and `dst` overlap
>
> â€“ if any pointer parameter is NULL

#### <a name="vgLookupSingle"></a> _vgLookupSingle_

The **vgLookupSingle** function passes a single image channel of the normalized source image `src`, selected by the `sourceChannel` parameter, through a combined lookup table that produces whole pixel values. Each normalized source channel value is multiplied by 255 and rounded to obtain an 8 bit integral value.

The specified `sourceChannel` of the normalized source pixel is used as an index into the lookup table. If the source image is in a single-channel grayscale (`VG_lL_8`, `VG_sL_8`, or `VG_BW_1`) or alpha-only (`VG_A_1`, `VG_A_4`, or `VG_A_8`) format, the `sourceChannel` parameter is ignored and the single channel is used. The `lookupTable` parameter should contain 256 4-byte aligned entries in an `RGBA_8888` pixel value, which is interpreted as `lRGBA_8888`, `lRGBA_8888_PRE`, `sRGBA_8888`, or `sRGBA_8888_PRE`, depending on the values of `outputLinear` and `outputPremultiplied`.

The resulting pixels are converted into the destination format using the normal pixel format conversion rules.

```c
void vgLookupSingle(VGImage dst, VGImage src,
                    const VGuint * lookupTable,
                    VGImageChannel sourceChannel,
                    VGboolean outputLinear,
                    VGboolean outputPremultiplied)
```

> ERRORS
>
> `VG_BAD_HANDLE_ERROR`
>
> â€“ if either `dst` or `src` is not a valid image handle, or is not shared with the
current context
>
> `VG_IMAGE_IN_USE_ERROR`
>
> â€“ if either `dst` or `src` is currently a rendering target
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
>
> â€“ if `src` and `dst` overlap
>
> â€“ if `src` is in an RGB pixel format and `sourceChannel` is not one of `VG_RED`,
`VG_GREEN`, `VG_BLUE` or `VG_ALPHA` from the `VGImageChannel`
enumeration
>
> â€“ if `lookupTable` is NULL
>
> â€“ if `lookupTable` is not properly aligned

# <a name="13_Color_Transformation_and_Blending"></a> 13 Color Transformation and Blending

In the final pipeline stage, the pixels from the previous pipeline stage (paint generation or image interpolation) are optionally transformed by a color transformation matrix. If image drawing is taking place using the `VG_DRAW_IMAGE_STENCIL` mode, the color transformation is applied to the incoming paint pixels.

The resulting pixels are converted into the destination color space, and blending is performed using a subset of the standard Porter-Duff blending rules [PORT84] along with several additional rules.

## <a name="Chapter13.1"></a><a name="Color_Transformation"></a> _13.1 Color Transformation_

If the `VG_COLOR_TRANSFORM` parameter is enabled, each color from the preceding pipeline stage (or the incoming paint color for the `VG_DRAW_IMAGE_STENCIL` computation) is converted to non-premultiplied form. If the color is in a luminance format, it is converted to a corresponding RGBA format. Each channel is multiplied by a per-channel scale factor, and a per-channel bias is added:

$$A^{'}=A\times S_a+B_a$$$$
R^{'}=R\times S_r+B_r$$$$
G^{'}=A\times S_g+B_g$$$$
B^{'}=A\times S_b+B_b$$


Scale and bias values are input in floating point format but are then modified as follows:

- Scale parameters are clamped to the range [-127.0, +127.0]. The precision may be reduced but it must be at least the equivalent of signed 8.8 fixed point (1 sign bit, 7 integer bits and 8 fractional bits).
- Bias parameters are clamped to the range [-1.0, +1.0]. The precision may be reduced but must be at least the equivalent of 1.8 fixed point (1 sign bit and 8 fractional bits).

The precision of the color transform computations must be at least the equivalent of 8.8 fixed point (1 sign bit, 7 integer bits and 8 fractional bits).

The results for each channel are clamped to the range [0, 1].

#### <a name="Setting_the_Color_Transformation"></a> _Setting the Color Transformation_

The color transformation is set as a vector of 8 floats, consisting of the R, G, B, and A scale factors followed by the R, G, B, and A biases:

```c
/* Sr, Sg, Sb, Sa, Br, Bg, Bb, Ba */
VGfloat values[] = { 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0 };
vgSetfv(VG_COLOR_TRANSFORM_VALUES, 8, values);
vgSeti(VG_COLOR_TRANSFORM, VG_TRUE);
```

## <a name="Chapter13.2"></a><a name="Blending_Equations"></a> _13.2 Blending Equations_

A blending mode defines an alpha blending function $\alpha (\alpha_{src}, \alpha_{dst})$ and a color blending function $c(c_{src}, c_{dst}, \alpha_{src}, \alpha_{dst})$. Given a non-premultiplied source alpha and color tuple $(R_{src}, G_{src}, B_{src}, \alpha_{src})$ and a non-premultiplied destination alpha and color tuple $(R_{dst}, G_{dst}, B_{dst}, \alpha_{dst})$, blending replaces the destination with the blended tuple $(c(R_{src}, R_{dst}, \alpha_{src}, \alpha_{dst}), c(G_{src},G_{dst},\alpha_{src},\alpha_{dst}),c(B_{src},B_{dst},\alpha_{src},\alpha_{dst}),\alpha(\alpha_{src},\alpha_{dst}))$.

If either the source or destination is stored in a premultiplied format (_i.e._, pixels are stored as tuples of the form $(\alpha *R, \alpha *G, \alpha *B, \alpha))$, the alpha value is conceptually divided out prior to applying the blending equations described above. If the destination is premultiplied, the destination color values are clamped to the range [0, alpha] when read, and the destination alpha value is multiplied into each color channel prior to storage. If the destination format does not store alpha values, an alpha value of 1 is used in place of $\alpha_{dst}$.

## <a name="Chapter13.3"></a><a name="Porter-Duff_Blending"></a> _13.3 Porter-Duff Blending_

Porter-Duff blending defines an alpha value $\alpha (\alpha_{src}, \alpha_{dst}) = \alpha_{src} * F_{src} + \alpha_{dst} * F_{dst}$ and color $c^{'}(c_{src}^{'}, c_{dst}^{'}, \alpha_{src}, \alpha_{dst}) = c_{src}^{'} * F_{src} + c_{dst}^{'} * F_{dst}$, where $F_{src}$ and $F_{dst}$ are defined by the blend mode and the source and destination alpha values according to Table 15 below and $c^{'} = \alpha*c$ is a premultiplied color value. For non-premultiplied colors, we define the equivalent formula $c(c_{src}, c_{dst}, \alpha_{src}, \alpha_{dst}) = (\alpha_{src} * c_{src} * F_{src} + \alpha_{dst} * c_{dst} * F_{dst}) / \alpha (\alpha_{src}, \alpha_{dst})$ (taking the value to be 0 where division by 0 would occur).

Porter-Duff blending modes are derived from the assumption that each additional primitive being drawn is uncorrelated with previous ones. That is, if a previously drawn primitive $p$ occupies a fraction $f_p$ of a pixel, and a new primitive $q$ occupies a fraction $f_q$, Porter-Duff blending assumes that a fraction $f_p * f_q$ of the pixel will be occupied by both primitives, a fraction $f_p - f_p * f_q = f_p(1 - f_q)$ will be occupied by $p$ only, and a fraction $f_q - f_p * f_q = f_q(1 - f_p)$ will be occupied by $q$ only. A total fraction of $f_p + f_q - f_p * f_q$ of the pixel is occupied by the union of the primitives.

**_Blend Mode_**    | $F_{src}$          |  $F_{dst}$
  :-------------:   |  :-------------:   |  :-------------:
Src                 | $1$                |  $0$
Src **over** Dst    | $1$                |  $1 - \alpha_{src}$
Dst **over** Src    | $1 - \alpha_{dst}$ |  $1$
Src **in** Dst      | $\alpha_{dst}$     |  $0$
Dst **in** Src      | $0$                |  $\alpha_{src}$
_Table 15: Porter-Duff Blending Modes_

## <a name="Chapter13.4"></a><a name="Additional_Blending_Modes"></a> _13.4 Additional Blending Modes_

A number of additional blending modes are available. These modes are a subset of the SVG image blending modes. Note that the SVG "Normal" blending mode is equivalent to the Porter-Duff "Src **over** Dst" mode described above. The additional blend modes have the following effects:

- `VG_BLEND_MULTIPLY` â€“ Multiply the source and destination colors together, producing the effect of placing a transparent filter over a background. A black source pixel forces the destination to black, while a white source pixel leaves the destination unchanged. If all alpha values are 1, this reduces to multiplying the source and destination color values.
- `VG_BLEND_SCREEN` â€“ The opposite of multiplication, producing the effect of projecting a slide over a background. A black source pixel leaves the destination unchanged, while a white source pixel forces the destination to white. If all alpha values are 1, this reduces to adding the source and destination color values, and subtracting their product.
- `VG_BLEND_DARKEN` â€“ Compute (Src **over** Dst) and (Dst **over** Src) and take the smaller (darker) value for each channel. If all alpha values are 1, this reduces to choosing the smaller value for each color channel.
- `VG_BLEND_LIGHTEN` â€“ Compute (Src **over** Dst) and (Dst **over** Src) and take the larger (lighter) value for each channel. If all alpha values are 1, this reduces to choosing the larger value for each color channel.

The new destination alpha value for the blending modes defined in this section is always equal to $\alpha (\alpha_{src}, \alpha_{dst})=\alpha_{src}+\alpha_{dst}*(1-\alpha_{src})$, as for Porter-Duff "Src **over** Dst" blending. The formulas for each additional blending mode are shown in Table 16. The right-hand column contains the pre-multiplied output values, that is, the products of the new color value $c(c_{src}, c_{dst}, \alpha_{src}, \alpha_{dst})$ and alpha value $\alpha(\alpha_{src}, \alpha_{dst})$. The source and destination color values $c_{src}$ and $c_{dst}$ are given in non-premultiplied form.

**Blend Type**          | $c'(c_{src}, c_{dst}, \alpha_{src}, \alpha_{dst})$
 :--------------------- | :--------------------------------------
 `VG_BLEND_MULTIPLY`    | $\alpha_{src} * c_{src} * (1 -\ alpha_{dst}) + \alpha_{dst} * c_{dst} * (1 - \alpha_{src}) + \alpha_{src} * c_{src} * \alpha_{dst} * c_{dst}$
 `VG_BLEND_SCREEN`      | $\alpha_{src} * c_{src} + \alpha_{dst} * c_{dst} - \alpha_{src} * c_{src} * \alpha_{dst} * c_{dst}$
 `VG_BLEND_DARKEN`      | $min(\alpha_{src} * c_{src} + \alpha_{dst} * c_{dst}  * (1 - \alpha_{src}), \alpha_{dst} * c_{dst} + \alpha_{src} * c_{src} * (1 - \alpha_{dst}))$
 `VG_BLEND_LIGHTEN`      | $max(\alpha_{src} * c_{src} + \alpha_{dst} * c_{dst} * (1 - \alpha_{src}), \alpha_{dst} * c_{dst} + \alpha_{src} * c_{src} * (1 - \alpha_{dst}))$
_Table 16: Additional Blending Equations_

## <a name="Chapter13.5"></a><a name="Additive_Blending"></a> _13.5 Additive Blending_

The Porter-Duff assumption of uncorrelated alpha described above does not hold for primitives that are known to be disjoint (for example, a set of triangles with shared vertices and edges forming a mesh, or a series of text glyphs that have been spaced according to known metrics). In these cases, we expect no portion of the pixel to be occupied by both primitives and a total fraction of $fp + fq$ to be occupied by the union of the primitives. The _additive_ blending rule may be used in this case. It sets the final alpha value of the blended pixel to the clamped sum $\alpha(\alpha_{src},\alpha_{dst})=min(\alpha_{src}+\alpha_{dst},1)$ and the color to $c(c_{src}, c_{dst})=min((\alpha_{src}*c_{src}+\alpha_{dst}*c_{dst})/min(\alpha_{src}+\alpha_{dst},1),1)$. If all alpha values are 1, this reduces to adding the values of each source color channel and clamping the result.

## <a name="Chapter13.6"></a><a name="Setting_the_Blend_Mode"></a> _13.6 Setting the Blend Mode_

#### <a name="VGBlendMode"></a> _VGBlendMode_

The `VGBlendMode` enumeration defines the possible blending modes:

```c
typedef enum {
  VG_BLEND_SRC = 0x2000,
  VG_BLEND_SRC_OVER = 0x2001,
  VG_BLEND_DST_OVER = 0x2002,
  VG_BLEND_SRC_IN = 0x2003,
  VG_BLEND_DST_IN = 0x2004,
  VG_BLEND_MULTIPLY = 0x2005,
  VG_BLEND_SCREEN = 0x2006,
  VG_BLEND_DARKEN = 0x2007,
  VG_BLEND_LIGHTEN = 0x2008,
  VG_BLEND_ADDITIVE = 0x2009
} VGBlendMode;
```
Use **vgSeti** with a parameter type of `VG_BLEND_MODE` to set the blend mode:

```c
VGBlendMode mode;
vgSeti(VG_BLEND_MODE, mode);
```
