{-# LANGUAGE ScopedTypeVariables #-}

module Model where

import Control.Monad.Random
import Control.Monad

import Config

data Cell = Cell { xNumber :: Int,
                   yNumber :: Int,
                   isAlive :: Int } deriving Show

type Field = [Cell]

makeField :: MonadRandom m => m Field
makeField = sequence generateCells

generateCells :: MonadRandom m => [m Cell]
generateCells = do
    x <- [0 .. xCount]
    y <- [0 .. yCount]
    return (makeCell x y)
    where
        xCount = div xWindSize xCellSize
        yCount = div yWindSize yCellSize
        xWindSize = fst windSize
        yWindSize = snd windSize
        xCellSize = fst cellSize
        yCellSize = snd cellSize

makeCell :: MonadRandom m => Int -> Int -> m Cell
makeCell x y = fmap (cellConstructor . aliveFunction) getRandom where
    aliveFunction seed = mod seed 10
    cellConstructor = Cell x y