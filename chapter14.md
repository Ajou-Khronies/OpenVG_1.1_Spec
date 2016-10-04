# 14 Querying Hardware Capabilities
<a name="Chapter14"></a> <a name="Querying_Hardware_Capabilities"></a>
OpenVG implementations may vary considerably in their performance characteristics. A simple hardware query mechanism is provided to allow applications to make informed choices regarding data representations, in order to maximize their chances of obtaining hardware-accelerated performance. Currently, OpenVG provides hardware queries for image formats and path datatypes.
#### _VGHardwareQueryType_
<a name="VGHardwareQueryType"></a>
The `VGHardwareQueryType` enumeration defines the set of possible hardware queries. Currently these are restricted to queries regarding image formats and path datatypes.
```C
typedef enum {
 VG_IMAGE_FORMAT_QUERY = 0x2100,
 VG_PATH_DATATYPE_QUERY = 0x2101
} VGHardwareQueryType;
```

#### _VGHardwareQueryResult_
<a name="VGHardwareQueryResult"></a>
The VGHardwareQueryResult enumeration defines the return values from a hardware query, indicating whether or not the item being queried is hardware accelerated.

```C
typedef enum {
 VG_HARDWARE_ACCELERATED = 0x2200,
 VG_HARDWARE_UNACCELERATED = 0x2201
} VGHardwareQueryResult;
```

#### _vgHardwareQuery_
<a name="vgHardwareQuery"></a>
The `vgHardwareQuery` function returns a value indicating whether a given setting of a property of a type given by key is generally accelerated in hardware on the currently running OpenVG implementation.
The return value will be one of the values `VG_HARDWARE_ACCELERATED` or `VG_HARDWARE_UNACCELERATED`, taken from the `VGHardwareQueryResult` enumeration. The legal values for the setting parameter depend on the value of the key parameter, as indicated by Table 17.

| _Value of_ `key` | _Allowable values for_ `setting` |
| --- | --- |
| `VG_IMAGE_FORMAT_QUERY` |  `VGImageFormat`  [(VGImageFormat)](#VGImageFormat) |
| `VG_PATH_DATATYPE_QUERY` | `VGPathDatatype` [(VGPathDatatype)](#vgPathDataType) |
_Table 17 : Query Key Enumeration Types_

> **Errors**
>
> `VG_ILLEGAL_ARGUMENT_ERROR`
> * if `key` is not one of the values from the `VGHardwareQueryType`
enumeration
> * if `setting` is not one of the values from the enumeration associated with key
