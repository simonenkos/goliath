{-# LANGUAGE ScopedTypeVariables #-}

module Model where

import Control.Monad.Random
import Control.Monad

import Config

data Cell = Cell { xNumber :: Int,
                   yNumber :: Int,
                   isAlive :: Int } deriving Show

data Field = Field { cells :: [Cell],
                     xMax  :: Int,
                     yMax  :: Int } deriving Show

makeField :: MonadRandom m => m Field
makeField = fmap constructor $ sequence $ generateCells xCount yCount where
    xCount = div (fst plotSize) $ fst cellSize
    yCount = div (snd plotSize) $ snd cellSize
    constructor cells = Field cells xCount yCount

generateCells :: MonadRandom m => Int -> Int -> [m Cell]
generateCells xCount yCount = do
    x <- [0 .. xCount]
    y <- [0 .. yCount]
    return (makeCell x y)

makeCell :: MonadRandom m => Int -> Int -> m Cell
makeCell x y = fmap (cellConstructor . aliveFunction) getRandom where
    aliveFunction seed = mod seed 2
    cellConstructor    = Cell x y

update :: Field -> Float -> Field
update (Field cellList xMaxVal yMaxVal) _ = Field (map modifyCell cellList) xMaxVal yMaxVal where
    --
    modifyCell (Cell x y alive) = updateCell x y alive (liveCellCounter (neighbours x y) cellList 0)
    --
    updateCell x y alive liveCount | alive == 1 && (liveCount  < 2)                   = Cell x y 0
                                   | alive == 1 && (liveCount == 2 || liveCount == 3) = Cell x y 1
                                   | alive == 1 && (liveCount  > 3)                   = Cell x y 0
                                   | alive == 0 && (liveCount == 3)                   = Cell x y 1
                                   | otherwise                                        = Cell x y 0
    --
    liveCellCounter [] _  sum = sum
    liveCellCounter _  [] sum = sum
    liveCellCounter ns@((x, y) : xs) cs@(c : oc) sum | normalize x xMaxVal == xNumber c &&
                                                       normalize y yMaxVal == yNumber c = liveCellCounter xs oc (sum + isAlive c)
                                                     | otherwise                        = liveCellCounter ns oc  sum
                                                     where
                                                        normalize coord max | coord >= 0 = mod coord max
                                                                            | otherwise  = mod coord max + 1



