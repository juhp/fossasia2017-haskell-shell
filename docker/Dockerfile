FROM fedora:25
MAINTAINER Jens Petersen <petersen@fedoraproject.org>
# Haskell ghc, HP core libs, cabal, stack

RUN dnf -y update
RUN dnf -y install ghc-libraries alex cabal-install happy git-core hlint ghc-shelly-devel ghc-HSH-devel ghc-shake-devel ShellCheck  ghc-HTTP-devel ghc-HUnit-devel ghc-QuickCheck-devel ghc-async-devel ghc-attoparsec-devel ghc-case-insensitive-devel ghc-fgl-devel ghc-hashable-devel ghc-mtl-devel ghc-network-devel ghc-old-locale-devel ghc-old-time-devel ghc-parallel-devel ghc-parsec-devel ghc-primitive-devel ghc-random-devel ghc-regex-base-devel ghc-regex-compat-devel ghc-regex-posix-devel ghc-split-devel ghc-stm-devel ghc-syb-devel ghc-text-devel ghc-unordered-containers-devel ghc-vector-devel ghc-zlib-devel  dnf-plugins-core
RUN dnf -y copr enable petersen/stack && dnf -y install stack
RUN cabal update && cabal install turtle

CMD [ "/bin/bash" ]
