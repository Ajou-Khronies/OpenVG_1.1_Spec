
<a name="chapter01"></a> <a name="Introduction"></a>
# 1 Introduction
OpenVG is an application programming interface (API) for hardware-accelerated two-dimensional vector and raster graphics developed under the auspices of the Khronos Group (www.khronos.org). It provides a device-independent and vendor-neutral interface for sophisticated 2D graphical applications, while allowing device manufacturers to provide hardware acceleration where appropriate.

This document defines the C language binding to OpenVG. Other language bindings may be defined by Khronos in the future. We use the term "implementation" to refer to the software and/or hardware that implements OpenVG functionality, and the term "application" to refer to any software that makes use of OpenVG.

<a name="Feature_Set"></a>
## _1.1 Feature set_
OpenVG provides a drawing model similar to those of existing two-dimensional drawing APIs and formats, such as Adobe PostScript [[ADOB99](#ADOB99)], PDF [[ADOB06a](#ADOB06a)], Adobe (formerly MacroMedia) Flash [[ADOB06b](#ADOB06b)]; Sun Microsystems Java2D [[SUN04](#SUN04)]; and W3C SVG [[SVGF05](#SVGF05)][[SVGT06](#SVGT06)]. Version 1.1 is specifically intended to support all drawing features required by a SVG Tiny 1.2 renderer or an Adobe Flash Lite renderer (implementing the Flash 7 feature set), and additionally to support functions that may be of use for implementing an SVG Basic renderer.

<a name="Target_applications"></a>
## _1.2 Target applications_
Several classes of target applications were used to define requirements for the design of the OpenVG API.

<a name="SVG_and_Adobe_Flash_Viewers"></a>
#### _SVG and Adobe Flash Viewers_
OpenVG must provide the drawing functionality required for a high-performance SVG document viewer that is conformant with version 1.2 of the SVG Tiny profile. It does not need to provide a one-to-one mapping between SVG syntactic features and API calls, but it must provide efficient ways of implementing all SVG Tiny features.

Adobe Flash version 7 must also be supported with high performance and full
compliance.

<a name="Portable_Mapping_applications"></a>
#### _Portable Mapping applications_
OpenVG can provide dynamic features for map display that would be difficult or impossible to do with an SVG or Flash viewer alone, such as dynamic placement and sizing of street names and markers, and efficient viewport culling.

<a name="Games"></a>
#### _Games_
The OpenVG API must be useful for defining sprites, backgrounds, and textures for use in both 2D and 3D games. It must be able to provide two-dimensional overlays (e.g., for maps or scores) on top of 3D content.

<a name="Scalable_User_Interfaces"></a>
#### _Scalable User Interfaces_
OpenVG may be used to render scalable user interfaces, particularly for applications that wish to present users with a unique look and feel that is consistent across different screen resolutions.

<a name="Low_Level_Graphics_Device_Interface"></a>
#### _Low-Level Graphics Device Interface_
OpenVG may be used as a low-level graphics device interface. Other graphical toolkits, such as windowing systems, may be implemented above OpenVG.

<a name="Target_Devices"></a>
## _1.3 Target Devices_
OpenVG is designed to run on devices ranging from wrist watches to full microprocessor-based desktop and server machines. Over time, it is expected that OpenGL ES hardware manufacturers will be able to provide inexpensive incremental acceleration for OpenVG functionality.

Realistically, to obtain the full benefit of OpenVG, a device should provide a display with at least 128 x 128 non-indexed RGB color pixels with 4 or more bits per channel.

<a name="Design_Philosophy"></a>
## _1.4 Design Philosophy_
OpenVG is intended to provide a hardware abstraction layer that will allow accelerated performance on a variety of application platforms. Functions that are not expected to be amenable to hardware acceleration in the near future were either not included, or included as part of the optional VGU utility library.

Where possible, the syntax of OpenVG is intended to be reminiscent of that of OpenGL, in order to make learning OpenVG as easy as possible for OpenGL developers. Most of the OpenVG state is encapsulated in a set of primitive-valued variables that are manipulated using the vgSet and vgGet functions. Extensions may add new state variables in order to add new features to the pipeline without needing to add new functions.

Paint, path, and image objects in OpenVG are referenced using opaque handles. This allows implementations to store such objects using their own preferred representation, in whatever form of memory they choose. This is intended to simplify hardware design, and to minimize processing and bus traffic for frequently-used objects.

<a name="Naming_and_Typographical_Conventions"></a>
##  _1.5 Naming and Typographical Conventions_
OpenVG uses a consistent set of conventions for API names and symbols. In this document, additional typographic conventions are used to help indicate the type of each symbol, as shown in Table 1 below.

<a name="table01"> </a>
| _Symbol Type_ | _Name/Case_ | _Type Style_ | _Example_ |
|  :---         |  :---       |   :---:      |  :---     |
| API Function  | vgXxxYyy    | Boldface     | **vgLoadMatrix** |
|API Function with Varying Parameter Types|vgXxx{f,i,fv,iv} |Boldface |**vgSetfv**|
|Utility Function| vguXxxYyy |Boldface| **vguRoundRect**|
|Primitive Datatype |VGxxx |Typewriter| `VGfloat`|
|Enumerated Datatype |VGXxxYyy| Typewriter |`VGCapStyle`|
|Enumerated Value| VG_XXX_YYY |Typewriter| `VG_BLEND_MODE`|
|Utility Enumerated Value| VGU_XXX_YYY| Typewriter |`VGU_ARC_CHORD`|
|Function Argument| xxxYyy |Typewriter |`paintMode`|
_Table 1: Naming and Typographical Conventions_

<a name="Library_Naming"></a>
##  _1.6 Library Naming_
The library name is defined as libOpenVG.z where z is a platform-specific library suffix (_i.e._, `.a, .so, .lib, .dll`, etc.).

<div style="page-break-after: always;"></div>
