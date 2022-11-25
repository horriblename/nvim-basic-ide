; extends
(atx_h1_marker) @Header1
(atx_h2_marker) @Header2
(atx_h3_marker) @Header3
(atx_h4_marker) @Header4
(atx_h5_marker) @Header5
(atx_h6_marker) @Header6

(fenced_code_block
  . (fenced_code_block_delimiter) @tag
  (#set! conceal ""))

(fenced_code_block
  (info_string) @tag.attribute )

(fenced_code_block
  ((fenced_code_block_delimiter)
   @tag
   (#set! conceal "⎯"))
  .)

;; testing
;     (block_quote_marker) @conceal @marker
;     (#set! conceal "▏"))
;
; (block_quote
;     (block_continuation) @conceal @cont
;     (#set! conceal "▏"))
;
; (block_quote
;      (_ (block_continuation) @conceal @nestcont (#set! conceal "▏"))
; )
