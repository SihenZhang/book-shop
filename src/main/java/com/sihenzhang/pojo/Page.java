package com.sihenzhang.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.List;

@Data
@NoArgsConstructor
public class Page<T> {
    /**
     * 分页请求地址
     */
    private String url;
    /**
     * 查询数据列表
     */
    private List<T> records = Collections.emptyList();
    /**
     * 总数
     */
    private long total = 0L;
    /**
     * 每页显示条数
     */
    private long size = 10L;
    /**
     * 当前页
     */
    private long current = 1L;

    public Page(long current, long size) {
        this(current, size, 0L);
    }

    public Page(long current, long size, long total) {
        this.size = size;
        this.total = total;
        this.setCurrent(current);
    }

    public void setCurrent(long current) {
        this.current = Math.min(current, this.getPages());
        if (this.current < 1L) {
            this.current = 1L;
        }
    }

    public boolean hasPrevious() {
        return this.current > 1;
    }

    public boolean hasNext() {
        return this.current < this.getPages();
    }

    public long getPages() {
        // 如果每页条数为 0，则无法分页，总页数为 0
        if (this.getSize() == 0L) {
            return 0L;
        }
        // 如果总数为 0，则至少有一页，内容为空
        if (this.getTotal() == 0L) {
            return 1L;
        }
        long pages = this.getTotal() / this.getSize();
        if (this.getTotal() % this.getSize() != 0L) {
            pages++;
        }
        return pages;
    }

    /**
     * 获取添加新条目后的总页数，用于添加新条目后的页面跳转
     *
     * @return 添加新条目后的总页数，若 size 为 0，则返回 1
     */
    public long getNewPages() {
        // 由于该方法是用于页面跳转的，所以默认返回值应为 1
        if (this.getSize() == 0L || this.getTotal() == 0L) {
            return 1L;
        }
        long pages = (this.getTotal() + 1) / this.getSize();
        if (this.getTotal() % this.getSize() != 0L) {
            pages++;
        }
        return pages;
    }

    @Override
    public String toString() {
        return "Page{" +
                "url='" + url + '\'' +
                ", records=" + records +
                ", total=" + total +
                ", size=" + size +
                ", current=" + current +
                ", pages=" + getPages() +
                '}';
    }
}
