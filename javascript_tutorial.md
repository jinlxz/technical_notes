# javascript tutorial
## 1. understanding prototype chain.
Everything is object in javascript, including type object and instance object, type object defines a type, which can be instantiated and create new instance object of that type, instance object is create from the corresponding type object.

### 1.1 Inheritance hierarchy of type object.
The root of all type object is the object **Object.prototype**, all type object originate from it, also it is true for instance object.
- String object --> function () --> Object.prototype --> null
- Number object --> function () --> Object.prototype --> null 
- Object object --> function () --> Object.prototype --> null
- Array object --> function () --> Object.prototype --> null
- Boolean object --> function () --> Object.prototype --> null
- ...

As we can see, most of type objects have a type of **function ()**
### 1.2 Inheritance hierarchy of instance object.
An instance object contains its own properties and inherits properties from the property **TypeName.prototype** of its type, it means the object indicated by the property **TypeName.prototype** of a type object will be inherited by any instance of that type, the instance object has a property **__proto__** which holds a reference to the object **TypeName.prototype**, all instances of that type share the inherited object.
```javascript
var a=new String();
// a --> String.prototype --> Object.prototype --> null;
function Foo(){this.name="hellp";this.age=20;}
var test=new Foo()
//test --> Foo.prototype --> Object.prototype --> null;
```