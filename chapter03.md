<a name="chapter03"></a><a name="Constants_Functions_and_Data_Types"></a>
# 3 Constants, Functions and Data Types
OpenVG type definitions and function prototypes are found in an `openvg.h` header file, located in a VG subdirectory of a platform-specific header file location. OpenVG makes use of 8-, 16-, and 32-bit data types. A 64-bit data type is not required. If the `khronos_types.h` header file is provided, the primitive data types will be compatible across all Khronos APIs on the same platform.

## _3.1 Versioning_<a name="Versioning"></a>
The `openvg.h` header file defines constants indicating the version of the specification. Future versions will continue to define the constants for all previous versions with which they are backward compatible.

#### _OPENVG_VERSION_1_1_ <a name="OPENVG_VERSION_1_1"></a>
For the current specification, the constant `OPENVG_VERSION_1_1` is defined. The older version `OPENVG_VERSION_1_0` continues to be defined for backwards compatibility. The version may be queried at runtime using the **vgGetString** function (see Section 15.3.2).

```C
#define OPENVG_VERSION_1_0 1
#define OPENVG_VERSION_1_1 2
```

## _3.2 Primitive Data Types_<a name="Primitive_Data_Types"></a>
OpenVG defines a number of primitive data types by means of C  `typedef`s. The actual data types used are platform-specific.

#### _VGbyte_ <a name="VGbyte"></a>
`VGbyte` defines an 8-bit two’s complement signed integer, which may contain values between -128 and 127, inclusive. If `khronos_types.h` is defined, `VGbyte` will be defined as `khronos_int8_t.`

#### _VGubyte_<a name="VGubyte"></a>
`VGubyte` defines an 8-bit unsigned integer, which may contain values between 0 and 255, inclusive. If `khronos_types.h` is defined, `VGubyte` will be defined as `khronos_uint8_t.`

#### _VGshort_<a name="VGshort"></a>
`VGshort` defines a 16-bit two’s complement signed integer, which may contain values between -32768 and 32767, inclusive. If `khronos_types.h` is defined, `VGshort` will be defined as `khronos_int16_t.`

#### _VGint_<a name="VGint"></a>
`VGint` defines a 32-bit two’s complement signed integer. If `khronos_types.h` is defined, `VGint` will be defined as `khronos_int32_t.`

#### _VGuint_<a name="VGuint"></a>
`VGuint` defines a 32-bit unsigned integer. Overflow behavior is undefined. If `khronos_types.h` is defined, `VGuint` will be defined as `khronos_uint32_t`.

#### _VGbitfield_<a name="VGbitfield"></a>
`VGbitfield` defines a 32-bit unsigned integer value, used for parameters that may combine a number of independent single-bit values. A `VGbitfield` must be able to hold at least 32 bits. If `khronos_types.h` is defined, `VGbitfield` will be defined as `khronos_uint32_t`.

#### _VGboolean_<a name="VGboolean"></a>
`VGboolean` is an enumeration that only takes on the values of `VG_FALSE` (0) or `VG_TRUE` (1). Any non-zero value used as a `VGboolean` will be interpreted as `VG_TRUE`.

```C
typedef enum {
VG_FALSE = 0,
VG_TRUE = 1
} VGboolean;
```

#### _VGfloat_<a name="VGfloat"></a>
`VGfloat` defines a 32-bit IEEE 754 floating-point value. If `khronos_types.h` is defined, `VGfloat` will be defined as `khronos_float_t`.

## _3.3 Floating-Point and Integer Representations_<a name="Floating-Point_and_Integer_Representations"></a>
All floating-point values are specified in standard IEEE 754 format. However, implementations may clamp extremely large or small values to a restricted range, and internal processing may be performed with lesser precision. At least 16 bits of mantissa, 6 bits of exponent, and a sign bit must be present, allowing values from ± $2^{-30}$ to ±$2^{31}$ to be represented with a fractional precision of at least 1 in $2^{16}$.

Path data (_i.e._, vertex and control point coordinates and ellipse parameters) may be pecified in one of four formats: 8-, 16-, or 32-bit signed integers, or floating-point. Floating-point scale and bias factors are used to map the incoming integer and floatingpoint values into a desired range when path processing occurs.

