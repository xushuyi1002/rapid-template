<#assign className = table.className>     
<#assign classNameLower = className?uncap_first>
package ${basepackage}.client;

import ${basepackage}.dto.${className}DTO;
import ${basepackage}.dto.ResponseInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;


@FeignClient(name = "provider-${classNameLower}", fallback = ${className}FeignClient.${className}HystrixFallback.class)
public interface ${className}FeignClient {

    @GetMapping("/")
    ResponseInfo<${className}DTO> findAll();

    @GetMapping("/{id}")
    ResponseInfo<${className}DTO> findById(@PathVariable Long id);

    @PostMapping(value = "/")
    ResponseInfo<${className}DTO> add(@RequestBody ${className}DTO dto);

    @PutMapping(value = "/{id}")
    ResponseInfo<${className}DTO> put(@PathVariable("id") Long id, @RequestBody ${className}DTO dto);

    @DeleteMapping(value = "/{id}")
    ResponseInfo<${className}DTO> delete(@PathVariable("id") Long id);

    @GetMapping("/instance-info")
    ResponseInfo<ServiceInstance> showInfo();

    @GetMapping("/page")
    ResponseInfo<${className}DTO> pageInfo(Pageable pageable);

    @Component
    class ${className}HystrixFallback implements ${className}FeignClient {
        private static final Logger LOGGER = LoggerFactory.getLogger(${className}HystrixFallback.class);

        @Override
        public ResponseInfo<${className}DTO> findById(Long id) {
            ${className}HystrixFallback.LOGGER.info("${className} client findById 异常发生");
            return defalutEntityErrorInfo(${className}DTO.class);
        }

        @Override
        public ${basepackage}.dto.ResponseInfo<${className}DTO> add(@RequestBody ${className}DTO dto) {
            ${className}HystrixFallback.LOGGER.info("${className} client add 异常发生");
            return defalutEntityErrorInfo(${className}DTO.class);
        }

        @Override
        public ${basepackage}.dto.ResponseInfo<${className}DTO> put(@PathVariable("id") Long id, @RequestBody ${className}DTO dto) {
            ${className}HystrixFallback.LOGGER.info("${className} client put 异常发生");
            return defalutEntityErrorInfo(${className}DTO.class);
        }

        @Override
        public ${basepackage}.dto.ResponseInfo<${className}DTO> delete(@PathVariable("id") Long id) {
            ${className}HystrixFallback.LOGGER.info("${className} client delete 异常发生");
            return defalutEntityErrorInfo(${className}DTO.class);
        }

        @Override
        public ResponseInfo<ServiceInstance> showInfo() {
            ${className}HystrixFallback.LOGGER.info("${className} client showInfo 异常发生");
            return defalutEntityErrorInfo(ServiceInstance.class);
        }

        private <T> ResponseInfo<T> defalutEntityErrorInfo(Class<T> ${classNameLower}DTOClass) {
            return new ResponseInfo<>(false, "熔断器中断", createEmptyInstance(${classNameLower}DTOClass));
        }

        private <T> T createEmptyInstance(Class<T> ${classNameLower}DTOClass) {
            T t= null;
            try {
                 t = ${classNameLower}DTOClass.newInstance();
            } catch (InstantiationException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
            return t;
        }

        @Override
        public ResponseInfo<${className}DTO> pageInfo(Pageable pageable) {
            ${className}HystrixFallback.LOGGER.info("${className} client pageInfo 异常发生");
            return defalutErrorInfos();
        }

        @Override
        public ResponseInfo<${className}DTO> findAll() {
            ${className}HystrixFallback.LOGGER.info("${className} client findAll 异常发生");
            return defalutErrorInfos();
        }

        private ResponseInfo<${className}DTO> defalutErrorInfos() {
            return new ResponseInfo<${className}DTO>(false, "熔断器中断");
        }

    }
}
