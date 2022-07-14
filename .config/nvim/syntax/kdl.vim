" Vim syntax file
" Language:     kdl
" Maintainer:   Joseph Ryan
" Last Change:  Jul 10, 2022

if exists('b:current_syntax')
  finish
endif

syn sync minlines=500
let b:current_syntax = 'kdl'

syn keyword kdlBoolean true false
syn keyword kdlNull null

syn keyword kdlTodo TODO FIXME XXX BUG contained
syn region kdlComment start="/\*" end="\*/" contains=@Spell,kdlTodo,kdlComment
syn match kdlLineComment "\/\/.*" contains=@Spell,kdlTodo
syn region kdlDashComment start="/\*" end="\*/" contains=@Spell,kdlTodo,kdlComment

syn match kdlEscape "\\[btnfr"/\\]" contained
syn match kdlEscape "\\u{\x\{1,6\}}" contained
syn match kdlLineEscape "\\$" " TODO: allow comments after line escape
syn match kdlLineEscape "\\" nextgroup=kdlLineComment skipwhite " TODO: allow comments after line escape

syn region kdlString start=/"/ skip=+\\"+ end=/"/ contains=kdlEscape,kdlLineEscape
syn region kdlRawString start=+r\z(#*\)"+ end=+"\z1+ contains=NONE




syn match kdlInteger /[+-]\?\<[1-9]\(_\=\d\)*\>/ display
syn match kdlInteger /[+-]\?\<0\>/ display
syn match kdlInteger /[+-]\?\<0x[[:xdigit:]]\(_\=[[:xdigit:]]\)*\>/ display
syn match kdlInteger /[+-]\?\<0o[0-7]\(_\=[0-7]\)*\>/ display
syn match kdlInteger /[+-]\?\<0b[01]\(_\=[01]\)*\>/ display
syn match kdlInteger /[+-]\?\<\(inf\|nan\)\>/ display

syn match kdlFloat /[+-]\=\<\d\(_\=\d\)*\.\d\+\>/ display
syn match kdlFloat /[+-]\=\<\d\(_\=\d\)*\(\.\d\(_\=\d\)*\)\=[eE][+-]\=\d\(_\=\d\)*\>/ display

syn match kdlDotInKey /\v[^.]+\zs\./ contained display
syn match kdlKey /\v(^|[{,])\s*\zs[[:alnum:]._-]+\ze\s*\=/ contains=kdlDotInKey display
syn region kdlKeyDq oneline start=/\v(^|[{,])\s*\zs"/ end=/"\ze\s*=/ contains=kdlEscape
syn region kdlKeySq oneline start=/\v(^|[{,])\s*\zs'/ end=/'\ze\s*=/

syn region kdlTable oneline start=/^\s*\[[^\[]/ end=/\]/ contains=kdlKey,kdlKeyDq,kdlKeySq,kdlDotInKey

syn region kdlTableArray oneline start=/^\s*\[\[/ end=/\]\]/ contains=kdlKey,kdlKeyDq,kdlKeySq,kdlDotInKey

syn region kdlKeyValueArray start=/=\s*\[\zs/ end=/\]/ contains=@kdlValue

syn region kdlArray start=/\[/ end=/\]/ contains=@kdlValue contained

syn cluster kdlValue contains=kdlArray,kdlString,kdlInteger,kdlFloat,kdlBoolean,kdlDate,kdlComment

hi def link kdlLineComment Comment
hi def link kdlComment Comment
hi def link kdlTodo Todo
hi def link kdlTableArray Title
hi def link kdlTable Title
hi def link kdlDotInKey Normal
hi def link kdlKeySq Identifier
hi def link kdlKeyDq Identifier
hi def link kdlKey Identifier
hi def link kdlDate Constant
hi def link kdlBoolean Boolean
hi def link kdlnull Constant
hi def link kdlFloat Float
hi def link kdlInteger Number
hi def link kdlString String
hi def link kdlRawString String
hi def link kdlLineEscape SpecialChar
hi def link kdlEscape SpecialChar
