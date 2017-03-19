#!/usr/bin/env runghc

import System.Directory

main = do
  dir <- getCurrentDirectory
  putStrLn dir
