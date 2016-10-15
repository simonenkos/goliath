module Config where

cellSize = (5,   5)   :: (Int, Int)
plotSize = (500, 500) :: (Int, Int)

cellPadding = 0.5 :: Float
seedDivisor = 100 :: Int

-- ToDo make this comfortable for continues search!
neighbours x y = [(x - 1, y - 1), (x, y - 1), (x + 1, y - 1),
                  (x - 1, y    ),             (x + 1, y    ),
                  (x - 1, y + 1), (x, y + 1), (x + 1, y + 1)]
