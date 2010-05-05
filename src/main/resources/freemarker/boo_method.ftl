<#import "method.ftl" as method>
<#import "spring_context.ftl" as spring_context>

<#macro initM masterClass >
<#assign class="${masterClass}">
<#assign obj="${masterClass?uncap_first}">
<#assign list="${masterClass?uncap_first}List">
<#assign dao="${masterClass?uncap_first}DAO">
<#assign obj_class="${masterClass?cap_first}">
<#assign list_class="${masterClass?cap_first}List">
<#assign dao_class="${masterClass?cap_first}DAO">
</#macro>

<#macro initD detailClass >
<#assign dclass="${detailClass}">
<#assign dobj="${detailClass?uncap_first}">
<#assign dlist="${detailClass?uncap_first}List">
<#assign ddao="${detailClass?uncap_first}DAO">
<#assign dobj_class="${detailClass?cap_first}">
<#assign dlist_class="${detailClass?cap_first}List">
<#assign ddao_class="${detailClass?cap_first}DAO">
</#macro>


<#--**************-->
<#--SimpleMasterBo-->
<#--**************-->

<#macro selectAllMaster masterClass daoMethod>
<@initM masterClass="${masterClass}"/>
/**
 * @Master ${obj_class} update
 * @return
 */
<@method.get returnClass="${list_class}" methodName="findAll${list_class}" >
	List list = ${dao}.<#if daoMethod="">selectAll()<#else>${daoMethod}(${obj})</#if>;
	${list_class} ${list} = new ${list_class}();
	${list}.addAll(list);
	return ${list};
</@method.get>
</#macro>

<#macro updateMaster masterClass daoMethod>
<@initM masterClass="${masterClass}"/>
/**
 * @Master ${obj_class} update
 * @param ${obj}
 * @return
 */
<@method.function returnClass="Boolean" methodName="update${obj_class}" type="${obj_class}" parameter="${obj}">	
	int updateResult =  ${dao}.<#if daoMethod="">updateByPrimaryKey(${obj})<#else>${daoMethod}(${obj})</#if>;
	if (updateResult > 0) {
		return Boolean.TRUE;
	}
	return Boolean.FALSE;
</@method.function>
</#macro>

<#macro deleteMaster masterClass detailClass>
<@initM masterClass="${masterClass}"/>
<@initD detailClass="${detailClass}"/>
/**
 * @Master ${obj_class} delete
 * @Detail ${dobj_class} delete
 * @param id
 * @return
 */
<@method.function returnClass="Boolean" methodName="delete${obj_class}" type="final String" parameter="xuid">	
	<@method.tranN>
		${ddao}.deleteByMasterKey(xuid);
		int delMResult = ${dao}.deleteByPrimaryKey(xuid);
		if (delMResult > 0) {
			return Boolean.TRUE;
		}else{
			transactionStatus.setRollbackOnly();
		}
		return Boolean.FALSE;
	</@method.tranN>
</@method.function>
</#macro>

<#--**************-->
<#--SimpleDetailBo-->
<#--**************-->

<#macro findDetail detailClass daoMethod>
<@initD detailClass="${detailClass}"/>
/**
 * @Detail ${dobj_class} select
 * @param parid
 * @return
 */
<@method.function returnClass="${dlist_class}" methodName="find${dlist_class}" type="String" parameter="xuid">		
	List list = ${ddao}.<#if daoMethod="">selectByMasterKey(xuid)<#else>${daoMethod}(parid)</#if>;
	${dlist_class} ${dlist} = new ${dlist_class}();
	${dlist}.addAll(list);
	return ${dlist};
</@method.function>
</#macro>

<#macro updateDetail detailClass daoMethod>
<@initD detailClass="${detailClass}"/>
/**
 * @Detail ${dobj_class} update
 * @param ${dobj}
 * @return
 */
<@method.function returnClass="Boolean" methodName="update${dobj_class}" type="${dobj_class}" parameter="${dobj}">	
	int updateResult =  ${ddao}.<#if daoMethod="">updateByPrimaryKey(${dobj})<#else>${daoMethod}(${dobj})</#if>;
	if (updateResult > 0) {
		return Boolean.TRUE;
	}
	return Boolean.FALSE;
</@method.function>
</#macro>

<#macro deleteDetail detailClass>
<@initD detailClass="${detailClass}"/>
/**
 * @Detail ${dobj_class} delete
 * @param ${dobj}
 * @return
 */
<@method.function returnClass="Boolean" methodName="delete${dobj_class}" type="String" parameter="fxuid">	
	int delDResult =  ${ddao}.deleteByPrimaryKey(fxuid);
	if (delDResult > 0) {
		return Boolean.TRUE;
	}
	return Boolean.FALSE;
</@method.function>
</#macro>

<#--********-->
<#--SimpleBo-->
<#--********-->

<#macro insertObj masterClass>
<@initM masterClass="${masterClass}"/>
/**
 * @Simple ${obj_class} insert
 * @param ${obj}
 * @return
 */
<@method.set methodName="insert${obj_class}" type="${obj_class}" parameter="${obj}" >
	${dao}.insert(${obj});	
</@method.set>
</#macro>

