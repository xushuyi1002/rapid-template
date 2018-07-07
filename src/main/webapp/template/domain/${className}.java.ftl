<#assign className = table.className>     
<#assign classNameLower = className?uncap_first>
package ${basepackage}.entity;  

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.*;
import java.util.Date;

@Data
@Entity
public class ${className} {  
      
    <#list table.columns as column>  
    /**
	 * ${column.remarks}
     */ 
     <#if column.columnNameLower="id">
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	</#if>
    @Column
    private ${column.simpleJavaType} ${column.columnNameLower};  
    </#list>  
    
    public ${className}() {
	<#list table.columns as column>  
		<#if column.isNumberColumn>
		this.${column.columnNameLower} = 0L;
		<#elseif column.isStringColumn>
		this.${column.columnNameLower} = "";
		<#elseif column.isDateTimeColumn>
		this.${column.columnNameLower} = new Date();
		<#else>
		this.${column.columnNameLower} = "";
		</#if>
    </#list>  
    }
 
}