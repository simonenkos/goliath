module Main where

import Graphics.Gloss.Interface.Pure.Simulate

main :: IO ()
main =
  simulate display bgColor fps initialModel render update
  where
     display = InWindow "Game Of Life" winSize winOffset
     bgColor = black
     fps     = 60

     initialModel           = makeField winSize cellSize
     render           model = color red (text "Hello!")
     update view step model = model

     winSize   = (700, 700)
     winOffset = (100, 100)

     cellSize = (5, 5)

