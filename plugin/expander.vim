" Plugin that expands new lines between brackets and XML-like tags.
" Last Change: 2023 September 26
" Maintainer: Victor S.
" License: This file is placed in the public domain.

" Avoid line-continuation error:
let s:save_cpo = &cpo
set cpo&vim

let g:isExpanderEnabled = 1
let s:maxTagNameLength = 30
let s:maxTagAttributeLength = 200
" Pairs of patterns that describe the opening and closing elements:
let s:pairsToExpand = [
  \ ["(", ")"],
  \ ["[[]", "[]]"],
  \ ["{", "}"],
  \ [
  \   '<\(\%(\w\|:\|-\)\{1,' .. s:maxTagNameLength
  \   .. '}\)\%(\_s\_.\{-,' .. s:maxTagAttributeLength
  \   .. '}\)\?>',
  \   '</\1>'
  \ ],
  \ ["<>", "</>"],
  \ ["<!--", "-->"],
  \ ["<?php", "?>"],
  \ ['"""', '"""'],
  \ ["'''", "'''"],
  \ ]

function! s:GetKeysToPressForExpansion()
  let spaceKey = "\<Space>"
  let outsideIndentInKeys = repeat(spaceKey, indent(line(".")))
  let oneIndentLevel = repeat(spaceKey, &shiftwidth)
  " Keys for: new line, new undo checkpoint, balance delimiter indents, add
  " line in between, balance indent:
  let keysToPress = "\<CR>\<C-g>u0\<C-d>" .. outsideIndentInKeys
    \ .. "\<C-o>\<S-o>0\<C-d>" .. outsideIndentInKeys .. oneIndentLevel
  return keysToPress
endfunction

function! s:IsPatternOnBuffer(_, pattern)
  let searchFlags = "bcW"
  return search(a:pattern, searchFlags) > 0
endfunction

function! s:IsCursorBetweenPair()
  return indexof(s:patternsToExpand, funcref("s:IsPatternOnBuffer")) > -1
endfunction

function! <SID>OnEnterPressed()
  if !g:isExpanderEnabled || !s:IsCursorBetweenPair()
    let enterKeyMappingText = "\<CR>"
    return enterKeyMappingText
  endif
  let expansionKeys = s:GetKeysToPressForExpansion()
  return expansionKeys
endfunction

function! s:MapPairToPattern(_, pair)
  let startOnCursor = '\zs\%#'
  let [openingPattern, closingPattern] = a:pair
  let fullPattern = openingPattern .. startOnCursor .. closingPattern
  return fullPattern
endfunction

function! s:SetupKeyMappings()
  inoremap <unique> <CR> <Plug>ExpanderOnenterpressed;
  inoremap <script> <expr> <Plug>ExpanderOnenterpressed; <SID>OnEnterPressed()
endfunction

function! s:Initialize()
  let s:patternsToExpand = mapnew(
    \ s:pairsToExpand,
    \ funcref("s:MapPairToPattern")
    \ )
  call s:SetupKeyMappings()
endfunction

call s:Initialize()

" Restore cpoptions:
let &cpo = s:save_cpo
unlet s:save_cpo

