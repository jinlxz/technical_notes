# Bash tutorial
## Quoting
Quoting is used to remove the special meaning of certain characters or words to the shell. Quoting can be used to disable special treatment for special characters, to prevent reserved words from being recognized as such, and to prevent parameter expansion

Each of the metacharacters listed above under DEFINITIONS has special meaning to the shell and must be quoted if it is to represent itself
`| & ; ( ) < > space tab`
- non-quoted backslash (\) is the escape character. It preserves the literal value of the next character that follows, with the exception of <newline>.
- Enclosing characters in single quotes preserves the literal value of each character within the quotes
- Enclosing characters in double quotes preserves the literal value of all characters within the quotes, with the exception of ``$, `, \ `` and, when history expansion is enabled, !. The backslash retains its special meaning only when followed by one of the following characters: ``$, ` , " , \ , or < newline >``.

## Array
Bash provides one-dimensional indexed and associative array variables. Any variable may be used as an indexed array.
Indexed arrays are referenced using integers (including arithmetic expressions) and are zero-based; associative arrays are referenced using arbitrary strings.
ways to initialize an Array
- var[12]=value   ## brackets and index are optional, in this case index assigned will    be incremented by one automatically
- declare -a xxx # indexed Array
- declare -A varname # associative Array
- name=(value1 ... valuen)

usages
- for map Array, ${name[subscript]}, subscript is @ or *, the word expands to all members of name. 
- ${#name[subscript]} expands to the length of ${name[subscript]}. If subscript is * or @, the expansion is the number of elements in the array.
- unset name, where name is an array, or unset name[subscript], where subscript is * or @, removes the entire array.
## Expansion
Expansion is performed on the command line after it has been split into words. There are seven kinds of expansion performed: brace expansion, tilde expansion, parameter and variable expansion, command substitution, arithmetic expansion, word splitting, and pathname expansion.

The order of expansions is: brace expansion, tilde expansion, parameter, variable and arithmetic expansion and command substitution (done in a left-to-right fashion), word splitting, and pathname expansion.

Only brace expansion, word splitting, and pathname expansion can change the number of words of the expansion; other expansions expand a single word to a single word. The only exceptions to this are the expansions of "$@" and "${name[@]}" 
### Brace Expansion
Patterns to be brace expanded take the form of an optional preamble, followed by either a series of comma-separated strings or a sequence expression between a pair of braces, followed by an optional postscript. The preamble is prefixed to each string contained within the braces, and the postscript is then appended to each resulting string, expanding left to right.

- a{d,c,b}e expands into 'ade ace abe'
- {x..y[..incr]}

**A correctly-formed brace expansion must contain unquoted opening and closing braces, and at least one unquoted comma or a valid sequence expression.** Any incorrectly formed brace expansion is left unchanged. Brace expansion introduces a slight incompatibility with historical versions of sh. sh does not treat opening or closing braces specially when they appear as part of a word, and preserves them in the output.
### Tilde Expansion
If a word begins with an unquoted tilde character ('~'), all of the characters preceding the first unquoted slash are considered a tilde-prefix,**the tilde-prefix is replaced with the home directory associated with the specified login name or HOME environment variable if it is null**
- ~john  # expands to path of john's home directory.
- ~   # expands to path of current user's home directory.
### Parameter Expansion
The '$' character introduces **parameter expansion, command substitution, or arithmetic expansion**. The parameter name or symbol to be expanded may be enclosed in braces

If the first character of parameter is an exclamation point (!), a level of variable indirection is introduced. Bash uses the value of the variable formed from the rest of parameter as the name of the variable; this variable is then expanded and that value is used in the rest of the substitution, rather than the value of parameter itself. This is known as indirect expansion. The exceptions to this are the expansions of ${!prefix*} and ${!name[@]} described below. **indirect expansion seems like pointer variable in C**

In each of the cases below, word is subject to tilde expansion, parameter expansion, command substitution, and arithmetic expansion.
- ${parameter:-word} Use Default Values.
- ${parameter:=word} Assign Default Values.
- ${parameter:?word} Display Error if Null or Unset
- ${parameter:offset} ${parameter:offset:length} 
  
  Substring Expansion,If offset evaluates to a number less than zero, the value is used as an offset from the end of the value of parameter.  If parameter is @, the result is length positional parameters beginning at offset. If parameter is an indexed array name subscripted by @ or *, the result is the length members of the array beginning with ${parameter[offset]}, Substring indexing is zero-based unless the positional parameters are used, in which case the indexing starts at 1 by default. If offset is 0, and the positional parameters are used, $0 is prefixed to the list.
- ${!prefix*} ${!prefix@}
  
  Names matching prefix. Expands to the names of variables whose names begin with prefix, separated by the first character of the IFS special variable. When @ is used and the expansion appears within double quotes, each variable name expands to a separate word.
- ${!name[@]} ${!name[*]}
  
  List of array keys. If name is an array variable, expands to the list of array indices (keys) assigned in name. If name is not an array, expands to 0 if name is set and null otherwise. When @ is used and the expansion appears within double quotes, each key expands to a separate word.  
- ${parameter/pattern/string} 

  Parameter is expanded and the longest match of pattern against its value is replaced with string. **If pattern begins with /, all matches of pattern are replaced with string. Normally only the first match is replaced. If pattern begins with #, it must match at the beginning of the expanded value of parameter. If pattern begins with %, it must match at the end of the expanded value of parameter. If string is null, matches of pattern are deleted and the / following pattern may be omitted.** If parameter is @ or *, the substitution operation is applied to each positional parameter in turn, and the expansion is the resultant list. If parameter is an array variable subscripted with @ or *, the substitution operation is applied to each member of the array in turn, and the expansion is the resultant list.
- ${parameter^pattern} ${parameter^^pattern} ${parameter,pattern} ${parameter,,pattern}

  **The ^ operator converts lowercase letters matching pattern to uppercase; the , operator converts matching uppercase letters to lowercase. The ^^ and ,, expansions convert each matched character in the expanded value; the ^ and , expansions match and convert only the first character in the expanded value**. If pattern is omitted, it is treated like a ?, which matches every character. If parameter is @ or *, the case modification operation is applied to each positional parameter in turn, and the expansion is the resultant list. If parameter is an array variable subscripted with @ or *, the case modification operation is applied to each member of the array in turn, and the expansion is the resultant list.