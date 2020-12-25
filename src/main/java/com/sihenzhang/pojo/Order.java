package com.sihenzhang.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private String orderId;
    private LocalDateTime createTime;
    private BigDecimal price;
    // 0 表示未发货，1 表示已发货，2 表示已签收
    private Integer status = 0;
    private Long userId;
}
