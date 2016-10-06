# 4 The Drawing Context <a name="Chapter4"></a><a name="The Drawing Context"></a>
OpenVG functions that perform drawing, or that modify or query drawing state make use of an implicit _drawing context_ (or simply a _context_). A context is created, attached to a drawing surface, and bound to a running application thread outside the scope of the OpenVG API, for example by the Khronos EGL API. OpenVG API calls are executed with respect to the context currently bound to the thread in which they are executed. A call to any OpenVG API function when no drawing context is bound to the current thread has no effect. The drawing context currently bound to a running thread is referred to as the _current context_.

When an image, paint, path, font, or mask handle is defined, it is permanently attached to the context that is current at that time. It is an error to use the handle as an argument to any OpenVG function when a different context is active, unless that context has been designated as a _shared context_ of the original context by the API responsible for context creation (usually EGL).

Images created by OpenVG may be used as the rendering target of a drawing context. All drawing performed by any API that makes use of that context will use that image as the drawing surface.

Passing an image that is currently the rendering target of a drawing context to any OpenVG function (excluding **vgGetParameter** and **vgDestroyImage**) will result in a `VG_IMAGE_IN_USE_ERROR`. The image may once again be used by OpenVG when it is no longer in use as a rendering target.

An image that is related to any other image (as defined in Section 10.6), or that is set as a paint pattern image on a paint object or a glyph image on a font object, may not be used as a rendering target. A parent image (one that was created by **vgCreateImage**) may be used as a rendering target when all other images that are related to it have been destroyed and it is not being used as a paint pattern image on any paint object or as a glyph image on any font object.

It is possible to provide OpenVG on a platform without supporting EGL. In this case, the host operating system must provide some alternative means of creating a context and binding it to a drawing surface and a rendering thread.

The context is responsible for maintaining the API state, as shown in Table 3.

|State Element| Description|
|---|---|
|Drawing Surface |Surface for drawing|
|Matrix Mode| Transformation to be manipulated|
|Path user-to-surface Transformation |Affine transformation for filled and stroked geometry|
|Image user-to-surface Transformation| Affine or projective transformation for images|
|Paint-to-user Transformations| Affine transformations for paint applied to geometry|
|Glyph user-to-surface Transformation| Affine transformation for glyphs|
|Glyph origin |(X,Y) origin of a glyph to be drawn|
|Fill Rule| Rule for filling paths|
|Quality Settings |Image and rendering quality, pixel layout|
|Color Transformation| Color Transformation Function|
|Blend Mode| Pixel blend function|
|Image Mode| Image/paint combination function|
|Scissoring |Current scissoring rectangles and enable/disable |
|Stroke |Stroke parameters|

|State Element| Description|
|---|---|
|Pixel and Screen layout| Pixel layout information|
|Tile fill color |Color for FILL tiling mode|
|Clear color |Color for fast clear|
|Filter Parameters |Image filtering parameters|
|Paint |Paint definitions|
|Mask| Coverage mask and enable/disable|
|Error |Oldest unreported error code|
_Table 3: State Elements of a Context_

## _4.1 Errors_ <a name="Errors"></a>
Some OpenVG functions may encounter errors. Unless otherwise specified, any value returned from a function following an error is undefined.

All OpenVG functions may signal `VG_OUT_OF_MEMORY_ERROR`. This allows implementations to defer memory allocation until it is needed, rather than requiring them to proactively allocate memory only in certain functions that are allowed to generate an error. Such an error may occur midway through the execution of an OpenVG function, in which case the function may have caused changes to the state of OpenVG or to drawing surface pixels prior to failure.

When an OpenVG function encounters an error other than a `VG_OUT_OF_MEMORY_ERROR`, the context state is not modified and no drawing takes place.

An error condition within an OpenVG function must never result in process termination, with the exception of illegal memory accesses taking place within functions that accept an application-provided pointer. Applications should take care to check return values where provided. Functions that do not provide return values may still flag errors that may be retrieved using the **vgGetError** function described below. Errors are stored in the context in which the function was called.

