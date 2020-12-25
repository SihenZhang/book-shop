package com.sihenzhang.pojo;

import cn.hutool.core.util.StrUtil;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
public class Book {
    private Long id;
    private String name;
    private BigDecimal price;
    private String author;
    private Integer sales;
    private Integer stock;
    private String imgPath = "static/upload/default.jpg";

    public Book(Long id, String name, BigDecimal price, String author, Integer sales, Integer stock, String imgPath) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.author = author;
        this.sales = sales;
        this.stock = stock;
        if (StrUtil.isNotBlank(imgPath)) {
            this.imgPath = imgPath;
        }
    }

    public void setImgPath(String imgPath) {
        if (StrUtil.isNotBlank(imgPath)) {
            this.imgPath = imgPath;
        }
    }
}
