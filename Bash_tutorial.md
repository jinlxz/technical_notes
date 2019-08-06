# Bash tutorial
## Quoting
Quoting is used to remove the special meaning of certain characters or words to the shell. Quoting can be used to disable special treatment for special characters, to prevent reserved words from being recognized as such, and to prevent parameter expansion

Each of the metacharacters listed above under DEFINITIONS has special meaning to the shell and must be quoted if it is to represent itself `| & ; ( ) < > space tab`
- non-quoted backslash (\) is the escape character. It preserves the literal value of the next character that follows, with the exception of <newline>.
- Enclosing characters in single quotes preserves the literal value of each character within the quotes
- Enclosing characters in double quotes preserves the literal value of all characters within the quotes, with the exception of ``$, `, \ `` and, when history expansion is enabled, !. The backslash retains its special meaning only when followed by one of the following characters: ``$, ` , " , \ , or < newline >``.
## Shell Commands
### Compound Commands
#### Conditional Constructs
- case statement.

  ```shell
  case word in
      [ [(] pattern [| pattern]…) command-list ;;]…
  esac
  ```
  **The `word` undergoes tilde expansion, parameter expansion, command substitution, arithmetic expansion, and quote removal before matching is attempted. Each `pattern` undergoes tilde expansion, parameter expansion, command substitution, and arithmetic expansion. pattern is matched with rules as pathname expansion.**
  
  There may be an arbitrary number of case clauses, each terminated by a ‘;;’, ‘;&’, or ‘;;&’. The first pattern that matches determines the command-list that is executed. It’s a common idiom to use ‘*’ as the final pattern to define the default case, since that pattern will always match. 
  
  If the ‘;;’ operator is used, no subsequent matches are attempted after the first pattern match. Using ‘;&’ in place of ‘;;’ causes execution to continue with the command-list associated with the next clause, if any. Using ‘;;&’ in place of ‘;;’ causes the shell to test the patterns in the next clause, if any, and execute any associated command-list on a successful match, continuing the case statement execution as if the pattern list had not matched.
- [[]] statement

  **Word splitting and filename expansion are not performed on the words between the [[ and ]]**; tilde expansion, parameter and variable expansion, arithmetic expansion, command substitution, process substitution, and quote removal are performed.
  
  When the ‘==’ and ‘!=’ operators are used, the string to the right of the operator is considered a pattern and matched according to the rules described below in Pattern Matching, as if the extglob shell option were enabled. The ‘=’ operator is identical to ‘==’. 
  
  An additional binary operator, ‘=~’, is available, with the same precedence as ‘==’ and ‘!=’. When it is used, the string to the right of the operator is considered a POSIX extended regular expression and matched accordingly,**The return value is 0 if the substring or full string match the pattern, and 1 otherwise. Any part of the pattern may be quoted to force the quoted portion to be matched as a string. normal quoting characters lose their meanings between brackets. If the pattern is stored in a shell variable, quoting the variable expansion forces the entire pattern to be matched as a string.** Substrings matched by parenthesized subexpressions within the regular expression are saved in the array variable BASH_REMATCH. The element of BASH_REMATCH with index 0 is the portion of the string matching the entire regular expression. The element of BASH_REMATCH with index n is the portion of the string matching the nth parenthesized subexpression. 

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
  
###  Command Substitution
performs the expansion by executing command and replacing the command substitution with the standard output of the command, with any trailing newlines deleted. Embedded newlines are not deleted, but they may be removed during word splitting.If the substitution appears within double quotes, word splitting and pathname expansion are not performed on the results.
### Arithmetic Expansion $((expression))
All tokens in the expression undergo parameter expansion, string expansion, command substitution, and quote removal.
### Process Substitution
Process substitution is supported on systems that support named pipes (FIFOs) or the /dev/fd method of naming open files. It takes the form of **<(list) or >(list)**. The process list is run with its input or output connected to a FIFO or some file in /dev/fd. **The name of this file is passed as an argument to the current command as the result of the expansion. If the >(list) form is used, writing to the file will provide input for list. If the <(list) form is used, the file passed as an argument should be read to obtain the output of list.**
### Word Splitting
The shell scans the results of parameter expansion, command substitution, and arithmetic expansion that did not occur within double quotes for word splitting.

