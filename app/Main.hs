{-# LANGUAGE DeriveDataTypeable #-}
{-# OPTIONS_GHC -fno-cse #-}

module Main where

import Data.Either
import System.Console.CmdArgs
import System.Directory
import System.Process
import Control.Monad (forM_)
import Filesystem
import Lib
import Graphics.HsExif

data Photos
  = Upload {origin :: String}
  | Rename {source :: String, destination :: String}
  deriving (Show, Data, Typeable)

upload = Upload{origin = def}

rename = Rename{source = def, destination = def}
--  &= auto

commands = modes [rename, upload]
  &= help "Organize photos"

process (Rename source destination) = do
 
  a <- readProcess "exiftool"
    [ "-d", destination ++ "/%%e/%Y/%m"
    , "-directory<filemodifydate"
    , "-directory<createdate"
    , "-directory<datetimeoriginal"
    , "-r"
    , source
    ] []

  putStr a

doSomething cli = do
  process cli

main = doSomething =<< cmdArgs commands

