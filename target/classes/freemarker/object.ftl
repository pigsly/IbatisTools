<#-- new Object-->
<#function newObject objname >
<#assign content>
    ${objname} ${objname?uncap_first} = new ${objname}();	
</#assign>
<#return content>
</#function>

<#-- if_updateResult-->
<#function if_updateResult updateResult >
<#assign content>
    if(${updateResult}>0){
	return Boolean.TRUE;
    }
    return Boolean.FALSE;	
</#assign>
<#return content>
</#function>


