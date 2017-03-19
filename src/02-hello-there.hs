#!/usr/bin/env runghc

echo = putStrLn

echo_n = putStr

main = do
  echo_n "Hello "
  echo "there!"
