
<#macro function returnClass methodName type parameter>
<#assign parameter="${parameter}">
<#if returnClass = "">
public void ${methodName}(${type} ${parameter}) {
<#nested>
}	
<#else>
public ${returnClass} ${methodName}(${type} ${parameter}) {
<#nested>
}
</#if>
</#macro>

<!--public String setString(String param)-->
<#macro set methodName type parameter>
public void ${methodName}(${type} ${parameter}) {
<#nested>
}
</#macro>

<!--public String setString()-->
<#macro get returnClass methodName>
public ${returnClass} ${methodName}() {
<#nested>
}
</#macro>

<!--public String setString(String id)-->
<#macro getId returnClass methodName type>
public ${returnClass}  ${methodName}(${type} id) {
<#nested>
}
</#macro>

<!--public macro-->
<#macro tranN>
Boolean result = new Boolean(false);
TransactionTemplate transactionTemplate = new TransactionTemplate(
		transactionManager);
result = (Boolean) transactionTemplate
		.execute(new TransactionCallback() {
	public Object doInTransaction(TransactionStatus transactionStatus) {
		<#nested>
	}
});
return result;
</#macro>

<#macro ibatisformat temp>
${r"${"}${temp}${r"}"}
</#macro>