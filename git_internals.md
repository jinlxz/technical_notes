Git Internals Keynotes
---
git stores data as key-value pairs, the most important objects are blob, tree, commit, reference
- blob, used to store file content, content is passed to git, a SHA-1 value is calculated, hash value is used a file name, data is saved as file content
- tree, a tree is a list of mapping of hash value to file name, a tree can include sub-trees, liking folder structure, tree objects are also hashed and stored like blob objects
- commit, a commit object includes a commit message, a referenced top-level tree, a parent commit and so on.
- reference, references are user-friendly named commits, which are stored under `.git/refs` 

blob, tree, commit objects are store under `.git/objects/`, file name is part of SHA-1 value of the object.

HEAD refers to the last reference you commited

index/staging area, a temporay tree object used to store in-progress modifications, it will be used to create a permanent tree object and commit object when committing the changes
