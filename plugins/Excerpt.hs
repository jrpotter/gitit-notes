-- Given a target file, the following finds the "excerpts" (divs with the "excerpt" class) of the "data-target" attribute
-- and places it into the current page. This avoids redundancies formed when constructing landing pages for example.
-- By default, the module finds the first excerpt and uses this. If the need arises for more precise specification, I'll
-- revise accordingly.
module Excerpt (plugin) where

import Text.StringLike
import Text.HTML.TagSoup
import Text.Pandoc
import Text.Pandoc.Builder

import Network.Gitit.Interface

import System.Directory
import Data.List (delete)
import Control.Monad (liftM)
import Codec.Binary.UTF8.String (decode)
import Data.ByteString.Lazy as B hiding (map, head, elem, filter)


-- Utility
-- =========================================================================

-- Wrapper function to convert from StringLike objects to Strings
-- Useful for converting between Bytestrings and strings in code
attrTran :: Text.StringLike.StringLike str => [(str, str)] -> [(String, String)]
attrTran as = map (\(x, y) -> (toString x, toString y)) as

-- Given a list of tuple pairs corresponding to attribute and value,
-- return the given value, or an empty string if not found
search :: String -> [(String, String)] -> String
search s [] = ""
search s (x:xs)
    | s == fst x = toString $ snd x
    | otherwise = search s xs


-- Pandoc/HTML Manipulation
-- =========================================================================

-- Error for nonexistent files
excerptMissing :: String -> [Block]
excerptMissing fileName = toList $
    rawBlock "html" ("<span class='error'>File " ++ fileName ++ " not found!</span>")

-- Display the source of the excerpt as a header
addHeader :: String -> String -> String
addHeader fileName content = "<div class='header'>Excerpt from: " ++ fileName ++ "</div>" ++ content

-- Checks that the given div has an excerpt class attribute
-- This is used when filtering through a target document
isExcerpt :: Text.StringLike.StringLike str => Tag str -> Bool
isExcerpt (TagOpen _ xs) = elem "excerpt" (words $ search "class" $ attrTran xs)
isExcerpt _ = False

-- Returns the page offsetted by the first instance of "excerpt"
-- Remember, we are actually opening another file and parsing the HTML;
-- the Pandoc instance refers to the document pulling from the other one
stream :: Text.StringLike.StringLike str => [Tag str] -> [Tag str]
stream tags = process $ sections isExcerpt tags
    where process [] = []
          process (x:xs) = x

-- Returns the bytestring corresponding to the first excerpt found
fromTagText' :: [Tag B.ByteString] -> B.ByteString
fromTagText' [] = B.empty
fromTagText' xs = fromTagText . head $ filter isTagText xs

-- Given the block to pull content from, attempts to read in the file
-- and pull in the given excerpt. Must format the given data into a
-- series of blocks for proper rendering back out
extract :: Block -> String -> IO [Block]
extract (Div (_, _, attrs) _) target = do
    let targetPath = "wikidata" ++ target ++ ".page"
    fileExists <- doesFileExist targetPath
    if not fileExists
       then return (excerptMissing targetPath)
       else do tags <- liftM parseTags (B.readFile targetPath)
               let content = decode . B.unpack $ fromTagText' (stream tags)
               return . body $ readMarkdown def (addHeader target content)
    where body (Pandoc _ bs) = bs
extract _ _ = return []


-- Main
-- =========================================================================

plugin :: Plugin
plugin = mkPageTransformM transform

-- Looks for divs with the extract class and corresponding target
transform :: Block -> PluginM Block
transform b@(Div (_, classes, attrs) contents)
    | "extract" `elem` classes = do
        let target = search "data-target" attrs
        let classes' = delete "extract" classes
        let attrs' = delete ("data-target", target) attrs
        excerpt <- liftIO $ extract b target
        let extracted = divWith ("", ["extracted"], []) (fromList excerpt)
        return $ Div ("", classes', attrs') $ (toList extracted) <> contents
transform b = return b

