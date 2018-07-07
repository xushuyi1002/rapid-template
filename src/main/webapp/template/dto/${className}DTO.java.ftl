<#assign className = table.className>     
<#assign classNameLower = className?uncap_first>
package ${basepackage}.dto;  

import lombok.*;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ${className}DTO {  
      
    <#list table.columns as column>
    /**
     * ${column.remarks}
     */
    private ${column.simpleJavaType} ${column.columnNameLower};  
    </#list>  
 
}