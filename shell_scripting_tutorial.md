# Shell scripting tutorial
## Chapter 3. Searching and Substitutions
### Regular expression
- An equivalence class is used to represent different characters that should be treated the same when matching. Equivalence classes enclose the name of the class between  [= and =]. 
- Collating  is the act of giving an ordering to some group or set          of items. A POSIX collating element consists of the name of the          element in the current locale, enclosed by  [. and .].
- character classes          represent classes of characters, such as digits, lower- and          uppercase letters, punctuation, whitespace, and so on. They are          written by enclosing the name of the class  in [: and :]

Differences between BRE and ERE
- Metacharacters `\ . * ^ $ [...] ` for both BRE and ERE.
- `\{n,m\},\(\), \n` (back reference), for BRE only.
- `{n,m}, +, ?, |, ()` for ERE only.

`[...]` Ranges now work based on each character’s defined position in the locale’s            collating sequence, which is unrelated to machine character-set numeric values. Therefore, the range notation is portable only for programs running in the "POSIX" locale. The POSIX character class notation, mentioned earlier in the chapter, provides a way to portably express concepts such as “all the digits,” or “all alphabetic characters.” Thus, ranges in bracket expressions are discouraged in new programs.

Within bracket expressions, all other metacharacters lose their special meanings. Thus, `[*\.]` matches a literal asterisk, a literal backslash, or a literal period. To get a ] into the set, place it first in the list: `[]*\.]` adds the ] to the list. To get a minus character into the set, place it first in the list: `[-*\.]`. If you need both a right bracket          and a minus, make the right bracket the first character, and make the minus the last one in the list: `[]*\.-]`.

### sed utility
sed’s operation is straightforward. Each file named on the command line is opened and        read, in turn. If there are no files, standard input is used, and the filename "-" (a single dash) acts        as a pseudonym for standard input.

sed’s operation is straightforward. Each file named on the command line is opened and        read, in turn. If there are no files, standard input is used, and the filename "-" (a single dash) acts as a pseudonym for standard input.
- Occasionally it’s useful to apply a command to all lines              that don’t match a particular pattern. You specify this by adding an !              character after a regular expression to look for
- you can specify a trailing number to indicate that the          nth occurrence should be replaced
- While you          can string multiple instances of sed together in a pipeline, it’s easier to          give sed multiple commands. On          the command line, this is done with the -e option
- sed          remembers the last regular expression used at any point in a script.          That same regular expression may be reused by specifying an empty          regular expression
- As in the shell and many other Unix scripting languages, the          # is a comment. sed comments have to appear on their own          lines
- Occasionally it’s useful to apply a command to all lines              that don’t match a particular pattern. You              specify this by adding an !              character after a regular expression to look for
- **a regular expression matches the longest, leftmost substring of the input text that can match the entire expression. Consistent with the whole match being the longest of the leftmost
- matches, each subpattern, from left to right, shall match the longest possible string.**

### cut utility
Cut out the named fields or ranges of input characters.When processing fields, each delimiter character separates fields. **The output fields are separated by the given delimiter character.** Read standard input if no files are given on the command line.
- `cut -d <delim> -f list` ## Cut based on fields. list is a comma-separated list of field numbers or ranges, The default delimiter is the tab character.
- `cut -c list `  ## Cut based on characters. list is a comma-separated list of character numbers or ranges, such as 1,3,5-12,42.

### Joining Fields with join
Read file1 and file2, merging records based on a                common key. By default, runs of whitespace separate fields.The output consists of the common key, the rest of the record from file1, followed by the rest of                the record from file2. If file1 is -, join reads standard input. The first field of each file is the default key upon which to join; this can be changed with -1 and -2. Lines without keys in both files are not printed by default.
- `join -1 field1 -2 field2 file1 file2` ###Specifies the fields on which to join. -1 field1 specifies field1 from file1, and -2 field2 specifies field2 from file2. Fields are numbered from one, not from zero.
### Rearranging Fields with awk
awk reads records (lines) one at a time from each file named on the command line (or standard input if none). For each line, it applies the commands as specified          by the program to the line. 
- you can set a `field separator` to a full ERE, in which case each occurrence of text that matches that ERE acts as a field separator.
- You can change the output field separator by setting the OFS variable. You do this on the command line with the -v option, which sets awk’s variables
## Chapter 4. Text Processing Tools
### sort utility
Sort input lines into an order determined by the key field and datatype options, and the locale.
#### sorting by fields
With the -t option, the specified character delimits fields, and whitespace is significant. Thus, a        three-character record consisting of space-X-space has one field without -t, but three with -t' '

The -k option is followed by a field number, or number pair, optionally separated by whitespace after -k. Each number may be suffixed by a dotted character position, and/or some modifier letters which are used to define specific sorting behavior and whose value are same as the corresponding options passed on command line.

If only one field number is specified, the sort key begins at the start of that field, and continues to the end of the record(not the end of the field).If a comma-separated pair of field numbers is given, the sort key starts at the beginning of the first field, and finishes at the end of the second field.

With a dotted character position, comparison begins (first of a number pair) or ends (second of a number pair) at that character position: -k2.4,5.6 compares starting with the fourth character of the second field and ending with the sixth character of the fifth field.

When multiple -k options are given, sorting is by the first key field, and then, when records match in that key, by the second key field, and so on.
#### sorting text blocks.
The sorting trick is to use the ability of awk to handle more-general record separators to recognize paragraph breaks, temporarily replace the line breaks inside each address with an otherwise unused character, such as an unprintable control character, and replace the paragraph break with a newline.

in awk Using RS="" is a special case, whereby records are separated by blank lines; i.e., each block or "paragraph" of text forms a separate record.