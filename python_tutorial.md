Python tutorial
---
##packaging
When a submodule is loaded using any mechanism (e.g. `importlib` APIs, the `import` or `import-from` statements, or built-in `__import__()`) a binding is placed in the parent module’s namespace to the submodule object. For example, if package `spam` has a submodule `foo`, after importing `spam.foo`, `spam` will have an attribute `foo` which is bound to the submodule.  The invariant holding is that if you have `sys.modules['spam']` and `sys.modules['spam.foo']` (as you would after the above import), the latter must appear as the foo attribute of the former.


The public names defined by a module are determined by checking the module’s namespace for a variable named `__all__`; if defined, it must be a sequence of strings which are names defined or imported by that module. The names given in `__all__` are all considered public and are required to exist. If `__all__` is not defined, the set of public names includes all names found in the module’s namespace which do not begin with an underscore character `('_')`.

### how does function in class becomes to method
```python
class method(object):
    def __init__(self, func, instance, cls):
         self.im_func = func
         self.im_self = instance
         self.im_class = cls

    def __call__(self, *args, **kw):
         # XXX : all sanity checks removed for readability
         if self.im_self:
             args = (self.im_self,) + args
         return self.im_func(*args, **kw)

class function(object):
     def __get__(self, instance, cls):
         return method(self, instance, cls)
```

All `def` definitions in class are normal instances of the type `function`, `Foo.print` attribute reference will take the following steps.  
- method object is initiated with `attribute reference` by descriptor protocol, e.g.  `Foo.print()`, here the attribute `print` has a type `function` which implements descriptor protocol, `__get__` method will be called and `Foo.print` resolves to the return value of the method `__get__`, which is a object of the type `method`.
- construct method attribute with `method.__init__`, storing function name, class instance(self), class object.
method is a wrapper object of the `function definition` with `instance object` and `class object`, it will insert the `instance object` into the argument list of the function when method is called by `__call__`
- the returned method will be called.

END

- [reference 1](https://wiki.python.org/moin/FromFunctionToMethod)
- [implemnt descriptor](https://docs.python.org/3/reference/datamodel.html#descriptors)
- [descriptor](https://docs.python.org/3/glossary.html#term-descriptor)