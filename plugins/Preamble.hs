module Preamble (plugin) where

import Text.Pandoc.Builder
import Network.Gitit.Interface

plugin :: Plugin
plugin = PageTransform prepend

prepend :: Pandoc -> PluginM Pandoc
prepend doc@(Pandoc m blks) = do
    meta <- askMeta
    case lookup "preamble" meta of
      Just s -> return $ Pandoc m (preamble <> blks)
      _      -> return doc

preamble :: [Block]
preamble = toList $
    rawBlock "html" "<p style=\"display: none\">" <>
    plain (fromList [Str "Test", Space, Str "Test"]) <>
    rawBlock "html" "</p>"

