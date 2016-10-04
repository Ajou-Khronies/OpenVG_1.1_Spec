**written to** values.
```C
VGfloat vgGetf (VGParamType paramType)
VGint   vgGeti (VGParamType paramType)
VGint   vgGetVectorSize(VGParamType paramType)
void    vgGetfv(VGParamType paramType, VGint count, VGfloat * values)
void    vgGetiv(VGParamType paramType, VGint count, VGint * values)
```

>_**ERRORS**_
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>
>– if `paramType` is not a valid value from the `VGParamType` enumeration
>
>– if `paramType` refers to a vector parameter in **vgGetf** or **vgGeti**
>
>– if `values` is `NULL` in **vgGetfv** or **vgGetiv**
>
>– if `values` is not properly aligned in **vgGetfv** or **vgGetiv**
>
>– if `count` is less than or equal to 0 in **vgGetfv** or **vgGetiv**
>
>– if `count` is greater than the value returned by **vgGetVectorSize** for the given parameter in **vgGetfv** or **vgGetiv**

###_5.2.1 Default Context Parameter Values_
<a name=“Default Context Parameter Values_”></a>
When a new OpenVG context is created, it contains default values as shown in Table 4. Note that some tokens have been split across lines for reasons of space.

Parameter | Datatype | Default Value
----------|----------|--------------
VG_MATRIX_MODE|VGMatrixMode|VG_MATRIX_PATH_USER_TO_SURFACE
VG_FILL_RULE|VGFillRule|VG_EVEN_ODD
VG_IMAGE_QUALITY|VGImageQuality|VG_IMAGE_QUALITY_FASTER
VG_RENDERING_QUALITY|VGRendering Quality|VG_RENDERING_QUALITY_BETTER
VG_BLEND_MODE|VGBlendMode|VG_BLEND_SRC_OVER
VG_IMAGE_MODE|VGImageMode|VG_DRAW_IMAGE_NORMAL
VG_SCISSOR_RECTS|VGint *|{ } (array of length 0)
VG_COLOR_TRANSFORM|VGboolean|VG_FALSE (disabled)
VG_COLOR_TRANSFORM_VALUES|VGfloat[8]|{ 1.0f, 1.0f, 1.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f }
VG_STROKE_LINE_WIDTH|VGfloat|1.0f
VG_STROKE_CAP_STYLE|VGCapStyle|VG_CAP_BUTT
VG_STROKE_JOIN_STYLE|VGJoinStyle|VG_JOIN_MITER
VG_STROKE_MITER_LIMIT|VGfloat|4.0f
VG_STROKE_DASH_PATTERN|VGfloat *|{ } (array of length 0) (disabled)
VG_STROKE_DASH_PHASE|VGfloat|0.0f
VG_STROKE_DASH_PHASE_ RESET|VGboolean|VG_FALSE (disabled)
VG_TILE_FILL_COLOR|VGfloat[4]|{ 0.0f, 0.0f, 0.0f, 0.0f }
VG_CLEAR_COLOR|VGfloat[4]|{ 0.0f, 0.0f, 0.0f, 0.0f }
VG_GLYPH_ORIGIN|VGfloat[2]|{ 0.0f, 0.0f }
VG_MASKING|VGboolean|VG_FALSE (disabled)
VG_SCISSORING|VGboolean|VG_FALSE (disabled)
VG_PIXEL_LAYOUT|VGPixelLayout|VG_PIXEL_LAYOUT_UNKNOWN
VG_SCREEN_LAYOUT|VGPixelLayout|Layout of the drawing surface
VG_FILTER_FORMAT_LINEAR|VGboolean|VG_FALSE (disabled)
VG_FILTER_FORMAT_PREMULTIPLIED |VGboolean|VG_FALSE (disabled)
VG_FILTER_CHANNEL_MASK|VGbitfield|(VG_RED  \| VG_GREEN \| VG_BLUE \| VG_ALPHA)
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
>
>– if object is not a valid handle, or is not shared with the current context `VG_ILLEGAL_ARGUMENT_ERROR`
>
>– if paramType is not a valid value from the appropriate enumeration
>
>– if paramType refers to a vector parameter in **vgSetParameterf** or **vgSetParameteri**
>
>– if paramType refers to a scalar parameter in **vgSetParameterfv** or **vgSetParameteriv** and count is not equal to 1
>
>– if value is not a legal enumerated value for the given parameter in **vgSetParameterf** or **vgSetParameteri**, or if values[i] is not a legal enumerated value for the given parameter in **vgSetParameterfv** or **vgSetParameteriv** for 0 ≤ i < count
>
>– if values is NULL in **vgSetParameterfv** or **vgSetParameteriv** and count is greater than 0
>
>– if values is not properly aligned in **vgSetParameterfv** or **vgSetParameteriv**
>
>– if count is less than 0 in vgSetParameterfv or vgSetParameteriv
>
>– if count is not a valid value for the given parameter

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

>ERRORS
>
>VG_BAD_HANDLE_ERROR
>
>– if object is not a valid handle, or is not shared with the current context
>
>VG_ILLEGAL_ARGUMENT_ERROR
>
>– if *paramType* is not a valid value from the appropriate enumeration
>
>– if *paramType* refers to a vector parameter in **vgGetParameterf** or **vgGetParameteri**
>
>– if values is NULL in **vgGetParameterfv** or **vgGetParameteriv**
>
>– if values is not properly aligned in **vgGetParameterfv** or **vgGetParameteriv**
>
>– if count is less than or equal to 0 in **vgGetParameterfv* or **vgGetParameteriv**
>
>– if count is greater than the value returned by **vgGetParameterVectorSize** for the given parameter in **vgGetParameterfv** or **vgGetParameteriv**