All pointer arguments must be aligned according to their datatype, _e.g._, a `VGfloat` * argument must be a multiple of 4 bytes.

#### _VGErrorCode_ <a name="VGErrorCode"></a>
The error codes and their numerical values are defined by the VGErrorCode enumeration:
```C
typedef enum {
VG_NO_ERROR                       = 0,
VG_BAD_HANDLE_ERROR               = 0x1000,
VG_ILLEGAL_ARGUMENT_ERROR         = 0x1001,
VG_OUT_OF_MEMORY_ERROR            = 0x1002,
VG_PATH_CAPABILITY_ERROR          = 0x1003,
VG_UNSUPPORTED_IMAGE_FORMAT_ERROR = 0x1004,
VG_UNSUPPORTED_PATH_FORMAT_ERROR  = 0x1005,
VG_IMAGE_IN_USE_ERROR             = 0x1006,
VG_NO_CONTEXT_ERROR               = 0x1007
} VGErrorCode;
```

#### _vgGetError_ <a name="vgGetError"></a>
**vgGetError** returns the oldest error code provided by an API call on the current context since the previous call to vgGetError on that context (or since the creation of the context). No error is indicated by a return value of 0 (`VG_NO_ERROR`). After the call, the error code is cleared to 0. The possible errors that may be generated by each OpenVG function (apart from `VG_OUT_OF_MEMORY_ERROR`) are shown below the definition of the function.

If no context is current at the time vgGetError is called, the error code `VG_NO_CONTEXT_ERROR` is returned. Pending error codes on existing contexts are not affected by the call.
```C
VGErrorCode vgGetError(void)
```

## _4.2 Manipulating the Context Using EGL_ <a name="Manipulating the Context Using EGL"></a>
Most OpenVG implementations are expected to make use of version 1.2 or later of the EGL API to obtain drawing contexts. This section provides only a partial, non-normative description of some aspects of the use of EGL that are specific to OpenVG. Refer to the EGL 1.2 specification for more details.

### _4.2.1 EGLConfig Attributes_ <a name="EGLConfig Attributes"></a>
An `EGLConfig` describes the capabilities of a configuration. Each `EGLConfig` encapsulates a set of attributes and their values.

#### _EGL_OPENVG_BIT_ <a name="EGL_OPENVG_BIT"></a>
`EGLConfig`s that may be used with OpenVG will have the bit `EGL_OPENVG_BIT` set in their `EGL_RENDERABLE_TYPE` attribute.

#### _EGL_ALPHA_MASK_SIZE_ <a name="EGL_ALPHA_MASK_SIZE"></a>
The `EGL_ALPHA_MASK_SIZE` attribute contains the bit depth of the mask associated with a configuration. Masking will take place in the OpenVG pipeline only if the bit depth for the drawing surface mask is greater than zero.

### _4.2.2 EGL Functions_ <a name="EGL Functions"></a>
#### _eglBindAPI_ <a name="eglBindAPI"></a>
EGL has a notion of the _current rendering API_. This setting acts as an implied parameter to some EGL functions. To set OpenVG as the current rendering API in EGL, it is necessary to call **eglBindAPI** with an `api` argument of `EGL_OPENVG_API`:
```C
EGLBoolean eglBindAPI(EGLenum api)
```

#### _eglCreateContext_ <a name="eglCreateContext"></a>
Once **eglBindAPI** has been called to set OpenVG as the current rendering API, an EGL context that is suitable for use with OpenVG may be obtained by calling **eglCreateContext**. An existing OpenVG context may be passed in as the `share_context` parameter; any `VGPath` and `VGImage` objects defined in `share_context` will be accessible from the new context, and vice versa. If no sharing is desired, the value `EGL_NO_CONTEXT` should be used.
```C
EGLContext eglCreateContext(EGLDisplay dpy,
                            EGLConfig config,
                            EGLContext share_context,
                            const EGLint * attrib_list)
```

