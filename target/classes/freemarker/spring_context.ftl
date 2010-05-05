<#macro dao entity package>
<bean id="${entity?uncap_first}DAO" class="${package}.${entity?cap_first}DAOImpl">
	<property name="sqlMapClient" ref="sqlMapClient"/>
</bean>
</#macro>

<#function daoBean entity package>
<#assign content>
<@dao entity="${entity}" package="${package}"/>
</#assign>
<#return content>
</#function>