<#macro selectAllObj masterClass daoMethod>
<@initM masterClass="${masterClass}"/>
/**
 * @Simple ${obj_class} select
 * @return 
 */
<@method.get returnClass="${list_class}" methodName="findAll${list_class}" >
	List list = ${dao}.<#if daoMethod="">selectAll()<#else>${daoMethod}(${obj})</#if>;
	${list_class} ${list} = new ${list_class}();
	${list}.addAll(list);
	return ${list};
</@method.get>
</#macro>

<#macro selectByID masterClass daoMethod>
<@initM masterClass="${masterClass}"/>
/**
 * @Simple ${obj_class} select
 * @return 
 */
<@method.function returnClass="${obj_class}" methodName="find${obj_class}ById" type="String" parameter="xuid">	
	${obj_class} ${obj} = ${dao}.selectByPrimaryKey(xuid);
	return ${obj};
</@method.function>
</#macro>

<#macro updateObj masterClass daoMethod>
<@initM masterClass="${masterClass}"/>
/**
 * @Simple ${obj_class} update
 * @param ${obj}
 * @return
 */
<@method.function returnClass="Boolean" methodName="update${obj_class}" type="${obj_class}" parameter="${obj}">	
	int updateResult =  ${dao}.<#if daoMethod="">updateByPrimaryKey(${obj})<#else>${daoMethod}(${obj})</#if>;
	if (updateResult > 0) {
		return Boolean.TRUE;
	}
	return Boolean.FALSE;
</@method.function>
</#macro>

<#macro deleteObj masterClass>
<@initM masterClass="${masterClass}"/>
/**
 * @Simple ${obj_class} delete
 * @param ${obj}
 * @return
 */
<@method.function returnClass="Boolean" methodName="delete${obj_class}" type="String" parameter="xuid">	
	int delDResult =  ${dao}.deleteByPrimaryKey(xuid);
	if (delDResult > 0) {
		return Boolean.TRUE;
	}
	return Boolean.FALSE;
</@method.function>
</#macro>

<#macro init_one2many statement>
	<#assign s = "${statement}"?matches("^[oO]{1}ne(.*){1}(2Many?|2many?){1}(.*){1}$")>
	<#list s as m>
		<#assign master="${m?groups[1]}">
		<#assign detail="${m?groups[3]}">
	</#list>
</#macro>

<#macro init_one statement>
	<#assign s = "${statement}"?matches("^[oO]{1}ne(.*){1}$")>
	<#list s as m>
		<#assign master="${m?groups[1]}">
	</#list>
</#macro>

<#macro oneBlock statement>
<@init_one statement="${statement}"/>
/** Single Bo:${master} start**/
<@selectAllObj masterClass="${master}" daoMethod=""/>

<@selectByID masterClass="${master}" daoMethod=""/>

<@insertObj masterClass="${master}"/>

<@updateObj masterClass="${master}" daoMethod=""/>

<@deleteObj masterClass="${master}"/>
/** Single Bo:${master} end **/
</#macro>

<#macro one2manyBlock statement>
<@init_one2many statement="${statement}"/>
/** one2many MasterBo:${master} DetailBo:${detail} start**/
<@selectAllMaster masterClass="${master}" daoMethod=""/>

<@updateMaster masterClass="${master}" daoMethod=""/>

<@deleteMaster masterClass="${master}" detailClass="${detail}"/>

<@findDetail detailClass="${detail}" daoMethod=""/>

<@updateDetail detailClass="${detail}" daoMethod=""/>

<@deleteDetail detailClass="${detail}"/>
/** one2many MasterBo:${master} DetailBo:${detail} end**/
</#macro>


<#--V1 Main method: one-->
<#function one master>
<#assign content>
/** Single Bo:${master} start**/

<@selectAllObj masterClass="${master}" daoMethod=""/>

<@selectByID masterClass="${master}" daoMethod=""/>

<@insertObj masterClass="${master}"/>

<@updateObj masterClass="${master}" daoMethod=""/>

<@deleteObj masterClass="${master}"/>

/** Single Bo:${master} end **/
</#assign>
<#return content>
</#function>

<#--V1 Main method: one 2 many-->
<#function one2many master detail >
<#assign content>
/** one2many MasterBo:${master} DetailBo:${detail} start**/

<@selectAllMaster masterClass="${master}" daoMethod=""/>

<@updateMaster masterClass="${master}" daoMethod=""/>

<@deleteMaster masterClass="${master}" detailClass="${detail}"/>

<@findDetail detailClass="${detail}" daoMethod=""/>

<@updateDetail detailClass="${detail}" daoMethod=""/>

<@deleteDetail detailClass="${detail}"/>

/** one2many MasterBo:${master} DetailBo:${detail} end**/
</#assign>
<#return content>
</#function>

<#-- V2 Main method: one-->
<#function oneStatement statement>
<#assign content>
<@boo_method.oneBlock statement="${statement}"/>
</#assign>
<#return content>
</#function>


<#-- V2 Main method: one 2 many-->
<#function one2manyStatement statement>
<#assign content>
<@boo_method.one2manyBlock statement="${statement}"/>
</#assign>
<#return content>
</#function>