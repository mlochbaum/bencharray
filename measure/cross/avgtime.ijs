meta =: <;._2] 1!:1 <'/tmp/bencharray_meta'
'fn valence iter arrs' =: 3 (({. , ".&.>@}.)@:{. , <@}.) meta
dy =: 2 = valence

data =: 1!:1 <'/tmp/bencharray_data'
get =: 3 : 0
  float =. 'f' = {.y
  byte =. 8 %~ width =. {. n =. ".1}.y
  size =. >. byte * */ shape =. 1}.n
  d =. size {. data
  data =: size }. data
  l =. 2^.1>.byte
  csmall =. ,@:(|."1)@:((8$2)&#:)`(]-256*128&<:)@.(1<width)@:(a.&i.)
  shape $ ((float-l) 3!:(4+float) ])`csmall@.(0=l) d
)
args =: get&.> arrs

(dy{::'ay';'ax ay') =: {.`(<"_1)@.(1<#) |: (-valence) ]\ args
expr =: 'ax '&,^:dy@:,&'&.> ay'
echo -~&>/ (iter 6!:2 expr)&.> '0:';fn
exit ''