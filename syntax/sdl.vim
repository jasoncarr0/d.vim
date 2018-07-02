" Vim syntax file for DUB configurations."
"
" Language:     SDLang (dub config)
" Maintainer:   Jesse Phillips <Jesse.K.Phillips+D@gmail.com>
" Last Change:  2015-07-11
"
" Contributors:
"   - Joakim Brannstrom <joakim.brannstrom@gmx.com>
"
" Please submit bugs/comments/suggestions to the github repo:
" https://github.com/JesseKPhillips/d.vim

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" General matchers
syn match sdlAssign         contained "="
syn match sdlAttribute      "\w*\s*=" contains=sdlAssign
syn match sdlStatement      "^\s*[a-zA-Z:]*"

" Keyword grouping
syn keyword sdlInfo         name description copyright authors license
syn keyword sdlStructure    buildRequirements buildType configuration
syn keyword sdlBoolean      true false on off

syn keyword sdlTodo         contained TODO FIXME XXX

" sdlCommentGroup allows adding matches for special things in comments
syn cluster sdlCommentGroup   contains=sdlTodo

" Highlight % items in strings.
syn match   sdlFormat     display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained

" sdlCppString: same as sdlString, but ends at end of line
syn region  sdlString     start=+\(L\|u\|u8\|U\|R\|LR\|u8R\|uR\|UR\)\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,sdlFormat,@Spell extend
syn region  sdlCppString  start=+\(L\|u\|u8\|U\|R\|LR\|u8R\|uR\|UR\)\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,sdlFormat,@Spell

syn cluster sdlStringGroup    contains=sdlCppString

" Comments
syn region  sdlCommentL   start="//" skip="\\$" end="$" keepend contains=@sdlCommentGroup,cSpaceError,@Spell
syn region  sdlComment    matchgroup=cCommentStart start="/\*" end="\*/" contains=@sdlCommentGroup,sdlCommentStartError,cSpaceError,@Spell fold extend
" keep a // comment separately, it terminates a preproc. conditional
syn match   sdlCommentError       display "\*/"
syn match   sdlCommentStartError  display "/\*"me=e-1 contained

"integer number, or floating point number without a dot and with "f".
syn case ignore
syn match   sdlNumbers    display transparent "\<\d\|\.\d" contains=sdlNumber,sdlFloat,cOctalError,sdlOctal
" Same, but without octal error (for comments)
syn match   sdlNumbersCom display contained transparent "\<\d\|\.\d" contains=sdlNumber,sdlFloat,sdlOctal
syn match   sdlNumber     display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
"hex number
syn match   sdlNumber     display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
" Flag the first zero of an octal number as something special
syn match   sdlOctal      display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=sdlOctalZero
syn match   sdlOctalZero  display contained "\<0"
syn match   sdlFloat      display contained "\d\+f"
"floating point number, with dot, optional exponent
syn match   sdlFloat      display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
"floating point number, starting with a dot, optional exponent
syn match   sdlFloat      display contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syn match   sdlFloat      display contained "\d\+e[-+]\=\d\+[fl]\=\>"
syn case match

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link sdlInfo                 Constant
hi def link sdlAssign               Special
hi def link sdlBoolean              Boolean
hi def link sdlFormat               SpecialChar
hi def link sdlCppString            sdlString
hi def link sdlCommentL             sdlComment
hi def link sdlNumber               Number
hi def link sdlOctal                Number
hi def link sdlOctalZero            PreProc  " link this to Error if you want
hi def link sdlFloat                Float
hi def link sdlCommentError         Error
hi def link sdlCommentStartError    Error
hi def link sdlStructure            Structure
hi def link sdlString               String
hi def link sdlComment              Comment
hi def link sdlTodo                 Todo
hi def link sdlStatement            Statement
hi def link sdlAttribute            Tag

let b:current_syntax = "sdl"
