{-# LANGUAGE DeriveDataTypeable #-}
{-# OPTIONS_GHC -fno-cse #-}

module Main where

import System.Console.CmdArgs
import Lib

data Photos
  = Upload {originDir :: String}
  | Rename {sourceDir :: String}
  deriving (Show, Data, Typeable)

upload = Upload{originDir = def}

rename = Rename{sourceDir = def}
  &= auto

commands = modes [rename, upload]
  &= help "Organize photos"

main = print =<< cmdArgs commands

