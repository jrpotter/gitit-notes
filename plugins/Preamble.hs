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
    -- Scripting
    plain (math "\\newcommand{\\sbscript}[2]{#1_{\\text{#2}}}") <>
    plain (math "\\newcommand{\\spscript}[2]{#1^{\\text{#2}}}") <>
    -- Caligraphic Text
    plain (math "\\newcommand{\\bbc}{\\mathbb{C}}") <>
    plain (math "\\newcommand{\\bbn}{\\mathbb{N}}") <>
    plain (math "\\newcommand{\\bbq}{\\mathbb{Q}}") <>
    plain (math "\\newcommand{\\bbr}{\\mathbb{R}}") <>
    plain (math "\\newcommand{\\bbz}{\\mathbb{Z}}") <>
    plain (math "\\newcommand{\\bbp}{\\mathbb{P}}") <>
    plain (math "\\newcommand{\\bbps}[1]{\\bbp\\left\\{#1\\right\\}}") <>
    -- Lists
    plain (math "\\newcommand{\\inflate}[3][,]{#2_{1}#1#2_{2}#1\\ldots#1#2_{#3}}") <>
    -- Proofs
    plain (math "\\newcommand{\\forward}{(\\Rightarrow)\\;}") <>
    plain (math "\\newcommand{\\backward}{(\\Leftarrow)\\;}") <>
    -- Vectors
    plain (math "\\newcommand{\\norm}[1]{\\|#1\\|}") <>
    plain (math "\\newcommand{\\dotp}[2]{\\vec{#1}\\cdot\\vec{#2}}") <>
    plain (math "\\newcommand{\\crossp}[2]{\\vec{#1}\\times\\vec{#2}}") <>
    plain (math "\\newcommand{\\bcoor}[2][\\beta]{\\left[#2\\right]_{#1}}") <>
    -- Limits/Differentiation
    plain (math "\\newcommand{\\xlimit}[3][] {\\lim\\limits_{#2\\rightarrow #3^{#1}}}") <>
    plain (math "\\newcommand{\\leibniz}[2][] {\\frac{d#1}{d#2}}")
    

