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

>ERRORS
>
>`VG_BAD_HANDLE_ERROR`
>
>– if operation is not `VG_CLEAR_MASK` or `VG_FILL_MASK`, and mask is not a valid mask layer or image handle, or is not shared with the current context `VG_IMAGE_IN_USE_ERROR`
>
>– if mask is a `VGImage` that is currently a rendering target `VG_ILLEGAL_ARGUMENT_ERROR`
>
>– if `operation` is not a valid value from the `VGMaskOperation` enumeration
>
>– if `width` or `height` is less than or equal to 0
>
>– if `mask` is a `VGMaskLayer` and is not compatible with the current surface mask

####_vgRenderToMask_
<a name="vgRenderToMask"></a>
The **vgRenderToMask** function modifies the current surface mask by applying the given `operation` to the set of coverage values associated with the rendering of the given `path`. If `paintModes` contains `VG_FILL_PATH`, the path is filled; if it contains `VG_STROKE_PATH`, the path is stroked. If both are present, the mask `operation` is performed in two passes, first on the filled path geometry, then on the stroked path geometry.

Conceptually, for each pass, an intermediate single-channel image is initialized to 0, then filled with those coverage values that would result from the first four stages of the OpenVG pipeline (_i.e.,_ state setup, stroked path generation if applicable, transformation, and rasterization) when drawing a path with **vgDrawPath** using the given set of paint modes and all current OpenVG state settings that affect path rendering (scissor rectangles, rendering quality, fill rule, stroke parameters, etc.). Paint settings (e.g., paint matrices) are ignored. Finally, the drawing surface mask is modified as though **vgMask** were called using the intermediate image as the mask parameter. Changes to path following this call do not affect the mask. If operation is `VG_CLEAR_MASK` or `VG_FILL_MASK`, path is ignored and the entire mask is affected.

An implementation that supports geometric clipping of primitives may cache the contents of `path` and make use of it directly when primitives are drawn, without generating a rasterized version of the clip mask. Other implementation-specific optimizations may be used to avoid materializing a full intermediate mask image.

```
 void vgRenderToMask(VGPath path, VGbitfield paintModes,
                    VGMaskOperation operation)
```

>ERRORS
>
>`VG_BAD_HANDLE_ERROR`
>
>– if `path` is not a valid path handle `VG_ILLEGAL_ARGUMENT_ERROR`
>
>– if `paintModes` is not a valid bitwise OR of values from the `VGPaintMode` enumeration
>
>– if `operation` is not a valid value from the `VGMaskOperation` enumeration

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

>ERRORS
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>
>– if `width` or `height` are less than or equal to 0
>
>– if `width` is greater than `VG_MAX_IMAGE_WIDTH`
>
>– if `height` is greater than `VG_MAX_IMAGE_HEIGHT`
>
>– if `width*height` is greater than `VG_MAX_IMAGE_PIXELS`

####_vgDestroyMaskLayer_
<a name="vgDestroyMaskLayer"></a>

The resources associated with a mask layer may be deallocated by calling **vgDestroyMaskLayer**. Following the call, the maskLayer handle is no longer valid in the current context.

```
void vgDestroyMaskLayer(VGMaskLayer maskLayer)
```

>**ERRORS**
>
>`VG_BAD_HANDLE_ERROR`
>
>– if `maskLayer` is not a valid mask handle

####_vgFillMaskLayer_
<a name="vgFillMaskLayer"></a>

The `vgFillMaskLayer` function sets the values of a given `maskLayer` within a given rectangular region to a given value. The floating-point value value must be between 0 and 1. The value is rounded to the closest available value supported by the mask layer. If two values are equally close, the larger value is used.

```
void vgFillMaskLayer(VGMaskLayer maskLayer,
                     VGint x, VGint y, VGint width, VGint height,
                     VGfloat value)
```
>ERRORS
>
>`VG_BAD_HANDLE_ERROR`
>
>– if `maskLayer` is not a valid mask layer handle, or is not shared with the current context
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>
>– if `value` is less than 0 or greater than 1
>
>– if `width` or `height` is less than or equal to 0
>
>– if `x` or `y` is less than 0
>
>– if `x + width` is greater than the width of the mask
>
>– if `y + height` is greater than the height of the mask

####_vgCopyMask_
<a name="vgCopyMask"></a>
**vgCopyMask** copies a portion of the current surface mask into a `VGMaskLayer` object. The source region starts at $(sx, sy)$ in the surface mask, and the destination region starts at $(dx, dy)$ in the destination `maskLayer`. The copied region is clipped to the given `width` and `height` and the bounds of the source and destination. If the current context does not contain a surface mask, **vgCopyMask** does nothing.

```
   void vgCopyMask(VGMaskLayer maskLayer,
                VGint dx, VGint dy, VGint sx, VGint sy,
                VGint width, VGint height)
```

>ERRORS
>
>`VG_BAD_HANDLE_ERROR`
>
>– if maskLayer is not a valid mask layer handle
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>
>– if `width` or `height` are less than or equal to 0
>
>– if `maskLayer` is not compatible with the current surface mask

##_7.3 Fast Clearing_
<a name="Fast Clearing"></a>
The **vgClear** function allows a region of pixels to be set to a single color with a single call.

####_vgClear_
<a name="vgClear"></a>
The **vgClear** function fills the portion of the drawing surface intersecting the rectangle extending from pixel $(x, y)$ and having the given `width` and `height` with a constant color value, taken from the `VG_CLEAR_COLOR` parameter. The color value is expressed in non-premultiplied sRGBA (sRGB color plus alpha)format. Values outside the $[0, 1]$ range are interpreted as the nearest endpoint of the range. The color is converted to the destination color space in the same manner as if a rectangular path were being filled. Clipping and scissoring take place in the usual fashion, but antialiasing, masking, and blending do not occur.

```
void vgClear(VGint x, VGint y, VGint width, VGint height)
```

>ERRORS
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>
>– if `width` or `height` is less than or equal to 0

For example, to set the entire drawing surface with dimensions `WIDTH` and `HEIGHT` to an opaque yellow color, the following code could be used:

```
VGfloat color[4] = { 1.0f, 1.0f, 0.0f, 1.0f }; /* Opaque yellow */
vgSeti(VG_SCISSORING, VG_FALSE);
vgSetfv(VG_CLEAR_COLOR, 4, color);
vgClear(0, 0, WIDTH, HEIGHT);

```
