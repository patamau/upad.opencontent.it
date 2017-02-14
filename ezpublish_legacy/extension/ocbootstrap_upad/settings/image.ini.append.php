<?php /*

[ImageMagick]
Filters[]=thumb=-resize 'x%1' -resize '%1x<' -resize 50%
Filters[]=centerimg=-gravity center -crop %1x%2+0+0 +repage
Filters[]=strip=-strip
Filters[]=sharpen=-sharpen 0.5
Filters[]=play_watermark=extension/opencontent/design/standard/images/i-play-2.png -composite -gravity Center
Filters[]=play_watermark_big=extension/opencontent/design/ftcoop_base/images/icons/play-btn.png -composite -gravity Center
Filters[]=geometry/scalemin=-geometry %1x%2^
Filters[]=geometry/galleryscale=-gravity center -background %1 -extent %2x%3

[AliasSettings]
AliasList[]=home_in_evidenza
AliasList[]=articlethumbnail
AliasList[]=articleimage
AliasList[]=articlesidethumbnail
AliasList[]=imagefull
AliasList[]=productthumbnail

[home_in_evidenza]
Reference=original
Filters[]=geometry/scalewidthdownonly=404
Filters[]=geometry/crop=404;258;0;0

[articlethumbnail]
Reference=original
Filters[]=geometry/scalewidthdownonly=212
Filters[]=geometry/crop=212;212;0;0

[articlesidethumbnail]
Reference=original
Filters[]=geometry/scalewidthdownonly=50
Filters[]=geometry/crop=50;50;0;0

[articleimage]
Reference=original
Filters[]=geometry/scaleheightdownonly=260
Filters[]=geometry/crop=630;260;0;0

[imagefull]
Reference=original
Filters[]=geometry/scalewidthdownonly=770

[productthumbnail]
Reference=original
Filters[]
Filters[]=geometry/scalewidthdownonly=242
#Filters[]=geometry/crop=242;242;0;0
Filters[]=centerimg=242;242

*/ ?>
