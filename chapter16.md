# 16 API Conformance<a name="chapter16"> </a> <a name="API_Conformance"> </a>
All OpenVG implementations are required to pass a conformance test suite. The exact details of the conformance testing process are available in a separate document. This chapter outlines the OpenVG conformance test philosophy and provides information that may be useful in order to ensure conformant implementations.

## 16.1 Conformance Test Principles<a name="Conformance_Test_Principles"></a>
The OpenVG specification attempts to strike a balance between the needs of implementers and application developers. While application developers desire a stable platform that delivers predictable results, they also wish to avoid reduced performance due to an excessively strict API definition. By allowing some flexibility in how the API is implemented, implementations may be optimized for a wide variety of platforms with varying price, performance, and power characteristics. The purpose of conformance testing is to ensure that implementations with different internal approaches produce similar results.

### 16.1.1 Window System Independence<a name="Window_System_Independence"></a>
Because OpenVG does not mandate a specific window system or display management API, the conformance test suite will isolate all display dependencies in a module that may be customized for each platform. An EGL-based implementation of this module will be provided, but implementers are free to replace this implementation with one that is specific to their platform.

### 16.1.2 Antialiasing Algorithm Independence<a name="Antialiasing_Algorithm_Independence"> </a>
It is anticipated that a wide variety of antialiasing approaches will be used in the marketplace. Low-cost antialiasing remains a research topic, and new algorithms continue to emerge. The conformance suite must allow for this variation, while not allowing differences in antialiasing to cover up inadequacies in other portions of the implementation such as matrix transformation or curve subdivision.

### 16.1.3 On-Device and Off-Device Testing<a name="On-Device_and_Off-Device_Testing"></a>
Certain conformance tests require only a small memory footprint, and may be run directly on the target device. Other tests operate by generating an image, which must be copied off-device. A desktop tool is used to compare the generated images against a set of reference images.

## 16.2 Types of Conformance Tests<a name="Types_of_Conformance_Tests"> </a>
Conformance tests fall into several classes, outlined below.

### 16.2.1 Pipeline Tests<a name="Pipeline_Tests"> </a>
A set of tests will be provided that attempt to isolate each pipeline stage by means of suitable parameter settings. These tests will provide assurance that each stage is functioning correctly.

### 16.2.2 Self-Consistency Tests<a name="Self-Consistency_Tests"> </a>
Certain portions of the API are required to produce exact results. For example, setting and retrieving API state, image, paint, and path parameters, setting and retrieving matrix values; error generation; and pixel copies are defined to have exact results. The conformance suite will provide strict checking for these behaviors.

### 16.2.3 Matrix Tests<a name="Matrix_Tests"> </a>
The conformance suite will exercise various matrix operations and compare the results against double-precision values. The comparison threshold will be set to exclude implementations with insufficient internal precision.

### 16.2.4 Interior/Exterior Tests<a name="Interior_Exterior_Tests"> </a>
Although antialiasing may have varying effects on shape boundaries, the portions of the interior and exterior of shapes that are more than 1 Â½ pixels from a geometric boundary should not be affected by that boundary. If a shape is drawn using color paint, a set of known interior and exterior pixels may be tested for equality with the paint color.

### 16.2.5 Positional Invariance<a name="Positional_Invariance"> </a>
Drawing should not depend on absolute screen coordinates, except for minor differences due to spatially-variant sampling and dither patterns when copying to the screen. The conformance suite will include tests that verify the positional independence of drawing.

### 16.2.6 Image Comparison Tests<a name="Image_Comparison_Tests"> </a>
To allow for controlled variation, the conformance suite will provide a set of rendering code fragments, along with reference images that have been generated using a highquality implementation. Implementation-generated images will be compared to these reference images using a fuzzy comparison system. This approach is intended to allow for small differences in the accuracy of geometry and color processing and antialiasing, while rejecting larger differences that are considered visually unacceptable. The comparison threshold will be determined by generating images with a variety of acceptable and unacceptable differences and comparing them against the reference image.

<div style="page-break-after: always;"> </div>