Handling of special values is as follows. Positive and negative 0 values must be treated identically. Values of +Infinity, -Infinity, or `NaN` (not a number) yield unspecified results. Optionally, incoming floating-point values of `NaN` may be treated as 0, and values of +Infinity and -Infinity may be clamped to the largest and smallest available values within the implementation, respectively. Denormalized numbers may be truncated to 0. Passing any arbitrary value as input to any floating-point argument must not lead to OpenVG interruption or termination.

#### _VG_MAXSHORT_<a name="VG_MAXSHORT"></a>
The macro `VG_MAXSHORT` contains the largest positive value that may be represented by a `VGshort. VG_MAXSHORT` is defined to be equal to 215 – 1, or 32,767. The smallest negative value that may be represented by a `VGshort` is given by (– `VG_MAXSHORT` – 1), or -32,768.

#### _VG_MAXINT_<a name="VG_MAXINT"></a>
The macro `VG_MAXINT` contains the largest positive value that may be represented by a VGint. `VG_MAXINT` is defined to be equal to $2^{31}$ – 1, or 2,147,483,647. The smallest negative value that may be represented by a `VGint` is given by (`–VG_MAXINT` – 1), or -2,147,483,648.

#### _VG_MAX_FLOAT_<a name="VG_MAX_FLOAT"></a>
The parameter `VG_MAX_FLOAT` contains the largest floating-point number that will be accepted by an implementation. To query the parameter, use the **vgGetf** function with a `paramType` argument of `VG_MAX_FLOAT` (see Section 5.2). All implementations must define `VG_MAX_FLOAT` to be at least $10^{10}$.

