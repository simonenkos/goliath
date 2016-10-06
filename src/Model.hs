{-# LANGUAGE ScopedTypeVariables #-}

module Model where

import Control.Monad.Random
import Control.Monad

import Config

data Cell = Cell { xNumber   :: Int,
                   yNumber   :: Int,
                   xPosition :: Float,
                   yPosition :: Float,
                   isAlive   :: Int } deriving Show

type Field = [Cell]

makeField :: MonadRandom m => m Field
makeField = sequence generateCells

generateCells :: MonadRandom m => [m Cell]
generateCells = do
    x <- [0 .. xCount]
    y <- [0 .. yCount]
    return (makeCell x y)
    where
        xCount = div xFieldSize xSize
        yCount = div yFieldSize ySize
        xFieldSize = fst windSize
        yFieldSize = snd windSize
        xSize = fst cellSize
        ySize = snd cellSize

makeCell :: MonadRandom m => Int -> Int -> m Cell
makeCell x y = fmap (cellConstructor . aliveFunction) getRandom where
    aliveFunction seed = mod seed 2
    cellConstructor = Cell x y xSize ySize
    xSize = fromIntegral $ fst cellSize
    ySize = fromIntegral $ snd cellSize