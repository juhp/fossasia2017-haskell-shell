#!/usr/bin/env runghc

import System.Directory

main = do
  dir <- getCurrentDirectory
  files <- getDirectoryContents dir
  mapM_ putStrLn files
