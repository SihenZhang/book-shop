package com.sihenzhang.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartItem {
    private Long id;
    private String name;
    private Integer count;
    private BigDecimal price;

    public BigDecimal getTotalPrice() {
        return this.price.multiply(BigDecimal.valueOf(count));
    }
}
