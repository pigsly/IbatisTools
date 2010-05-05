<#import "method.ftl" as method>
<#import "spring_context.ftl" as spring_context>

<#macro initM masterClass >
<#assign class="${masterClass}">
<#assign obj="${masterClass?uncap_first}">
<#assign list="${masterClass?uncap_first}List">
<#assign dao="${masterClass?uncap_first}DAO">
<#assign obj_class="${masterClass?cap_first}">
<#assign list_class="List\l${masterClass?cap_first}\g">
<#assign dao_class="${masterClass?cap_first}DAO">
</#macro>

<#macro initD detailClass >
<#assign dclass="${detailClass}">
<#assign dobj="${detailClass?uncap_first}">
<#assign dlist="${detailClass?uncap_first}List">
<#assign ddao="${detailClass?uncap_first}DAO">
<#assign dobj_class="${detailClass?cap_first}">
<#assign dlist_class="List\l${detailClass?cap_first}\g">
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
<@method.get returnClass="${list_class}" methodName="findAll${list?cap_first}" >
	List list = ${dao}.<#if daoMethod="">selectAll()<#else>${daoMethod}(${obj})</#if>;
	return list;
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
<@method.function returnClass="Boolean" methodName="delete${obj_class}" type="${obj_class}" parameter="obj">	
	<@method.tranN>
		${ddao}.deleteByMasterKey(obj);
		int delMResult = ${dao}.deleteByPrimaryKey(obj);
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
<@method.function returnClass="${dlist_class}" methodName="find${dlist?cap_first}" type="${dobj_class}" parameter="obj">		
	List list = ${ddao}.<#if daoMethod="">selectByMasterKey(parid)<#else>${daoMethod}(obj)</#if>;
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
<@method.function returnClass="Boolean" methodName="delete${dobj_class}" type="${dobj_class}" parameter="obj">	
	int delDResult =  ${ddao}.deleteByPrimaryKey(obj);
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
<@method.get returnClass="${list_class}" methodName="findAll${list?cap_first}" >
	List list = ${dao}.<#if daoMethod="">selectAll()<#else>${daoMethod}(${obj})</#if>;
	return ${list};
</@method.get>
</#macro>

<#macro selectByID masterClass daoMethod>
<@initM masterClass="${masterClass}"/>
/**
 * @Simple ${obj_class} select
 * @return 
 */
<@method.function returnClass="${obj_class}" methodName="find${obj_class}ById" type="${obj_class}" parameter="obj">	
	${obj_class} ${obj} = ${dao}.selectByPrimaryKey(obj);
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
<@method.function returnClass="Boolean" methodName="delete${obj_class}" type="${obj_class}" parameter="obj">	
	int delDResult =  ${dao}.deleteByPrimaryKey(obj);
	if (delDResult > 0) {
		return Boolean.TRUE;
	}
	return Boolean.FALSE;
</@method.function>
</#macro>


<#-- Main method: one 2 many-->
<#function one2many master detail >
<#assign content>
/** one2many MasterBo:${master} DetailBo:${detail} start**/

<@bo_method.selectAllMaster masterClass="${master}" daoMethod=""/>

<@bo_method.updateMaster masterClass="${master}" daoMethod=""/>

<@bo_method.deleteMaster masterClass="${master}" detailClass="${detail}"/>

<@bo_method.findDetail detailClass="${detail}" daoMethod=""/>

<@bo_method.updateDetail detailClass="${detail}" daoMethod=""/>

<@bo_method.deleteDetail detailClass="${detail}"/>

/** one2many MasterBo:${master} DetailBo:${detail} end**/
</#assign>
<#return content>
</#function>

<#-- Main method: one-->
<#function one master>
<#assign content>
/** Single Bo:${master} start**/

<@bo_method.selectAllObj masterClass="${master}" daoMethod=""/>

<@bo_method.selectByID masterClass="${master}" daoMethod=""/>

<@bo_method.insertObj masterClass="${master}"/>

<@bo_method.updateObj masterClass="${master}" daoMethod=""/>

<@bo_method.deleteObj masterClass="${master}"/>

/** Single Bo:${master} end **/
</#assign>
<#return content>
</#function>
