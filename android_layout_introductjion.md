Android Layout Introduction.
---
## 1. ConstraintLayout
Constraintlayout provides the following ability.
- [Relative positioning](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout.html#RelativePositioning)
- [Margins](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout.html#Margins)
- [Centering positioning](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout.html#CenteringPositioning)
- [Circular positioning](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout.html#CircularPositioning)
- [Visibility behavior](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout.html#VisibilityBehavior)
- [Dimension constraints](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout.html#DimensionConstraints)
- [Chains](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout.html#Chains)
- [Virtual Helpers objects](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout.html#VirtualHelpers)
- [Optimizer](https://developer.android.com/reference/androidx/constraintlayout/widget/ConstraintLayout.html#Optimizer)

### 1.1 Relative positioning
It allow you to position a given widget relative to another one. You can constrain a widget on the horizontal and vertical axis:
- Horizontal Axis: left, right, start and end sides
- Vertical Axis: top, bottom sides and text baseline
### 1.2 Margins
enforcing the margin as a space between the target and the source side.

When a position constraint target's visibility is View.GONE, you can also indicate a different margin value to be used using some alternative attributes.
### 1.3 Centering positioning and bias
Positioning a view in the center of parent container with two opposite constraints.

The default when encountering such opposite constraints is to center the widget; but you can tweak the positioning to favor one side over another using the bias attributes:
- `layout_constraintHorizontal_bias`
- `layout_constraintVertical_bias`
 
### 1.4 Circular positioning
You can constrain a widget center relative to another widget center, at an angle and a distance. This allows you to position a widget on a circle (see Fig. 6). The following attributes can be used:

- `layout_constraintCircle` : references another widget id
- `layout_constraintCircleRadius` : the distance to the other widget center
- `layout_constraintCircleAngle` : which angle the widget should be at (in degrees, from 0 to 360)

### 1.5 Visibility behavior
GONE widget will be considered as a point in layout, the margin of GONE widget always be considered as zero.f they have constraints to other widgets they will still be respected, but any margins will be as if equals to zero
### 1.6 Dimensions constraints 
#### 1.6.1 Minimum dimensions on ConstraintLayout
You can define minimum and maximum sizes for the `ConstraintLayout` itself:

- `android:minWidth` set the minimum width for the layout
- `android:minHeight` set the minimum height for the layout
- `android:maxWidth` set the maximum width for the layout
- `android:maxHeight` set the maximum height for the layout
#### 1.6.2 Widgets dimension constraints
The dimension of the widgets can be specified by setting the `android:layout_width` and `android:layout_height` attributes in 3 different ways:

- Using a specific dimension (either a literal value such as `123dp` or a `Dimension` reference)
- Using `WRAP_CONTENT`, which will ask the widget to compute its own size, Constraints will not limit the resulting dimension. but you can also prioritize the constraint with the following parameters
```
app:layout_constrainedWidth=”true|false”
app:layout_constrainedHeight=”true|false”
```
- Using `0dp`, which is the equivalent of "`MATCH_CONSTRAINT`", the default behavior is to have the resulting size take all the available space, there are some other properties to constrain the dimension of a view When a dimension is set to MATCH_CONSTRAINT.
  - set the minimum and maximum value of the dimension.
     ```
     layout_constraintWidth_min and layout_constraintHeight_min
     layout_constraintWidth_max and layout_constraintHeight_max
     ```
  - set the size of this dimension as a percentage of the parent
      ```
      layout_constraintWidth_percent and layout_constraintHeight_percent
      ```      
      To use percent, you need to set the following:   
        - The dimension should be set to `MATCH_CONSTRAINT` (0dp)
        - The default should be set to percent `app:layout_constraintWidth_default="percent"` or `app:layout_constraintHeight_default="percent"`
        - Then set the `layout_constraintWidth_percent` or `layout_constraintHeight_percent` attributes to a value between 0 and 1
#### 1.6.3 Setting ratio of a view.
You need to have at least one constrained dimension be set to 0dp (i.e., MATCH_CONSTRAINT), and set the attribute `layout_constraintDimensionRatio` to a given ratio,
The ratio can be expressed either as:
- a float value, representing a ratio between width and height
- a ratio in the form "width:height"

To constrain one specific side based on the dimensions of another, you can pre append W," or H, to constrain the width or height respectively
### 1.7 Chains
Chains provide group-like behavior in a single axis (horizontally or vertically)
#### 1.7.1 Chain style.
When setting the attribute layout_constraintHorizontal_chainStyle or layout_constraintVertical_chainStyle on the first element of a chain, the behavior of the chain will change according to the specified style (default is CHAIN_SPREAD). 
  - `CHAIN_SPREAD` -- the elements will be spread out (default style)
  - Weighted chain -- in `CHAIN_SPREAD` mode, if some widgets are set to `MATCH_CONSTRAINT`, they will split the available space.
  
    The default behavior of a chain is to spread the elements equally in the available space. If one or more elements are using MATCH_CONSTRAINT, they will use the available empty space (equally divided among themselves). The attribute layout_constraintHorizontal_weight and layout_constraintVertical_weight will control how the space will be distributed among the elements using MATCH_CONSTRAINT
  - `CHAIN_SPREAD_INSIDE` -- similar, but the endpoints of the chain will not be spread out
  - `CHAIN_PACKED` -- the elements of the chain will be packed together. The horizontal or vertical bias attribute of the child will then affect the positioning of the packed elements

#### 1.7.2 Margins and chains
When using margins on elements in a chain, the margins are additive.