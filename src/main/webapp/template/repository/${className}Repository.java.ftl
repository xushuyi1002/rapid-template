<#assign className = table.className>     
<#assign classNameLower = className?uncap_first>
package ${basepackage}.repository;  

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import ${basepackage}.domain.${className};

@Repository
public interface ${className}Repository extends PagingAndSortingRepository<${className},Long>{  
      
}