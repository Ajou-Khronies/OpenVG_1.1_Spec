# 21 Document History
<a name="chapter21"> </a> <a name="Document_History"> </a>
Version 1.1 ratified December 2008

Changes from version 1.0.1 to version 1.1 (by section number):
* 3.4 - intermediate pipeline values are clamped
* 3.5 - add `VGFontParamType` types
* 3.6 - add `VGFont` handle type
* 5.2.1 - add `VG_GLYPH_ORIGIN` and `VG_MATRIX_GLYPH_USER_TO_SURFACE`
* 6.6 - add `VG_MATRIX_GLYPH_USER_TO_SURFACE` to `VGMatrixMode`
* 7.2 - add Mask and Mask Layer functions and datatypes
* 9 - glyphs use the glyph-user-to-surface transformation
* 10.2 - add `VG_A_1` and `VG_A_4` image formats
* 11 - add Text chapter, renumber following chapters
* 12.4 - lower minimum value for `VG_MAX_GAUSSIAN_ST_DEVIATION`
* 2.8, 13.1 add Color Transformation pipeline stage

Version 1.0.1 ratified January 2007

Changes from version 1.0 to version 1.0.1 (by section number):
* 3.2 - clarification: `VGboolean` is an enumeration
* 3.4.1 - provide further explanation of linear pixel formats
* 5.2 - new behavior: restrict values of count parameter in **vgGet/Set\*v, vgGet/SetParameter\*v;** describe error behavior of getters
* 5.2.1 - change default value of `VG_FILTER_FORMAT_LINEAR` and `VG_RENDERING_QUALITY`; add `VG_SCREEN_LAYOUT` parameter; add `VG_STROKE_DASH_PHASE_RESET` parameter
* 6.2 - define behavior of `VG_SCREEN_LAYOUT` parameter
* 8.3.4-5 clarify join behavior for smooth segments following line segments
* 8.4 - change behavior of elliptical arcs with one radius equal to 0
* 8.5 - typo: `VG_PATH_FORMAT_STANDARD` is passed to **vgCreatePath**, not **vgAppendPathData**
* 8.5.2 - clarification: conversion of path segments from relative to absolute form takes place during rendering
* 8.6.7-8 - new behavior: **vgTransformPath** and **vgInterpolatePath** promote HLINE and VLINE segments to general (2- coordinate) form; the parameterization of transformed elliptical arc segments is undefined
* 8.6.11 - clarification: normalization of tangents; approximate computation of path length
* 8.7.1 - clarification: implicit closure takes place during rendering
* 8.7.3 - clarification: definition and illustration of the miter length
* 8.7.4 - clarification: stroke generation takes place in user coordinates.
* 8.7.4-5 - Add new behavior controlled by `VG_STROKE_DASH_PHASE_RESET`
* 9 - paint coordinates must be evaluated within 1/8 of a pixel; clarify source of user transform Tu
* 9.3.3 - add `VG_PAINT_COLOR_RAMP_PREMULTIPLIED` flag to control whether gradient colors are interpolated in premultiplied form
* 9.3.3 - new behavior: count must be a multiple of 5 in **vgSetParameter** for color ramp stops (see 5.2); simplify description of rules for repeat and reflect pad modes
* 10.2 - add new values to `VGImageFormat` enumeration
* 10.5 - clarification: **vgImageSubData** clamps premultiplied color values to their corresponding alpha values
* 10.8 - clarify behavior of `VG_DRAW_IMAGE_NORMAL` when the source has an alpha channel; new behavior: when a projective transformation is enabled, **vgDrawImage** always uses `VG_DRAW_IMAGE_NORMAL` mode; clarify behavior when a linear source image is used in `VG_DRAW_IMAGE_MULTIPLY` mode
* 10.9.1 - clarification: **vgWritePixels** clamps premultiplied color values to their corresponding alpha values
* 12.4 - clarification: input color values are clamped at 1
* 14.3.2 - clarify display dependency of **vgGetString**
* 14.3.2 - **vgGetString**(`VG_VERSION`) returns the specification version.
* 16.1.6 - typo: error in vguArc pseudo-code
* 18 - remove enumerated values `VG_PATH_DATATYPE_INVALID` and `VG_IMAGE_FORMAT_INVALID`

Version 1.0 ratified August 2005
<div style="page-break-after: always;"> </div>
