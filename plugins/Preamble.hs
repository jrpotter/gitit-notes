module Preamble (plugin) where

import Text.Pandoc.Builder
import Network.Gitit.Interface
import Data.Char (toLower)

plugin :: Plugin
plugin = PageTransform prepend

prepend :: Pandoc -> PluginM Pandoc
prepend doc@(Pandoc m blks) = do
    meta <- askMeta
    case lookup "preamble" meta of
      Just s | map toLower s == "true" ->
        return $ Pandoc m (preamble <> blks)
      _      -> return doc

preamble :: [Block]
preamble = toList $ divWith ("", [], [("style", "display:none;")]) $
    plain (math "\\newcommand{\\bbc}{\\mathbb{C}}") <>
    plain (math "\\newcommand{\\bbr}{\\mathbb{R}}")

