<?php /* #?ini charset="utf-8"?

[ezjscServer]
# List of permission functions as used by the eZ Publish permission system
FunctionList[]=ocuserregistertools

# Settings for setting up a server functions
# These are also supported by ezjscPacker, the class used in ezcss and ezscript
# Here is an example of setting up such a function:
#
[ezjscServer_ocuserregistertools]
## Optional, uses <custom_server> as class name if not set
Class=ocurtAjaxFunction
## Optional, defines if a template is to be executed instead of a php class function
## In this case request will go to /templates/<class>/<function>.tpl
#TemplateFunction=true
## Optional, uses autoload system if not defined
File=extension/ocuserregistertools/classes/ocurtAjaxFunction.php
## Optional, List of [ezjscServer]FunctionList functions user needs to have access to, Default: none
Functions[]=ocuserregistertools
## Optional, If pr function, then function name will be  appended to Function name like
## <FunctionList_name>_<funtion_name>, warning will be thrown if not set in FunctionList[].
## Default: disabled
#PermissionPrFunction=enabled
#
# Definition of use in template:
# {ezscript('<custom_server>::<funtion_name>[::arg1[::arg2]]')}

*/ ?>
