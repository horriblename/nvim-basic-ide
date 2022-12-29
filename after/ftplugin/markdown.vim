" temporary solution for concealing `>` of quote blocks
syn match quoteMarker /"^\s*>"/ms=me-1 conceal cchar=▌
