# 5 Setting API Parameters <a name="chapter05"></a><a name="Setting_API_Parameters"></a>
API parameters may be set and retrieved using generic _get_ and _set_ functions. The use of generic functions allows for extensibility of the API without the addition of additional functions. Extensions may receive unique identifier values for new parameter types by registering with the Khronos group.

Parameters take two forms: some are set relative to a rendering context, and others are set on a particular `VGHandle`-based object. The former make use of the **vgSet** and **vgGet** functions and the latter make use of the **vgSetParameter** and **vgGetParameter** functions.

## _5.1 Context Parameter Types_ <a name="Context_Parameter_Types"></a>
Parameter types that are set on a rendering context are defined in the `VGParamType` enumeration. The datatype and default value associated with each parameter is shown in Table 4.

#### _VGParamType_ <a name="VGParam_Type"></a>
The `VGParamType` enumeration defines the parameter type of the value to be set or retrieved using **vgSet** and **vgGet**:
```
typedef enum {
  /* Mode settings */
  VG_MATRIX_MODE                            = 0x1100,
  VG_FILL_RULE                              = 0x1101,
  VG_IMAGE_QUALITY                          = 0x1102,
  VG_RENDERING_QUALITY                      = 0x1103,
  VG_BLEND_MODE                             = 0x1104,
  VG_IMAGE_MODE                             = 0x1105,

  /* Scissoring rectangles */
  VG_SCISSOR_RECTS                          = 0x1106,

  /* Color Transformation */
  VG_COLOR_TRANSFORM                        = 0x1170,
  VG_COLOR_TRANSFORM_VALUES                 = 0x1171,

  /* Stroke parameters */
  VG_STROKE_LINE_WIDTH                      = 0x1110,
  VG_STROKE_CAP_STYLE                       = 0x1111,
  VG_STROKE_JOIN_STYLE                      = 0x1112,
  VG_STROKE_MITER_LIMIT                     = 0x1113,
  VG_STROKE_DASH_PATTERN                    = 0x1114,
  VG_STROKE_DASH_PHASE                      = 0x1115,
  VG_STROKE_DASH_PHASE_RESET                = 0x1116,

  /* Edge fill color for VG_TILE_FILL tiling mode */
  VG_TILE_FILL_COLOR                        = 0x1120,

  /* Color for vgClear */
  VG_CLEAR_COLOR                            = 0x1121,

  /* Glyph origin */
  VG_GLYPH_ORIGIN                           = 0x1122,

  /* Enable/disable masking and scissoring */
  VG_MASKING                                = 0x1130,
  VG_SCISSORING                             = 0x1131,

  /* Pixel layout information */
  VG_PIXEL_LAYOUT                           = 0x1140,
  VG_SCREEN_LAYOUT                          = 0x1141,

  /* Source format selection for image filters */
  VG_FILTER_FORMAT_LINEAR                   = 0x1150,
  VG_FILTER_FORMAT_PREMULTIPLIED            = 0x1151,

  /* Destination write enable mask for image filters */
  VG_FILTER_CHANNEL_MASK                    = 0x1152,

  /* Implementation limits (read-only) */
  VG_MAX_SCISSOR_RECTS                      = 0x1160,
  VG_MAX_DASH_COUNT                         = 0x1161,
  VG_MAX_KERNEL_SIZE                        = 0x1162,
  VG_MAX_SEPARABLE_KERNEL_SIZE              = 0x1163,
  VG_MAX_COLOR_RAMP_STOPS                   = 0x1164,
  VG_MAX_IMAGE_WIDTH                        = 0x1165,
  VG_MAX_IMAGE_HEIGHT                       = 0x1166,
  VG_MAX_IMAGE_PIXELS                       = 0x1167,
  VG_MAX_IMAGE_BYTES                        = 0x1168,
  VG_MAX_FLOAT                              = 0x1169,
  VG_MAX_GAUSSIAN_STD_DEVIATION             = 0x116A
} VGParamType;
```
## _5.2 Setting and Querying Context Parameter values_ <a name="Setting_and_Querying_Context_Parameter_Values"></a>
Each **vgGet**/**vgGetParameter** or vgSet/vgSetParameter function has four variants, depending on the data type of the value being set, differentiated by a suffix: **i** for scalar integral values, **f** for scalar floating-point values, and **iv** and **fv** for vectors of integers and floating-point values, respectively. The vector variants may also be used to set scalar values using a `count` of 1. When setting a value of integral type using a floating-point **vgSet** variant (ending with **f** or **fv**), or retrieving a floating-point value using an integer **vgGet** function (ending with **i** or **iv**), the value is converted to an integer using a mathematical _floor_ operation. If the resulting value is outside the range of integer values, the closest valid integer value is substituted.

The `count` parameter used by the array variants (ending with **iv** or **fv**) limits the number of values that are read from the `values` array parameter. For parameters that require a fixed number of values (_e.g._, color values of type `VGfloat[4]`), `count` must have the appropriate value. For parameters that place restrictions on the number of values that may be accepted (_e.g._, that it be a multiple of a specific number, as for scissor rectangles which are specified as a set of 4-tuples), `count` must obey the restriction. For parameters that accept an arbitrary number of values up to some maximum number (_e.g._, dash patterns) , all `count` specified values up to the maximum are used and values beyond the maximum are ignored. If the count parameter is 0, the pointer argument is not dereferenced. For example, the call `vgSet(VG_STROKE_DASH_PATTERN, 0, (void *) 0)` sets the dash pattern to a zero-length array (which has the effect of disabling dashing) without dereferencing the third parameter. If an error occurs due to an inappropriate value of `count`, the call has no effect on the parameter value.

Certain parameter values are read-only. Calling **vgSet** or **vgSetParameter** on these values has no effect.

#### _vgSet_ <a name="vgSet"></a>
The **vgSet** functions set the value of a parameter on the current context.
```C
void vgSetf (VGParamType paramType, VGfloat value)
void vgSeti (VGParamType paramType, VGint value)
void vgSetfv(VGParamType paramType, VGint count,
             const VGfloat * values)
void vgSetiv(VGParamType paramType, VGint count,
             const VGint * values)
```
>**ERRORS**
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>* if paramType is not a valid value from the VGParamType enumeration
>* if paramType refers to a vector parameter in vgSetf or vgSeti
>* if paramType refers to a scalar parameter in vgSetfv or vgSetiv and count is not equal to 1
>* if value is not a legal enumerated value for the given parameter in vgSetf or vgSeti, or if values[i] is not a legal enumerated value for the given parameter in vgSetfv or vgSetiv for 0 ≤ i < count
>* if values is NULL in vgSetfv or vgSetiv and count is greater than 0
>* if values is not properly aligned in vgSetfv or vgSetiv
>* if count is less than 0 in vgSetfv or vgSetiv
>* if count is not a valid value for the given parameter

For example, to set the blending mode to the integral value `VG_BLEND_SRC_OVER` (see Section 13.6), the application would call:
```C
vgSeti(`VG_BLEND_MODE`, `VG_BLEND_SRC_OVER`);
```

#### _vgGet and vgGetVectorSize_ <a name="vgGet_and_vgGetVectorSize"></a>
The **vgGet** functions return the value of a parameter on the current context.

The **vgGetVectorSize** function returns the maximum number of elements in the vector that will be retrieved by the **vgGetiv** or **vgGetfv** functions if called with the given paramType argument. For scalar values, 1 is returned. If **vgGetiv** or **vgGetfv** is called with a smaller value for count than that returned by **vgGetVectorSize**, only the first count elements of the vector are retrieved. Use of a greater value for count will result in an error.


The original value passed to **vgSet** (except as specifically noted, and provided the call to **vgSet** completed without error) is returned by **vgGet**, even if the implementation makes use of a truncated or quantized value internally. This rule ensures that OpenVG state may be saved and restored without degradation.

If an error occurs during a call to **vgGetf**, **vgGeti**, or **vgGetVectorSize**, the return value is undefined. If an error occurs during a call to **vgGetfv** or **vgGetiv**, nothing is written to `values`.
```C
VGfloat vgGetf (VGParamType paramType)
VGint   vgGeti (VGParamType paramType)

VGint   vgGetVectorSize(VGParamType paramType)

void    vgGetfv(VGParamType paramType, VGint count, VGfloat * values)
void    vgGetiv(VGParamType paramType, VGint count, VGint * values)
```

>**ERRORS**
>
>`VG_ILLEGAL_ARGUMENT_ERROR`
>* if `paramType` is not a valid value from the `VGParamType` enumeration
>* if `paramType` refers to a vector parameter in **vgGetf** or **vgGeti**
>* if `values` is NULL in **vgGetfv** or **vgGetiv**
>* if `values` is not properly aligned in **vgGetfv** or **vgGetiv**
>* if `count` is less than or equal to 0 in **vgGetfv** or **vgGetiv**
>* if `count` is greater than the value returned by **vgGetVectorSize** for the given parameter in **vgGetfv** or **vgGetiv**

### _5.2.1 Default Context Parameter values_ <a name="Default_Context_Parameter_Values"></a>
When a new OpenVG context is created, it contains default values as shown in Table 4. Note that some tokens have been split across lines for reasons of space.

|Parameter| Datatype| DefaultValue|
|---|---|---|
|`VG_MATRIX_MODE`| `VGMatrixMode`|`VG_MATRIX_PATH_USER_ TO_SURFACE` |
|`VG_FILL_RULE` |`VGFillRule` |`VG_EVEN_ODD` |
|`VG_IMAGE_QUALITY` |`VGImageQuality`| `VG_IMAGE_QUALITY_FASTER` |
|`VG_RENDERING_QUALITY` |`VGRendering Quality`| `VG_RENDERING_QUALITY_BETTER`|
| `VG_BLEND_MODE` |`VGBlendMode` |`VG_BLEND_SRC_OVER`|
| `VG_IMAGE_MODE` |`VGImageMode`| `VG_DRAW_IMAGE_NORMAL`|
|`VG_SCISSOR_RECTS` |`VGint *` |{ } (array of length 0) |
|`VG_COLOR_TRANSFORM`| `VGboolean` |`VG_FALSE` (disabled)|
| `VG_COLOR_TRANSFORM_VALUES`| `VGfloat[8]`| { 1.0f, 1.0f, 1.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f } |
|`VG_STROKE_LINE_WIDTH` |`VGfloat` |1.0f |
|`VG_STROKE_CAP_STYLE` |`VGCapStyle` |`VG_CAP_BUTT`|
| `VG_STROKE_JOIN_STYLE` |`VGJoinStyle` |`VG_JOIN_MITER` |
|`VG_STROKE_MITER_LIMIT`| `VGfloat`| 4.0f |
|`VG_STROKE_DASH_PATTERN` |`VGfloat *`| { } (array of length 0) (disabled)|
| `VG_STROKE_DASH_PHASE` |`VGfloat`| 0.0f|
| `VG_STROKE_DASH_PHASE_ RESET` |`VGboolean` |`VG_FALSE` (disabled)|
| `VG_TILE_FILL_COLOR`| `VGfloat[4]` |{ 0.0f, 0.0f, 0.0f, 0.0f }|
| `VG_CLEAR_COLOR` |`VGfloat[4]` |{ 0.0f, 0.0f, 0.0f, 0.0f }|
| `VG_GLYPH_ORIGIN` |`VGfloat[2]`| { 0.0f, 0.0f }|
| `VG_MASKING`| `VGboolean` |`VG_FALSE` (disabled)|
| `VG_SCISSORING` |`VGboolean` |`VG_FALSE` (disabled)|
| `VG_PIXEL_LAYOUT` |`VGPixelLayout`| `VG_PIXEL_LAYOUT_UNKNOWN`|
| `VG_SCREEN_LAYOUT`| `VGPixelLayout` |Layout of the drawing surface|
| `VG_FILTER_FORMAT_LINEAR` |`VGboolean`| `VG_FALSE` (disabled)|
| `VG_FILTER_FORMAT_ PREMULTIPLIED`| `VGboolean`| `VG_FALSE` (disabled) |
|`VG_FILTER_CHANNEL_MASK`| `VGbitfield`| (`VG_RED`  \|` VG_GREEN` \| `VG_BLUE` \| `VG_ALPHA`) |

_Table 4: Default Parameter Values for a Context_

The read-only parameter values `VG_MAX_SCISSOR_RECTS`,
`VG_MAX_DASH_COUNT, VG_MAX_KERNEL_SIZE, VG_MAX_SEPARABLE_KERNEL_SIZE, VG_MAX_GAUSSIAN_STD_DEVIATION, VG_MAX_COLOR_RAMP_STOPS, VG_MAX_IMAGE_WIDTH, VG_MAX_IMAGE_HEIGHT, VG_MAX_IMAGE_PIXELS, VG_MAX_IMAGE_BYTES,` and `VG_MAX_FLOAT` are initialized to implementation-defined values.

The `VG_SCREEN_LAYOUT` parameter is initialized to the current layout of the display device containing the current drawing surface, if applicable.

The matrices for matrix modes `VG_MATRIX_PATH_USER_TO_SURFACE, VG_MATRIX_IMAGE_USER_TO_SURFACE, VG_MATRIX_GLYPH_USER_TO_SURFACE, VG_MATRIX_FILL_PAINT_TO_USER,` and `VG_MATRIX_STROKE_PAINT_TO_USER` are initialized to the identity matrix (see Section 6.5):

$\begin{bmatrix} sh & shx & tx \\
 shy & sy & ty \\ w_0 & w_1 & w_2 \end{bmatrix} = \begin{bmatrix} 1 & 0 & 0 \\
 0 & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}$

 By default, no paint object is set for filling or stroking paint modes. The default paint parameter values are used instead, as described in Section 9.1.3.

 ## _5.3 Setting and Querying Object Parameter Values_ <a name="Setting_and_Querying_Object_Parameter_Values"></a>
 Objects that are referenced using a `VGHandle` (_i.e.,_ `VGImage, VGPaint, VGPath, VGFont,` and `VGMaskLayer` objects) may have their parameters set and queried using a number of **vgSetParameter** and **vgGetParameter** functions. The semantics of these functions (including the handling of invalid count values) are similar to those of the **vgGet** and **vgSet** functions.

 #### _vgSetParameter_ <a name = "vgSetParameter"></a>
 The **vgSetParameter** functions set the value of a parameter on a given `VGHandle-` based `object`.

 ```C
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

####_vgGetParameter and vgGetParameterVectorSize_ <a name="vgGetParameter_and_vgGetParameterVectorSize"></a>
The **vgGetParameter** functions return the value of a parameter on a given `VGHandle-` based object.

The **vgGetParameterVectorSize** function returns the number of elements in the vector that will be returned by the **vgGetParameteriv** or **vgGetParameterfv** functions if called with the given paramType argument. For scalar values, 1 is returned. If **vgGetParameteriv** or **vgGetParameterfv** is called with a smaller value for count than that returned by **vgGetParameterVectorSize**, only the first count elements of the vector are retrieved. Use of a greater value for count will result in an error.

The original value passed to **vgSetParameter** (provided the call to **vgSetParameter** completed without error) should be returned by **vgGetParameter** (except where specifically noted), even if the implementation makes use of a truncated or quantized value internally.

If an error occurs during a call to **vgGetParameterf**, **vgGetParameteri**, or **vgGetParameterVectorSize**, the return value is undefined. If an error occurs during a call to **vgGetParameterfv** or **vgGetParameteriv**, nothing is written to values.
```C
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

<div style="page-break-after: always;"> </div>
