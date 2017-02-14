{set_defaults( hash(
  'l10n', 'shortdatetime'	
))}

<span class="date text-muted">{$node.object.published|l10n( shortdate )}</span>