#### _Colors_<a name="Colors"></a>
Colors in OpenVG other than those stored in image pixels (_e.g._, colors for clearing, painting, and edge extension for convolution) are represented as non-premultiplied (see Section 3.4.3) sRGBA [[sRGB99](#sRGB99)] color values. Image pixels may be defined in a number of color spaces, including sRGB, linear RGB, linear grayscale (or _luminance_) and nonlinearly coded, perceptually-uniform grayscale, in premultiplied or non-premultiplied form. Color and alpha values lie in the range [0,1] unless otherwise noted. This applies to intermediate values in the pixel pipeline as well as to application-specified values. If an alpha channel is present but has a bit depth of zero, the alpha value of each pixel is taken to be 1.

Non-linear quantities are denoted using primed (’) symbols below. [POYN03] contains an excellent discussion of the use of non-linear coding to achieve perceptual uniformity.

### _3.4.1 Linear and Non-Linear Color Representations_ <a name="Linear_and_Non-Linear_Color_Representations"></a>
In a linear color representation, the numeric values associated with a color channel value measure the rate at which light is emitted by an object, multiplied by some constant scale factor. Informally, it can be thought of as counting the number of photons emitted in a given amount of time. Linear representations are useful for computation, since light values may be added together in a physically meaningful way.

However, the human visual system responds non-linearly to the light power (“intensity”) of an image. Accordingly, many common image coding standards (_e.g._, the EXIF JPEG format used by many digital still cameras and the MPEG format used for video) utilize non-linear relationships between light power and code values. This allows a larger number of distinguishable colors to be represented in a given number of bits than is possible with a linear encoding. Common display devices such as CRTs and LCDs also emit light whose power at each pixel component is proportional to a non-linear `power function` (_i.e._, a function of the form $x^a$ where $a$ is constant) of the applied code value, whether due to the properties of analog CRT electronics or to the deliberate application of a non-linear transfer function elsewhere in the signal path. The exponent, or `gamma`, of this power function is typically between 2.2 and 2.5. OpenVG makes use of the nonlinear sRGB color specification described below.

Because linear coding of intensity fails to optimize the number of distinguishable values, 8-bit linear pixel formats suffer from poor contrast ratios and banding artifacts; their use with photographic imagery is not recommended. However, synthetic imagery generated by other APIs such as OpenGL ES that make use of linear light may require the use of linear formats. 8-bit linear coding is also appropriate for representing pseudoimages such as coverage masks that are not based on perceptual light intensity. Although computing directly with non-linear representations may lead to significant errors compared with the results of first converting to a linear representation, it is common industry practice in many imaging domains to do so. Because the cost of performing linearization on pixel values to be interpolated or blended is considered prohibitive for mobile devices in the near future, OpenVG may perform these operations directly on non-linear code values. A future version of this specification may introduce flags to force values to be converted to a linear representation prior to interpolation and blending.

### _3.4.2 Color Space Definitions_<a name="Color_Space_Definitions"></a>
The linear lRGB color space is defined in terms of the standard CIE XYZ color space [WYSZ00], following ITU Rec. 709 [ITU90] using a D65 white point:

$$ R = 3.240479 X -1.537150 Y –0.498535 Z\\
G =-0.969256X +1.875992 Y +0.041556 Z\\
B = 0.055648 X –0.204043 Y +1.057311 Z $$

The sRGB color space defines values $R_{sRGB}'$, $G_{sRGB}'$, $B_{sRGB}'$ in terms of the linear lRGB primaries by applying a gamma ($\gamma$) mapping consisting of a linear segment and an offset power function:

If $x$ ≤ 0.00304
$$\gamma(x) = 12.92 x$$
else
$$\gamma(x) = 1.0556 x1/2.4 – 0.0556$$

The inverse mapping $\gamma^1$ is defined as:

If $x$ ≤ 0.03928
$$ \gamma^{-1}(x)= x/ 12.92$$
else
$$\gamma^{-1}(x)=[(x+0.0556)/1.0556]^{2.4}$$

To convert from lRGB to sRGB, the gamma mapping is used:

$$
R_{sRGB}' = \gamma(R)\\
G_{sRGB}' =\gamma(G)\tag{1} \\
B_{sRGB}' =\gamma(B)
$$

To convert from sRGB to lRGB, the inverse gamma mapping is used:

$$
R = \gamma^{-1}(R_{sRGB}') \\
G = \gamma^{-1}(G_{sRGB}')\tag{2} \\
B = \gamma^{-1}(B_{sRGB}')
$$

Because the gamma function involves offset and scaling factors, it behaves similarly to a pure power function with an exponent of 1/2.2 (or approximately 0.45) rather than the “advertised” exponent of 1/2.4, (or approximately 0.42).

The linear grayscale (luminance) color space (which we denote as lL) is related to the linear lRGB color space by the equations:

$$ L = 0.2126 R + 0.7152 G + 0.0722 B  \\
R = G = B = L \tag{4}
$$

The perceptually-uniform grayscale color space (which we denote as sL) is related to the linear grayscale (luminance) color space by the gamma mapping:

$$
L'=\gamma (L) \tag{5}
$$

$$
L=\gamma^1 (L')\tag{6}
$$

Conversion from perceptually-uniform grayscale to sRGB is performed by replication:

$$R’ = G’ = B’ = L’\tag{7}$$

The remaining conversions take place in multiple steps, as shown in Table 2 below. The source format is indicated by the left column, and the destination format is indicated by the top row. The numbers indicate the equations from this section that are to be applied, in left-to-right order.

|Source/Dest |lRGB| sRGB |lL| sL|
| :--- | :---: | :---: | :---: | :---:|
|**lRGB** |—| 1| 3| 3,5|
|**sRGB**| 2| — |2,3| 2,3,5|
|**lL** |4 |4,1 |—| 5|
|**sL**| 7,2| 7 |6 |—|
_Table 2: Pixel Format Conversions_

### _3.4.3 Premultiplied Alpha_<a name="Premultiplied_Alpha"></a>
In _premultiplied alpha_ (or simply _premultiplied_) formats, a pixel ($R, G, B, \alpha$) is represented as ($\alpha*R$, $\alpha*G$, $\alpha*B$, $alpha$). Alpha is always coded linearly, regardless of the color space. The terms _associated alpha_ and _premultiplied alpha_ are synonymous.

In OpenVG, color interpolation takes place in premultiplied format in order to obtain correct results for translucent pixels.

### _3.4.4 Color Format Conversion_<a name="Color_Format_Conversion"></a>
Color values are converted between different formats and bit depths as follows. First, premultiplied color values are clamped to the range [0, alpha] and non-zero alpha values are divided out to obtain a non-premultiplied representation for the color.

If the source and destination color formats are of differing color spaces (_i.e._, linear RGB, sRGB, linear grayscale, perceptually-uniform grayscale), each source channel is divided by the maximum channel value to produce a number between 0 and 1. The color space conversion is performed as described above. The resulting values are then scaled by the maximum value for each destination channel.

If the source and destination formats have the same color format, but differ in the number of bits per color channel, the source value is multiplied by the quotient _($2^d – 1$)/($2^s – 1$)_ (where $d$ is the number of bits in the destination and $s$ is the number of bits in the source) and rounded to the nearest integer.

The following approximation may be used in place of exact multiplication: If the source channel has a greater number of bits than the destination, the most significant bits are preserved and the least significant bits are discarded. If the source channel has a lesser number of bits than the destination, the value is shifted left and the most significant bits are replicated in the less significant bit positions. For example, a 5-bit source value $b_4 b_3 b_2 b_1 b_0$ will be converted to an 8-bit destination value $b_4 b_3 b_2 b_1 b_0 b_4 b_3 b_2$. This rule approximates the correct result since if d = k*s for some integer k > 1 the quotient $(2^d – 1)/(2^s – 1)$ will be an integer of the form $2^{(k-1) s} + 2^{(k-2) s} + ... + 2^s + 1$, and multiplication of an s-bit value by this value will be exactly equivalent to bit replication. When the destination bit depth is not an integer multiple of the source bit depth, this rule still provides greater accuracy than other possible approximations such as padding the source with zeros or with copies of the rightmost bit.

Note that converting from a lesser to a greater number of bits and back again using either exact scaling or the approximation will result in an unchanged value. If the destination format has stored alpha, the previously saved alpha value is stored into the destination. If the destination format has premultiplied alpha, each color channel value is multiplied by the corresponding alpha value and the resulting values are clamped to the range [0, alpha].

## _3.5 Enumerated Data Types_<a name="Enumerated_Data_Types"></a>
A number of data types are defined using the C `enum` keyword. In all cases, this specification assigns each enumerated constant a particular integer value. Extensions to the specification wishing to add new enumerated values must register with the Khronos Group to receive a unique value (see Section 15).

Applications making use of extensions should cast the extension-defined integer value to the proper enumerated type.

The enumerated types (apart from `VGboolean`) defined by OpenVG are:

* `VGBlendMode`
* `VGCapStyle`
* `VGColorRampSpreadMode`
* `VGErrorCode`
* `VGFillRule`
* `VGFontParamType`
* `VGHardwareQueryResult`
* `VGHardwareQueryType`
* `VGImageChannel`
* `VGImageFormat`
* `VGImageMode`
* `VGImageParamType`
* `VGImageQuality`
* `VGJoinStyle`
* `VGMaskOperation`
* `VGMatrixMode`
* `VGPaintMode`
* `VGPaintParamType`
* `VGPaintType`
* `VGParamType`
* `VGPathAbsRel`
* `VGPathCapabilities`
* `VGPathCommand`
* `VGPathDatatype`
* `VGPathParamType`
* `VGPathSegment`
* `VGPixelLayout`
* `VGRenderingQuality`
* `VGStringID`
* `VGTilingMode`

The VGU utility library defines the enumerated types:

* `VGUArcType`
* `VGUErrorCode`

## _3.6 Handle-based Data Types_<a name="Handle_based_Data_Types"></a>
Images, paint objects, and paths are accessed using opaque _handles_. The use of handles allows these potentially large and complex objects to be stored under API control. For example, they may be stored in special memory and/or formatted in a way that is suitable for use by a hardware implementation. Handles are created relative to the current context, and may only be used as OpenVG function parameters when that context or one of its shared contexts is current.

Handles employ _reference count_ semantics; if a handle is in use by the implementation, a request to destroy the handle prevents the handle from being used further by the application, but allows it to continue to be used internally by the implementation until it is no longer referenced.

#### _VGHandle_<a name="VGHandle"></a>
Handles make use of the `VGHandle` data type. For reasons of binary compatibility between different OpenVG implementations on a given platform, a `VGHandle` is defined as a `VGuint`.
```C
typedef VGuint VGHandle;
```
Live handles to distinct objects must compare as unequal using the C == (double equals) operator.

The `VGHandle` subtypes defined in the API are:
* `VGFont` – a reference to font data (see Section 11)
* `VGImage` – a reference to image data (see Section 10)
* `VGMaskLayer` – a reference to mask data (see Section 7.2)
* `VGPaint` – a reference to a paint specification (see Section 9)
* `VGPath` – a reference to path data (see Section 8)

#### _VG_INVALID_HANDLE_ <a name="VG_INVALID_HANDLE"></a>
The symbol `VG_INVALID_HANDLE` represents an invalid `VGHandle` that is used as an error return value from functions that return a `VGHandle`. `VG_INVALID_HANDLE` is defined as (`VGHandle`)0.
```C
#define VG_INVALID_HANDLE ((VGHandle)0)
```
<div style="page-break-after: always;"></div>