The shell treats each character of IFS as a delimiter, and splits the results of the other expansions into words on these characters. If IFS is unset, or its value is exactly <space><tab><newline>, the default, **then sequences of <space>, <tab>, and <newline> at the beginning and end of the results of the previous expansions are ignored, and any sequence of IFS characters not at the beginning or end serves to delimit words.Any character in IFS that is not IFS whitespace, along with any adjacent IFS whitespace characters, delimits a field.**
### Pathname Expansion
After word splitting, unless the -f option has been set, bash scans each word for the characters ***, ?, and [**. If one of these characters appears, then the word is regarded as a pattern, and replaced with an alphabetically sorted list of file names matching the pattern.

When a pattern is used for pathname expansion, the character ''.'' at the start of a name or immediately following a slash must be matched explicitly, unless the shell option dotglob is set. When matching a pathname, the slash character must always be matched explicitly.

### Redirection
Before a command is executed, its input and output may be redirected using a special notation interpreted by the shell.Each redirection that may be preceded by a file descriptor number may instead be preceded by a word of the form {varname}. In this case, for each redirection the shell will allocate a file descriptor greater than 10 and assign it to varname.

The word following the redirection operator in the following descriptions, unless otherwise noted, is subjected to brace expansion, tilde expansion, parameter expansion, command substitution, arithmetic expansion, quote removal, pathname expansion, and word splitting.
### Aliases
The first word of each simple command, if unquoted, is checked to see if it has an alias. If so, that word is replaced by the text of the alias. The first word of the replacement text is tested for aliases, but a word that is identical to an alias being expanded is not expanded a second time.There is no mechanism for using arguments in the replacement text.

 Aliases are expanded when a command is read, not when it is executed.The commands following the alias definition on that line are not affected by the new alias.Aliases are expanded when a function definition is read, not when the function is executed, because a function definition is itself a compound command. As a consequence, aliases defined in a function are not available until after that function is executed. To be safe, always put alias definitions on a separate line, and do not use alias in compound commands.
###  Functions
When a function is executed, the arguments to the function become the positional parameters during its execution. The special parameter # is updated to reflect the change. Special parameter 0 is unchanged.When a function completes, the values of the positional parameters and the special parameter # are restored to the values they had prior to the function's execution.

Variables local to the function may be declared with the local builtin command. Ordinarily, variables and their values are shared between the function and its caller.

Function names and definitions may be listed with the -f option to the declare or typeset builtin commands. The -F option to declare or typeset will list the function names only 

**Functions may be exported so that subshells automatically have them defined with the -f option to the export builtin. A function definition may be deleted using the -f option to the unset builtin.**
### Simple Command Expansion
shell performs the following expansions, assignments, and redirections, from left to right.**The text after the = in each variable assignment undergoes tilde expansion, parameter expansion, command substitution, arithmetic expansion, and quote removal before being assigned to the variable.**

**Command  substitution,  commands grouped with parentheses, and asynchronous commands are invoked in a subshell environment that is a duplicate of the shell environment,** except that traps caught by the shell are reset to the values that the shell  inherited  from  its  parent  at  invocation. **Builtin  commands  that  are  invoked as part of a pipeline are also executed in a subshell environment.**  Changes made to the subshell environment cannot affect the shell's execution environment.

The shell provides several ways to manipulate the environment. **Environment a list of name-value pairs, On invocation, the shell scans its own environment and creates a parameter for each name found, automatically marking it for export to child processes. Executed commands inherit the environment. Environment differs from variable assignment, which are not being inherited** The export and declare -x commands allow parameters and functions to be added to and deleted from the environment.