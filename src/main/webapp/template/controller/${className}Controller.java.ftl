<#assign className = table.className>
<#assign classNameLower = className?uncap_first>
package ${basepackage}.controller;


import com.google.common.collect.Lists;
import ${basepackage}.common.EntityAndDTO;
import ${basepackage}.domain.${className};
import ${basepackage}.dto.${className}DTO;
import ${basepackage}.dto.ResponseInfo;
import ${basepackage}.repository.${className}Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.swagger2.annotations.EnableSwagger2;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@RestController
@RequestMapping(path="/api/${classNameLower}")
@EnableSwagger2
public class ${className}Controller {

	private static final Logger LOGGER = LoggerFactory.getLogger(${className}Controller.class);

	@Autowired
    private DiscoveryClient discoveryClient;

    @Autowired
	private ${className}Repository ${classNameLower}Repository;

    @GetMapping("/")
    public ResponseInfo<${className}DTO> findAll(){
        return new ResponseInfo<>(true,"success", EntityAndDTO.convert(Lists.newArrayList(this.${classNameLower}Repository.findAll()),${className}DTO.class));
    }

    @GetMapping("/{id}")
    public ResponseInfo<${className}DTO> findById(@PathVariable Long id) {
        ${className} br = this.${classNameLower}Repository.findOne(id);
        if(br==null){
            return new ResponseInfo<>(false,"不存在id=" +id+ "的${className}",400);
        }
        return  new ResponseInfo<>(true,"success", EntityAndDTO.convert(br, ${className}DTO.class));
    }

    @PostMapping(value = "/")
    public ResponseInfo<${className}DTO> add(@RequestBody ${className}DTO dto) {
        ${className} br = this.${classNameLower}Repository.save(EntityAndDTO.convert(dto,${className}.class));
        return new ResponseInfo<>(true,"success", EntityAndDTO.convert(br, ${className}DTO.class));
    }

    @PutMapping(value = "/{id}")
    public ResponseInfo<${className}DTO> put(@PathVariable("id") Long id, @RequestBody ${className}DTO dto) {
        ${className} br = this.${classNameLower}Repository.findOne(id);
        if(br==null){
            return new ResponseInfo<>(false,"不存在id=" +id+ "的${className}",400);
        }
        ${className} br1 = this.${classNameLower}Repository.save(EntityAndDTO.convert(dto,${className}.class));
        return (new ResponseInfo<>(true,"success", EntityAndDTO.convert(br1, ${className}DTO.class)));
    }

    @DeleteMapping(value = "/{id}")
    public ResponseInfo<${className}DTO> delete(@PathVariable("id") Long id) {
        ${className} br = this.${classNameLower}Repository.findOne(id);
        if(br==null){
            return new ResponseInfo<>(false,"不存在id=" +id+ "的${className}",400);
        }else{
            this.${classNameLower}Repository.delete(id);
        }
        return new ResponseInfo<>(true,"success", EntityAndDTO.convert(br, ${className}DTO.class));
    }


    @GetMapping("/page")
    public ResponseInfo<${className}DTO> pageInfo(Pageable pageable) {
        return new ResponseInfo<${className}DTO>(true,"success", EntityAndDTO.convert(this.${classNameLower}Repository.findAll(pageable).getContent(),${className}DTO.class));
    }

     @GetMapping("/instance-info")
     public ResponseInfo<ServiceInstance> showInfo() {
        ServiceInstance instance = this.discoveryClient.getLocalServiceInstance();
        return new ResponseInfo<ServiceInstance>(true,"success", instance);
      }
}
