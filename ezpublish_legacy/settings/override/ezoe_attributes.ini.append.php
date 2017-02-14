<?php /* #?ini charset="utf8"?

[CustomAttribute_table_summary]
Name=Summary (WAI)
Required=true

[CustomAttribute_scope]
Name=Scope
Title=The scope attribute defines a way to associate header cells and data cells in a table.
Type=select
Selection[]
Selection[col]=Column
Selection[row]=Row

[CustomAttribute_valign]
Title=Lets you define the vertical alignment of the table cell/ header.
Type=select
Selection[]
Selection[top]=Top
Selection[middle]=Middle
Selection[bottom]=Bottom
Selection[baseline]=Baseline

[Attribute_table_border]
Type=htmlsize
AllowEmpty=true

[CustomAttribute_embed_offset]
Type=int
AllowEmpty=true

[CustomAttribute_embed_limit]
Type=int
AllowEmpty=true


[CustomAttribute_embed_target]
# Optional, lets you specify the label name on the html control
Name=Target
# Optional, lets you specify the default value on the html control
#Default=right
# Optional, to set the html title on the input element
#Title=Titles are used for help text, they show up when you hover the html control
Type=select
# Optional, forces user to fill out the html form element
# Note: When combined with select type it will enforce that anything but first option is
#       selected as that is assumed to be a "Please choose one:" option.
#       When combined with checkbox it will enforce that checkbox is checked.
#Required=true
# Selection is needed if type is set to select
Selection[]
Selection[]=Nessuno
Selection[_blank]=Nuova finestra (_blank)

*/ ?>