#### _eglCreateWindowSurface_ <a name="eglCreateWindowSurface"></a>
Drawing takes place onto an `EGLSurface`. An `EGLSurface` may be created from a platform native window using **eglCreateWindowSurface**. It is possible to request _single-buffered_ rendering, in which drawing takes place directly to the visible window, using the `attrib_list` parameter to set the `EGL_RENDER_BUFFER` attribute to a value of `EGL_SINGLE_BUFFER`. Implementations that do not support single-buffered rendering may ignore this setting. Applications should query the returned surface to determine if it is single- or double-buffered.
```C
EGLSurface eglCreateWindowSurface(EGLDisplay dpy,
                                  EGLConfig config,
                                  NativeWindowType win,
                                  const EGLint *attrib list);
```
#### _eglCreatePbufferFromClientBuffer_ <a name="eglCreatePbufferFromClientBuffer"></a>
An EGLSurface that allows rendering into a `VGImage` (see Section 10) may be created by binding the `VGImage` to a _Pbuffer_ (off-screen buffer). EGL defines the function **eglCreatePbufferFromClientBuffer**, which may be used with a `buftype` argument of `EGL_OPENVG_IMAGE`. The `VGImage` to be targeted is cast to the `EGLClientBuffer` type and passed as the `buffer` parameter.

If EGL is used with OpenVG, the version of EGL used must support the creation of a Pbuffer from a `VGImage` either as part of its core functionality or by means of an extension.
```C
EGLSurface eglCreatePbufferFromClientBuffer(EGLDisplay dpy,
                                            EGLenum buftype,
                                            EGLClientBuffer buffer,
                                            EGLConfig config,
                                            const EGLint *attrib_list)
```
#### _eglMakeCurrent_ <a name="eglMakeCurrent"></a>
The **eglMakeCurrent** function causes a given context to become current on the running thread. Any context that is current on the thread prior to the call is flushed and marked as no longer current.
```C
EGLBoolean eglMakeCurrent(EGLDisplay dpy,
                          EGLSurface draw,
                          EGLSurface read,
                          EGLContext ctx)
```
#### _eglGetCurrentContext_ <a name="eglGetCurrentContext"></a>
The OpenVG context for the current rendering API that is bound to the current thread may be retrieved by calling **eglGetCurrentContext**:
```C
EGLContext eglGetCurrentContext()
```
#### _eglDestroyContext_ <a name="eglDestroyContext"></a>
An EGL context is destroyed by calling **eglDestroyContext**.
```C
EGLBoolean eglDestroyContext(EGLDisplay display, EGLContext context)
```
#### _eglSwapBuffers_<a name="eglSwapBuffers"></a>
When drawing occurs in _double-buffered_ mode, all drawing takes place into an invisible back buffer, and it is necessary to call **eglSwapBuffers** to force the buffer contents to be copied to the visible window. If the visible buffer has a lesser color bit depth than the back buffer, dithering may be performed as part of the buffer copy operation.
```C
EGLBoolean eglSwapBuffers(EGLDisplay dpy,
                          EGLSurface surface);
```
## _4.3 Forcing Drawing to Complete_ <a name="Forcing Drawing to Complete"></a>
OpenVG provides functions to force the completion of rendering, in order to allow applications to synchronize between multiple rendering APIs.

#### _vgFlush_ <a name="vgFlush"></a>
The **vgFlush** function ensures that all outstanding requests on the current context will complete in finite time. **vgFlush** may return prior to the actual completion of all requests.
```C
void vgFlush(void)
```
#### _vgFinish_ <a name="vgFinish"></a>
The **vgFinish** function forces all outstanding requests on the current context to complete, returning only when the last request has completed.
```C
void vgFinish(void)
```
<div style="page-break-after: always;"></div>
