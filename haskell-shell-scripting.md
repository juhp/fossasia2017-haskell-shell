% ![](HaskellLogoStyPreview-1.png "Haskell Logo")\
  Haskell Shell Scripting workshop
% Jens Petersen (juhp)
% FOSSASIA 2017 March 19th, Singapore

# Haskell Shell Scripting (Jens Petersen)

Slides: <http://code.haskell.org/~juhp/talks/fossasia2017-haskell-shell>\
        (<http://bit.ly/2meIagR>)

## Prerequisites

```
git clone https://github.com/juhp/fossasia2017-haskell-shell
```

To follow along on your computer you will need to have __`ghc`__ installed.

<https://www.haskell.org/ghc/> (>100MB)

### Docker image (1.5GB)

```bash
$ docker load -i fedora-haskell-shell-docker-image.tar.gz
$ cd fossasia2017-haskell-shell/src
$ docker run -it -v$PWD:/src:z juhp/fedora-haskell-shell
```

# About you

How many people are familiar with Shell Scripting?

How many people have done some programming in Haskell?

How many people have GHC installed?

# About me

Jens Petersen

- using Haskell since 1998
- maintain the Fedora Haskell packages
- Haskell Stackage curator
- Red Hat: i18n Software Engineering, based in Japan

# What is shell script?

```bash
#!/bin/sh

LANG=en_US.utf8 LC_COLLATE=C XMODIFIERS=@im=none /usr/bin/emacs -g 167x51 $@
```

Traditional shell good for short quick scripting or wrappers.

```bash
#!/bin/sh

diff -u --exclude="*.src.rpm" --exclude="*.tar.bz2" \
  --exclude="*.tar.gz" --exclude="*.tgz" --exclude="*~" \
  --exclude=".build-*.log" --exclude="CVS" --exclude="FC-*" \
  --exclude="RHEL-*" --exclude="branch" --exclude="i386" \
  --exclude="x86_64" --exclude=".#*" --exclude="_darcs" --exclude=".git" \
  $*

```

Portable (though easily broken)

but hard to maintain as scripts grow/snowball.

# Motivation

## Correctness

```bash
#!/bin/sh

echo "Hello!" +1

MY_NAME=bob
echo $MYNAME
```

Does it run? Is it correct?

```bash
#!/bin/sh

echo "Hello here!
```

- Runtime vs compile time errors

## Shell quoting and newline handling complicated

- `"ls"` vs `"echo $(ls)"`
- `$@` and `$*`

[ShellCheck](http://www.shellcheck.net/) finds bugs in your shell scripts!

# Hello World Haskell script

`src/01-hello.hs`:

```haskell
#!/usr/bin/env runghc

main = putStrLn "hello!"
```

Haskell programs need `main` to be defined.

Run:

```bash
$ cd src
$ runghc 01-hello.hs
$ chmod u+x 01-hello.hs
$ ./01-hello.hs           # interpreted
$ ghc 01-hello.hs         # static linking
$ ./01-hello
$ ghc -dynamic 01-hello   # dynamic linking
```

Interactive interpreter ghci:

```bash
$ ghci 01-hello.hs
GHCi, version 7.10.3: http://www.haskell.org/ghc/  :? for help
Ok, modules loaded: Main.
Prelude Main> main
hello!
Prelude Main> :quit
Leaving GHCi.
```

# Why Functional Programming?

- Pure function composition
- Referential transparency
- Immutable predictability

- scalabilty and maintainability

# Haskell

In this workshop you will just learn enough Haskell required for basic scripting.

# Why Haskell?

Haskell is a

- Functional
- Pure
- Lazy
- *Statically typed*

programming language.

Typed lambda calculus!

Haskell has a strong community around it.

# Functional

- functions are first-class
- evaluation of expressions rather than
  executing instructions
  (functional vs imperative)

# Pure

- variables and data structures are immutable
- expressions do not have “side effects”
- calling the same function with same args gives same result every time: *deterministic*

⇓

- Equational reasoning
- Easy refactoring
- Parallelism

# Lazy
- evaluation by need

⇓

- can easily define control structures
- allows handling of infinite data structures

# Statically typed

- Every Haskell expression has a type
- Types are type-checked at compile-time
- Programs with type errors or mismatches will not compile

# Haskell 25 years old
designed by a committee of CS academics in the late 80's

to create a standard lazy functional programming language

![](HaskellLogoStyPreview-1.png "Haskell Logo")

# Haskell uses indentation heavily like Python

`02-hello-there.hs`:

```haskell
#!/usr/bin/env runghc

echo = putStrLn

main = do
  echo "Hello"
  echo "there!"
```

# Why ghc?

Compiled and interpreted

Standard Haskell compiler and libraries

Fast compile and runtime

Can compile final script and deploy it.

# Variables

`03-pwd.hs`

```haskell
#!/usr/bin/env runghc

import System.Directory

main = do
  dir <- getCurrentDirectory
  putStrLn dir
```

# Haskell Basic types

`::` = "has type"


```haskell
True :: Bool

1 :: Int                 -- machine integers

'a' :: Char
"Hello!" :: String

() :: ()
```

# Lists

`[a]` is a list of elements of type `a`

The type variable `a` is an example of polymorphism.

List examples
```haskell
-- empty list
[] :: [a]

[True, False, True] :: [Bool]

[1..5] :: [Int]

["Haskell", "is", "good"] :: [String]

```

Note `['a', 1, True]` is not a valid Haskell list!

# List append

```haskell
(++) :: [a] -> [a] -> [a]

[1, 2] ++ [3, 4] ⟹ [1, 2, 3, 4]
```

# Laziness

Lazy evaluation allows infinite lists:

```haskell
naturals = [0..]
```

```haskell
take :: Int -> [a] -> [a]

take 5 naturals
==> [0, 1, 2, 3, 4]
```

# The IO Monad

```haskell
putStrLn :: String -> IO ()

getLine :: IO String
```

# do blocks
```haskell
main = do
  let greet = "Hello"
  name <- getLine
  putStrLn $ greet ++ " Your name is " ++ name
```

# Exercise

Let's implement simple `ls` command in Haskell using:

```haskell
getDirectoryContents :: FilePath -> IO [FilePath]

sort :: Ord a => [a] -> [a]
```

`04-ls.hs`

# `import System.Process`

Exec:

```haskell
callProcess :: FilePath -> [String] -> IO ()

callProcess "git" ["pull", "repos.git"]
```

Shell command:

```haskell
callCommand :: String -> IO ()

callCommand "du * 2>/dev/null"
```

```haskell
Prelude> :type unlines
unlines :: [String] -> String
Prelude> unlines ["one", "two", "three"]
"one\ntwo\nthree\n"
```

```haskell
readProcess :: FilePath -> [String] -> String -> IO String

files <- getDirectoryContents "."
readProcess "grep" [".hs"] (unlines files)
```

```haskell
filter :: (a -> Bool) -> [a] -> [a]
isSuffixOf :: (Eq a) => [a] -> [a] -> Bool

hsfiles = filter (isSuffixOf ".hs") files
```

## Exit codes

```haskell
rawSystem :: String -> [String] -> IO ExitCode

system :: String -> IO ExitCode
```

```haskell
result <- rawSystem "diff" ["-q", file1, file2]
case results of
  ExitSuccess -> putStrLn "same"
  ExitFailure _ -> putStrLn "different"
```

```haskell
readProcessWithExitCode :: FilePath -> [String] -> String -> IO (ExitCode, String, String)

(res, out, err) <- readProcessWithExitCode "gcc" ["-o", "test", "test.c"]
```

# Simple "pipes"

```bash
$ ls | grep hs
```

```haskell
readProcess "ls" [] "" >>= readProcess "grep" ["hs"]
```

# HSH library

has real pipes

```haskell
runIO :: ShellCommand a => a -> IO ()

runIO $ "ls" -|- length
```

# Lazy IO vs Streaming

Turtle supports streaming

# async

Shelly and Turtle support running shell commands through the `async` library

```haskell
import Control.Concurrent.Async

bg <- async (readProcess "du" ["/etc"] "")
bg2 <- async (rawSystem "sleep" ["5"])
doSomeOtherStuff
res <- poll bg
wait bg2
```

# Shell Monads

- [turtle](https://hackage.haskell.org/package/turtle)

- [Shelly](https://hackage.haskell.org/package/shelly)

## Haskell replacement for Make

- [shake](https://hackage.haskell.org/package/shake)
    - [Development.Shake.Command](https://hackage.haskell.org/package/shake/docs/Development-Shake-Command.html)


# Haskell Resources

![](HaskellLogoStyPreview-1.png "Haskell Logo")

- <http://haskell.org>
- <http://www.seas.upenn.edu/~cis194/>
- <http://haskellbook.com>
- <https://www.schoolofhaskell.com/>

## Haskell Shells

- https://github.com/Gabriel439/Haskell-Turtle-Library/blob/master/slides/slides.md
- https://github.com/jgoerzen/hsh/wiki
- http://shakebuild.com/

# Thanks!

Questions?

## Slides

<http://code.haskell.org/~juhp/talks/fossasia2017-haskell-shell/>

generated with [Pandoc](http://pandoc.org) and [Slidy2](https://www.w3.org/Talks/Tools/Slidy2)

from <https://github.com/juhp/fossasia2017-haskell-shell/>

## Contact

Github/Twitter: @juhp
