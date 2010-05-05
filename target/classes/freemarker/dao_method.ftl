<#import "method.ftl" as method>

<#macro selectAll tablename ibatisid>
public List selectAll() {
    <#if ibatisid="">
    List list = getSqlMapClientTemplate().queryForList("${tablename}.ibatorgenerated_selectAll");
    <#else>
    List list = getSqlMapClientTemplate().queryForList("${tablename}.${ibatisid}");
    </#if>
    return list;
}
</#macro>

<#macro selectByMasterKey tablename modelname ibatisid parentid>
public List selectByMasterKey(String parid) {
    ${modelname} key = new ${modelname}();
    key.set${parentid?cap_first}(${parentid});
    <#if ibatisid="">
    List list = getSqlMapClientTemplate().queryForList("${tablename}.ibatorgenerated_selectByMasterKey", key);
    <#else>
    List list = getSqlMapClientTemplate().queryForList("${tablename}.${ibatisid}", key);
    </#if>
    return list;
}
</#macro>

<#-- DAO method for detail table-->
<#function gselectByMasterKey tablename modelname ibatisid parentid>
<#assign content>
<@selectByMasterKey tablename="${tablename}" modelname="${modelname}" ibatisid="${ibatisid}" parentid="${parentid}"/>
</#assign>
<#return content>
</#function>

<#-- DAO method for all records-->
<#function gselectAll tablename ibatisid >
<#assign content>
<@selectAll tablename="${tablename}" ibatisid="${ibatisid}"/>
</#assign>
<#return content>
</#function>


<#macro initSelectGrammer statement >
<#assign s = "${statement}"?matches("^[sS]{1}electFor(.*){1}(List?|Object?)[Bb]?[y]?(.*)?$")>
<#list s as m>
	<#assign modelObject="${m?groups[1]?uncap_first}">
	<#assign modelType="${m?groups[1]?cap_first}">
	<#assign forType="${m?groups[2]?cap_first}">
	<#if forType="List"||forType="list">
	    <#assign returnType="List\l${modelType}\g">
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

<#macro SelectGrammer statement>
<@initSelectGrammer statement="${statement}"/>

/** ibatis SQL for ${statement} **/
<#if isSelective="selective">
<@SelectSQLBySelective statement="statement"/>
<#else>
<@SelectSQLByNonSelective statement="statement"/>
</#if>
/********************************************/

<@method.function returnClass="${returnType}" methodName="${statement}" type="${ByType}" parameter="${ByObject}">
    ${returnType} ${returnObject} = (${returnType}) getSqlMapClientTemplate().queryFor${forType}("${modelType}.${statement}"<#if ByModel!="">, ${ByModel}</#if>)  
    return ${returnObject}
</@method.function>
</#macro>

<#macro SelectSQLByNonSelective statement>
<@initSelectGrammer statement="${statement}"/>
 <!-- Remember: parameterClass needs a classpath-->
 <select id="${statement}" parameterClass="${ByType}" resultMap="ibatorgenerated_BaseResultMap">
    select ${modelObject}.*
    from ${modelType} ${modelObject}, ${ByType} ${ByObject}
    where ${modelObject}.id = ${ByObject}.id
	and ${ByObject}.id = #id#
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

<!--public method-->
<#function SelectStatement statement >
<#assign content>
<@SelectStatement statement="${statement}"/>
</#assign>
<#return content>
</#function>
