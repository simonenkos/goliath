module Main where

import Graphics.Gloss.Interface.IO.Simulate

import Model
import Render
import Config

main :: IO ()
main = do
    initialModel <- makeField
    simulateIO display bgColor fps initialModel renderModel updateModel
    where
        display = InWindow "The Game Of Life" (fst plotSize + 20, snd plotSize + 20) (100, 100)
        bgColor = black
        fps     = 60

        renderModel        model = return (render model)
        updateModel _ step model = return (update model step)
