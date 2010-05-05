
<#macro convertCarList List5>
<#assign s = "${List5}"?matches("^List<(.*){1}>$")>
<#list s as m>
${m?groups[1]}List
</#list>
</#macro>

<#macro convert2CarList ListType>
<#assign s = "${ListType}"?matches("^List<(.*){1}>$")>
<#list s as m>
	${m?groups[1]}List
</#list>
</#macro>

<#macro convert2Java14List ListType>
<#assign s = "${ListType}"?matches("^List<(.*){1}>$")>
<#list s as m>
	List
</#list>
</#macro>

<#macro addAllCode carModel><#--carModel=Member-->
  <#assign carListType="${carModel?cap_first}List">
  <#assign carListObject="${carModel?uncap_first}List">
    ${carListType} ${carListObject} = new ${carListType}();
    ${carListObject}.addAll(list);
</#macro>
