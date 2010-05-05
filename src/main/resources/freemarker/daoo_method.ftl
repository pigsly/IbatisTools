<#import "dataCarUtils.ftl" as dataCarUtils>
<#import "method.ftl" as method>

<#macro initSelectGrammer statement >
<#assign s = "${statement}"?matches("^[sS]{1}elect[Ff]{1}or(.*){1}(List?|Object?)[Bb]?[y]?(.*)?$")>
<#list s as m>
	<#assign modelObject="${m?groups[1]?uncap_first}">
	<#assign modelType="${m?groups[1]?cap_first}">
	<#assign forType="${m?groups[2]?cap_first}">
	<#if forType="List"||forType="list">
	    <#assign returnType="List">
	    <#assign returnObject="list">
	<#else>
	    <#assign returnType="${modelType}">
	    <#assign returnObject="obj">
	</#if>
	<#assign isSelective="${m?groups[3]?uncap_first}">
	<#assign ByModel="${isSelective}">
	<#if ByModel="selective">
	    <#assign ByType="${modelType}">
	    <#assign ByObject="${modelObject}">
	    <#assign ByModel="${modelObject}">	
	<#else>
	    <#assign ByType="${m?groups[3]?cap_first}">
	    <#assign ByObject="${m?groups[3]?uncap_first}">
	</#if>	
</#list>
</#macro>

<#--Main method-->
<#macro SelectStatement statement>
<@initSelectGrammer statement="${statement}"/>

/** ibatis SQL for ${statement} **/
<#if isSelective="selective">
<@SelectSQLBySelective statement="${statement}"/>
<#else>
<@SelectSQLByNonSelective statement="${statement}"/>
</#if>
/********************************************/

<@method.function returnClass="${returnType}" methodName="${statement}" type="${ByType}" parameter="${ByObject}">
    ${returnType} ${returnObject} = (${returnType}) getSqlMapClientTemplate().queryFor${forType}("${modelType}.${statement}"<#if ByModel!="">, ${ByModel}</#if>) 
  <#if forType="List"||forType="list">
    <@dataCarUtils.addAllCode carModel="${modelType}"/>
    return list;
  <#else>
    return ${returnObject};
   </#if>    
</@method.function>
</#macro>

<#macro SelectSQLByNonSelective statement>
<@initSelectGrammer statement="${statement}"/>
 <!-- Remember: parameterClass needs a classpath-->
 <select id="${statement}" parameterClass="${ByType}" resultMap="ibatorgenerated_BaseResultMap">
    select ${modelObject}.*
    from ${modelType} ${modelObject}, ${ByType} ${ByObject}
    where ${modelObject}.${ByObject}xuid = ${ByObject}.xuid
	and ${ByObject}.xuid = #xuid#
  </select>
</#macro>

<#macro SelectSQLBySelective statement>
<@initSelectGrammer statement="${statement}"/>
 <!-- Remember: parameterClass needs a classpath-->
 <select id="${statement}" parameterClass="${ByType}" resultMap="ibatorgenerated_BaseResultMap">
    select ${modelObject}.*
    from ${modelType} ${modelObject}
    <dynamic prepend="where ">
	<isNotNull prepend="and" property="property1">
	  property1 = #property1:VARCHAR#
        </isNotNull>
        ....This is an optional copy.
	</dynamic>
  </select>
</#macro>

<#--public interface-->
<#function ISelectStatement statement >
<#assign content>
<@SelectStatement statement="${statement}"/>
</#assign>
<#return content>
</#function>

