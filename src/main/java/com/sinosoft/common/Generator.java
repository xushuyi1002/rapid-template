package com.sinosoft.common;

import cn.org.rapid_framework.generator.GeneratorFacade;

import java.io.IOException;
import java.util.Properties;

/**
 * @author xushuyi
 *         <p>
 *         根据数据库表，一键代码生成
 */
public class Generator {
    public static void main(String[] args) throws Exception {
        Properties prop = new Properties();
        GeneratorFacade g = new GeneratorFacade();
        g.getGenerator().setTemplateRootDir("src/main/webapp/template");
        try {
            prop.load(Generator.class.getClassLoader().getResourceAsStream("talbenames.properties"));
            //get the property value and print it out
            System.out.println("数据库表：" + prop.getProperty("tablenames"));
            String s = prop.getProperty("tablenames");
            String[] ss = s.split(",");
            for (int i = 0; i < ss.length; i++) {
                System.out.print("开始执行数据库表：" + ss[i] + "的类文件生成操作...");
                g.deleteByTable(ss[i]); // 自行修改生成的表
                g.generateByTable(ss[i]);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}