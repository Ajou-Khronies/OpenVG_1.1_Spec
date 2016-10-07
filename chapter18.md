# 18 Appendix A: Mathematics of Ellipses
<a name ="chapter18"> </a> <a name ="Mathematics_of_Ellipses"> </a>
The following sections are informative only. It contains mathematics pertaining to the representation of ellipses that may be of use to implementers. Some of the material is adapted from [[SVGF04](#SVGF04)]
## 18.1 The Center Parameterization
<a name ="The_Center_Parameterization"> </a>
A common parameterization of an ellipse is in terms of the ellipse center point $(cx, cy)$, horizontal and vertical radii $rh$ and $rv$, rotation angle $ϕ$, and starting and ending angles $θ_1$ and $θ_2$ between 0 and 360 degrees. The parameters are listed in Table 18.

The elliptical arc may be evaluated in terms of an angular parameter θ that ranges from $θ_1$ to $θ_2$:
$$
f(cx,cy,rh,rv,\phi,\theta )=\begin{bmatrix} \cos{\phi} & -\sin{\phi} \\ \sin{\phi}  & \cos{\phi}\end{bmatrix} \cdot \left[ \begin{matrix} rh \cos{\theta}  \\ rv\sin{\theta}  \end{matrix}\right] + \left[ \begin{matrix} cx \\ cy \end{matrix} \right]
$$
An ellipse in the center parameterization may be viewed as a unit circle, parameterized as $(x, y) = (\cos{\theta}, \sin{\theta})$ that has been placed through an affine transformation consisting of a rotation and a non-uniform scale:
$$
\left[ \begin{matrix} x \\ y \\ 1 \end{matrix} \right] \quad =\quad \left[ \begin{matrix} rh\cos { \phi  }  & -rv\sin { \phi  }  & cx \\ rh\sin { \phi  }  & -rv\cos { \phi  }  & cy \\ 0 & 0 & 1 \end{matrix} \right] \cdot \left[ \begin{matrix} \cos { \theta  }  \\ \sin { \theta  }  \end{matrix} \right]
$$

|     |     |
| --- | --- |
| $(cx, cy)$  | The Center point of the ellipse
| $rh, rv$  | The radii of the unrotated ellipse
| $\varphi$  | The counter-clockwise angle of the ellipse relative to the x axis, measured prior to scaling by $(rh, rv)$
| $\theta_1$ | Angle of initial point (as measured on the unscaled circle)
| $\theta_2$ | Angle of final point (as measured on the unscaled circle)
_Table 18: Center Ellipse Parameters_

## 18.2 The Endpoint Parameterization
<a name ="The_Endpoint_Parameterization"> </a>
OpenVG paths use the endpoint parameterization of elliptical arcs as defined in SVG. An elliptical arc segment is defined in terms of its endpoints $(x0, y0), (x1, y1)$, radii $rh$ and $rv$, rotation angle $ϕ$, large arc flag $f_A$, and sweep flag $f_S$. These parameters are listed in Table 19.

|     |     |
| --- | --- |
| $(x0, y0)$  | The initial endpoint of the arc
| $(x1, y1)$ | The final endpoint of the arc
| $rh, rv$  | The radii of the unrotated ellipse
| $rot$ | The counter-clockwise angle of the ellipse relative to the x axis, measured prior to scaling by (rh, rv)
| $f_A$ | Large arc flag: 1 if more than 180 degrees of the arc is to be traversed (as measured on the unscaled circle), 0 otherwise
| $f_S$ | Sweep flag: 1 if the arc is to be traversed in the counter-clockwise direction, 0 otherwise
_Table 19: Endpoint Ellipse Parameters_

## 18.3 Converting from Center to Endpoint Parameterization
<a name ="Converting_from_Center_to_Endpoint_Parameterization"> </a>
Conversion from a center parameterization to an endpoint parameterization simply requires evaluation the initial and final endpoints of the arc, and determining the values of the large arc and sweep flags:

<!--???? there is Error in the equation x1-> x0, x2-> x1--->
$$
\begin{matrix}
\left[ \begin{matrix} x_1 \\ y_1 \end{matrix} \right] = f(cx,cy,rh,rv,\phi,\theta_1 ) \\
\left[ \begin{matrix} x_2 \\ y_2 \end{matrix} \right] = f(cx,cy,rh,rv,\phi,\theta_2 ) \\
f_A=\begin{cases} 1 & if\quad \left| \theta _{ 2 }-\theta _{ 1 } \right| >180\quad degrees \\ 0 & otherwise \end{cases} \\
f_{ S }=\begin{cases} 1 & if\quad \theta _{ 2 }-\theta _{ 1 }\quad >\quad 0\\ 0 & otherwise \end{cases}
\end{matrix}
$$

## 18.4 Converting from Endpoint to Center Parameterization
<a name ="Converting_from_Endpoint_to_Center_Parameterization"> </a>
Given an endpoint representation of an ellipse as the set of parameters $(x_0, y_0), (x_1, y_1), rh, rv, ϕ, f_S,$ and $f_A$, we wish to determine the center point $(cx, cy)$ and the initial and final angles $θ_1$ and $θ_2$.

An ellipse with center point $(cx, cy)$, radii rh and rv, and rotation angle rot satisfies the implicit equation $(x')^2 + (y')2 = 1$, where $x' = ((x – cx)*cos(rot) + (y – cy)*sin(rot))/rh$ and $y' = (-(x – cx)*sin(rot)$ $+ (y – cy)*cos(rot))/rv$. The transformation from $(x, y)$ to $(x', y')$ simply maps the desired ellipse into a unit circle centered at the origin.

To determine the center points of the pair of ellipses with common radii and rotation
angle that pass through the two given points $(x0, y0)$ and $(x1, y1)$, the plane is first transformed into a suitably scaled and rotated coordinate system such that the equation of each ellipse becomes $(x' – cx')^2 + (y' – cy')^2 = 1$. Then the problem is reduced to finding the centers $(cx_0', cy_0')$ and $(cx_1', cy_1')$ of the two unit circles whose circumferences pass through two given points. Finally, the center points are placed through an inverse transformation to obtain solutions in the original coordinate system.

The center points of the two unit circles that pass through points $(x_0, y_0)$ and $(x_1, y_1)$ are given by $(xm ± Δy * d, ym ∓ Δx * d)$, where $x_m = (x_0 + x_1)/2, y_m = (y_0 + y_1)/2, Δx = (x_0 – x_1) , Δy = (y_0 – y_1)$, and $d = \sqrt{(1/({Δx}^2 + {Δy}^2) – 1/4)}$. If $d$ is infinite or imaginary, no solution exists due to the input points being coincident or too far apart, respectively.

The angles $θ_1$ and $θ_2$ may be found by finding the slope of the endpoints on the circle and computing arctangents. The following code illustrates the process of computing the ellipse centers. The findUnitCircles function is called by findEllipses following inverse transformation of the original ellipse parameters.

```C
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

/*  Given: Points (x0, y0) and (x1, y1)
 * Return: TRUE if a solution exists, FALSE otherwise
 *         Circle centers are written to (cx0, cy0) and (cx1, cy1)
 */

static VGboolean
findUnitCircles(double x0, double y0, double x1, double y1,
    double *cx0, double *cy0, double *cx1, double *cy1)
{
  /* Compute differences and averages */ double dx = x0 – x1;
  double dy = y0 – y1; double xm = (x0 + x1)/2; double ym = (y0 + y1)/2;
  double dsq, disc, s, sdx, sdy;

  /* Solve for intersecting unit circles */ dsq = dx*dx + dy*dy;
  if (dsq == 0.0) return VG_FALSE; /* Points are coincident */ disc = 1.0/dsq – 1.0/4.0;
  if (disc < 0.0) return VG_FALSE; /* Points are too far apart */ s = sqrt(disc);
  sdx = s*dx; sdy = s*dy;
  *cx0 = xm + sdy;
  *cy0 = ym – sdx;
  *cx1 = xm – sdy;
  *cy1 = ym + sdx; return VG_TRUE;
}
```

```C
/* Given: Ellipse parameters rh, rv, rot (in degrees),
 * endpoints (x0, y0) and (x1, y1)
 * Return: TRUE if a solution exists, FALSE otherwise
 * Ellipse centers are written to (cx0, cy0) and (cx1, cy1)
 */
VGboolean
findEllipses(double rh, double rv, double rot,
      double x0, double y0, double x1, double y1,
      double *cx0, double *cy0, double *cx1, double *cy1)
{
  double COS, SIN, x0p, y0p, x1p, y1p, pcx0, pcy0, pcx1, pcy1;
  /* Convert rotation angle from degrees to radians */
  rot *= M_PI/180.0;
  /* Pre-compute rotation matrix entries */
  COS = cos(rot); SIN = sin(rot);
  /* Transform (x0, y0) and (x1, y1) into unit space */
  /* using (inverse) rotate, followed by (inverse) scale */
  x0p = (x0*COS + y0*SIN)/rh;
  y0p = (-x0*SIN + y0*COS)/rv;
  x1p = (x1*COS + y1*SIN)/rh;
  y1p = (-x1*SIN + y1*COS)/rv;
  if (!findUnitCircles(x0p, y0p, x1p, y1p,
  &pcx0, &pcy0, &pcx1, &pcy1)) {
  return VG_FALSE;
  }
  /* Transform back to original coordinate space */
  /* using (forward) scale followed by (forward) rotate */
  pcx0 *= rh; pcy0 *= rv;
  pcx1 *= rh; pcy1 *= rv;
  *cx0 = pcx0*COS – pcy0*SIN;
  *cy0 = pcx0*SIN + pcy0*COS;
  *cx1 = pcx1*COS – pcy1*SIN;
  *cy1 = pcx1*SIN + pcy1*COS;
  return VG_TRUE;
}
```

## 18.5 Implicit Representation of an Ellipse<a name="Implicit_Representation_of_an_Ellipse"> </a>
An ellipse (or any conic section) may be written in the implicit form:
$$
A x^2 + B x y + C y^2 + D x + E y + F = 0
$$
This equation describes an ellipse (or circle) if $B^2 – 4 A C < 0$ (and certain other degeneracies do not occur). The center of the ellipse is located at:
$$
(cx, cy) = (2 C D - B E , 2 A E - B D) / (B^2 - 4 A C)
$$
The ellipse may be re-centered about $(0, 0)$ by substituting $x ← x + cx, y ← y + cy$ to obtain an implicit equation with $D = E = 0$:
$$
A x^2 + B x y + C y^2 + \left ( \frac{A E^2 + C D^2 - B D E} {B^2 - 4 A C} + F  \right ) = 0
$$
For a centered ellipse, the constant term must be equal to -1 since the entire formula has the form of $(x')^2 + (y')^2 – 1$ where $x'$ and $y'$ contain no constant terms. Thus in order to determine the radius and axes of a centered ellipse we only need to be concerned with equations of the form:
$$
A x^2 + B x y + C y^2 + 1 = 0
$$
The angle of rotation is given by:
$$
\theta = \begin{cases}
0, &    if\quad B = 0 \\
\frac{\Pi}{4},  & if \quad B \neq 0\quad and\quad A = C \\
\frac{1}{2} \tan^{-1} \left ( { \frac { B }{ A-C }} \right ),   &  otherwise\\
\end{cases}
$$
Applying an inverse rotation by substituting $x ← x cos(-θ) + y sin(-θ)$ and $y ← y cos(-θ) - x sin(-θ)$, we obtain a further simplification to an unrotated form:
$$
A' x^2 + C' y^2 - 1 = 0
$$
where:
$$
\begin{matrix}
A' = \begin {cases}
  A, & if \quad B = 0 \\
  A+\frac{B}{2}, & if \quad B \neq 0 \quad and \quad A = C \\
  \frac{1}{2} ( A + C + K (A - C)), & otherwise \\
\end {cases} \\
C' = \begin {cases}
  C, & if \quad B = 0 \\
  A-\frac{B}{2}, & if \quad B \neq 0 \quad and \quad A = C \\
  \frac{1}{2} ( A + C + K (A - C)), & otherwise \\
\end {cases} \\
where \quad  K = \sqrt{1 + \frac{B^2}{(A-C)^2}}
\end {matrix} \\
$$
The radii of the centered, unrotated ellipse are given by:
$$
rh  = \frac{1}{\sqrt{A'}}, \quad rv  = \frac{1}{\sqrt{C'}}
$$

## 18.6 Transformation of Ellipses<a name="Transformation of Ellipses"> </a>
As previously noted, an ellipse may be viewed as the result of a scale, rotation, and translation applied to the unit circle:
$$
\left [ \begin{matrix} x \\ y \\ 1 \end{matrix} \right ] =
\left [ \begin{matrix}
    rh \cos(\theta) & -rv \sin(\theta) & cx \\
    rh \sin(\theta)  & rv \cos(\theta) & cy \\
    0 &  0 & 1 \end{matrix} \right ] \cdot
\left [ \begin{matrix} cos(\theta) \\ sin(\theta) \\ 1 \end{matrix} \right ]
$$
The resulting ellipse satisfies an implicit equation generated by placing each point on the ellipse through an affine transformation M that is the inverse of the transformation above. The resulting points lie on the unit circle, and therefore satisfy the implicit equation $x^2 + y^2 = 1$.

If $M$ is defined as:
$$
M = \left [ \begin{matrix}
  m_{00} & m_{01} & m_{02} \\
  m_{10} & m_{11} & m_{12} \\
  0  & 0  &  1 \\
\end{matrix}\right ] =
\left [ \begin{matrix}
    rh \cos(\theta) & -rv \sin(\theta) & cx \\
    rh \sin(\theta)  & rv \cos(\theta) & cy \\
    0 &  0 & 1 \end{matrix} \right ]^{-1}
$$
then the implicit equation for the ellipse is:
$$
( m_{00} x + m_{01} y + m_{02})^2 +  ( m_{10} x + m_{11} y + m_{12})^2 -1 = 0
$$
which may be written in standard form as:
$$
A x^2 + B x y + C y^2 + D x + E y + F = 0
$$
where:
$$
\begin{matrix}
A = m_{00}^2 + m_{10}^2 \\
B = 2(m_{00} m_{01} + m_{10} m_{11}) \\
C = m_{01}^2 + m_{11}^2 \\
D = 2(m_{00} m_{02} + m_{10} m_{12}) \\
E = 2(m_{01} m_{02} + m_{11} m_{12}) \\
F = m_{02}^2 + m_{12}^2 - 1 \\
\end{matrix}
$$
The center, rotation angle, and radii of the ellipse may be determined using the formulas from the previous section.

In practice, it may be simpler to represent a transformed ellipse as the affine transformation mapping an arc of the unit circle into it. The ellipse may be rendered by concatenating its transform with the current transform and rendering the circular arc. It may be transformed by simply concatenating the transforms.

<div style="page-break-after: always;"> </div>


