package com.sihenzhang.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;

@Data
@NoArgsConstructor
public class Cart {
    private final Map<Long, CartItem> items = new LinkedHashMap<>();

    public Integer getTotalCount() {
        return items.values().stream().mapToInt(CartItem::getCount).sum();
    }

    public BigDecimal getTotalPrice() {
        return items.values().stream().map(CartItem::getTotalPrice).reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public void addItem(CartItem cartItem) {
        items.compute(cartItem.getId(), (k, v) -> {
            if (v == null) {
                v = cartItem;
            } else {
                v.setCount(v.getCount() + 1);
            }
            return v;
        });
    }

    public void deleteItem(Long id) {
        items.remove(id);
    }

    public void clear() {
        items.clear();
    }

    public void updateCount(Long id, Integer count) {
        items.computeIfPresent(id, (k, v) -> {
            v.setCount(count);
            return v;
        });
    }

    @Override
    public String toString() {
        return "Cart{" +
                "totalCount=" + getTotalCount() +
                ", totalPrice=" + getTotalPrice() +
                ", items=" + items +
                '}';
    }
}
