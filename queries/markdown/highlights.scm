; extends
(atx_h1_marker) @Header1
(atx_h2_marker) @Header2
(atx_h3_marker) @Header3
(atx_h4_marker) @Header4
(atx_h5_marker) @Header5
(atx_h6_marker) @Header6

;; testing
; (block_quote 
;   (block_quote_marker) @conceal
;   [
; 	(_ (block_continuation) @conceal)
; 	(block_continuation) @conceal 
; 	]* 
;   (#set! conceal "▏"))
