module Model where

data Cell = Cell {
    x :: Int,
    y :: Int,
    isAlive :: Bool
}

type Field = [Cell]

makeField :: (Int, Int) -> (Int, Int) -> Field
makeField filedSize cellSize = undefined