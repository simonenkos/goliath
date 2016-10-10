{-# LANGUAGE ScopedTypeVariables #-}

module Model where

import Control.Monad.Random
import Control.Monad

import Data.Set (fromList, toList, loo)

import Config

data Cell = Cell { xNumber :: Int,
                   yNumber :: Int,
                   isAlive :: Int } deriving (Show, Eq)

instance Ord Cell where
    cella <= cellb = (xNumber cella == xNumber cellb && yNumber cella == yNumber cellb) ||
                     (xNumber cella == xNumber cellb && yNumber cella  < yNumber cellb) ||
                     (xNumber cella  < xNumber cellb && yNumber cella == yNumber cellb) ||
                     (xNumber cella  < xNumber cellb && yNumber cella  < yNumber cellb)


data Field = Field { cells :: Set Cell,
                     xMax  :: Int,
                     yMax  :: Int } deriving Show

makeField :: MonadRandom m => m Field
makeField = fmap constructor $ sequence $ generateCells xCount yCount where
    xCount = div (fst plotSize) $ fst cellSize
    yCount = div (snd plotSize) $ snd cellSize
    constructor cells = Field (fromList cells) xCount yCount

generateCells :: MonadRandom m => Int -> Int -> [m Cell]
generateCells xCount yCount = do
    x <- [0 .. xCount]
    y <- [0 .. yCount]
    return (makeCell x y)

makeCell :: MonadRandom m => Int -> Int -> m Cell
makeCell x y = fmap (cellConstructor . aliveFunction) getRandom where
    aliveFunction seed = mod seed seedDivisor
    cellConstructor = Cell x y

update :: Field -> Float -> Field
update (Field cellList xMaxVal yMaxVal) _ = Field (updateCells $ toList cellList) xMaxVal yMaxVal where
    updateCells              [] = []
    updateCells [cell : others] = modifyCell cell : updateCells others
    --
    modifyCell (Cell x y alive) | alive && (liveCount  < 2)                   = Cell x y False
                                | alive && (liveCount == 2 || liveCount == 3) = Cell x y True
                                | alive && (liveCount  > 3)                   = Cell x y False
                                | otherwise = if liveCount == 3
                                    then Cell x y True
                                    else Cell x y False where
                                        liveCount = liveCellsCount (neighbours x y)
    liveCellsCount [(x, y):xs] = undefined -- ToDo