# javascript tutorial
## 1. understanding prototype chain.
Everything is object in javascript, including type object and instance object, type object defines a type, which can be instantiated and create new instance object of that type, instance object is created from the corresponding type object.
```JavaScript
function ggg(){
   this.name='hhh'
}
ggg.prototype.xxx=true;
ggg.prototype.kkk=0;
```
**function or class declaration  declares prototype definition of a NEW type object, the above code is equivalent to `ggg.prototype.constructor=ggg`, the Symbol `ggg` only  represents a type object, It is a function or constructor object which is used to construct an instance   object of the declared type, so all type objects are function or constructor.**
### 1.1 Inheritance hierarchy of type object.
The root of all type object is the object **Object.prototype**, all type object originate from it, also it is true for instance object.
- String object --> function () --> Object.prototype --> null
- Number object --> function () --> Object.prototype --> null 
- Object object --> function () --> Object.prototype --> null
- Array object --> function () --> Object.prototype --> null
- Boolean object --> function () --> Object.prototype --> null
- ...

As we can see, most of type objects have a type of **function ()**

For a type object, we have the followings: 
- `Object.prototype` indicates an object whose attributes will be inherited by all instance objects of the type.
- `Object.__proto__` indicates `Object`'s prototype, where attributes of `Object` come from, this also applies for an instance object, but an instance object doesn't have the attribute `prototype` which is dedicated to type object. 
### 1.2 Inheritance hierarchy of instance object.
An instance object contains its own properties and inherits properties from the property **TypeName.prototype** of its type, it means the object indicated by the property **TypeName.prototype** of a type object will be inherited by any instance of that type, the instance object has a property **__proto__** which holds a reference to the object **TypeName.prototype**, all instances of that type share the inherited object.
```javascript
var a=new String();
// a --> String.prototype --> Object.prototype --> null;
function Foo(){this.name="hellp";this.age=20;}
var test=new Foo()
//test --> Foo.prototype --> Object.prototype --> null;
```
You can also define attributes on instance object with the following methods:

1. Those defined inside a constructor function that are given to object instances. These are fairly easy to spot — in your own custom code, they are the members defined inside a constructor using the `this.x = x` type lines; in built-in browser code, they are the members only available to object instances (usually created by calling a constructor using the new keyword, e.g. `let myInstance = new myConstructor()`).
2. Those defined directly on the constructor themselves, that are available only on the constructor. These are commonly only available on built-in browser objects, and are recognized by being chained directly onto a constructor, not an instance. For example, `Object.keys()`. These are also known as static properties/methods.
3. Those defined on a constructor's prototype, which are inherited by all instances and inheriting object classes. These include any member defined on a Constructor's prototype property, e.g. `myConstructor.prototype.x()`.
4. Those available on an object instance, which can either be an object created when a constructor is instantiated like we saw above (so for example `var teacher1 = new Teacher( name = 'Chris' )`; and then `teacher1.name`), or an object literal (`let teacher1 = { name = 'Chris' }` and then `teacher1.name`).
