<#import "boo_method.ftl" as boo_method>
<#import "daoo_method.ftl" as daoo_method>


<#macro ParseStatement statement>
<#if "${statement}"?matches("^[oO]{1}ne(.*){1}(2Many?|2many?)(.*){1}$")>
	<@boo_method.one2manyBlock statement="${statement}"/>
<#elseif "${statement}"?matches("^[oO]{1}ne(.*){1}$")>
	<@boo_method.oneBlock statement="${statement}"/>
<#elseif "${statement}"?matches("^[sS]{1}elect[Ff]{1}or(.*){1}(List?|Object?)[Bb]?[y]?(.*)?$")>
	<@daoo_method.SelectStatement statement="${statement}"/>
<#else>
	The command ${statement} is not following grammer. 
</#if>
</#macro>

<#function IParseStatement statement >
<#assign content>
<@ParseStatement statement="${statement}"/>
</#assign>
<#return content>
</#function>
