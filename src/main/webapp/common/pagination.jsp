<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav id="pagination" aria-label="Pagination">
    <span>共 ${requestScope.page.total} 条</span>
    <ul class="pagination mx-2 my-0">
        <%-- 如果当前页还有上一页，输出上一页按钮 --%>
        <c:if test="${requestScope.page.hasPrevious()}">
            <li class="page-item">
                <a class="page-link" href="${requestScope.page.url}&current=${requestScope.page.current - 1}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
        </c:if>
        <%-- 满足情况 2 且不满足小情况 1（此时分页条中不存在第 1 页的按钮），输出第 1 页按钮 --%>
        <c:if test="${requestScope.page.pages > 5 && requestScope.page.current > 3}">
            <li class="page-item">
                <a class="page-link" href="${requestScope.page.url}&current=1">1</a>
            </li>
        </c:if>
        <%-- 总页数大于 6（第 1 页或最后一页按钮不会与分页条相邻）且当前页距离第 1 页超过 3 页，输出省略号 --%>
        <c:if test="${requestScope.page.pages > 6 && requestScope.page.current - 1 > 3}">
            <li class="page-item disabled">
                <span class="page-link">...</span>
            </li>
        </c:if>
        <c:choose>
            <%-- 情况 1：如果总页数小于等于 5，输出的页码范围为 1 ~ 总页数 --%>
            <c:when test="${requestScope.page.pages <= 5}">
                <c:set var="begin" value="1" />
                <c:set var="end" value="${requestScope.page.pages}" />
            </c:when>
            <%-- 情况 2：如果总页数大于 5 --%>
            <c:otherwise>
                <c:choose>
                    <%-- 小情况 1：当前页为前三页，输出的页码范围为 1 ~ 5 --%>
                    <c:when test="${requestScope.page.current <= 3}">
                        <c:set var="begin" value="1" />
                        <c:set var="end" value="5" />
                    </c:when>
                    <%-- 小情况 2：当前页为后三页，输出的页码范围为 (总页数 - 4) ~ 总页数 --%>
                    <c:when test="${requestScope.page.current > requestScope.page.pages - 3}">
                        <c:set var="begin" value="${requestScope.page.pages - 4}" />
                        <c:set var="end" value="${requestScope.page.pages}" />
                    </c:when>
                    <%-- 小情况 3：当前页既不为前三页又不为后三页，输出的页码范围为 (当前页 - 2) ~ (当前页 + 2) --%>
                    <c:otherwise>
                        <c:set var="begin" value="${requestScope.page.current - 2}" />
                        <c:set var="end" value="${requestScope.page.current + 2}" />
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
        <%-- 根据确定的页码范围输出分页条 --%>
        <c:forEach var="i" begin="${begin}" end="${end}">
            <c:choose>
                <c:when test="${i == requestScope.page.current}">
                    <li class="page-item active" aria-current="page">
                        <span class="page-link">${i}<span class="sr-only">(current)</span></span>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="${requestScope.page.url}&current=${i}">${i}</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <%-- 总页数大于 6（第 1 页或最后一页按钮不会与分页条相邻）且当前页距离最后一页超过 3 页，输出省略号 --%>
        <c:if test="${requestScope.page.pages > 6 && requestScope.page.pages - requestScope.page.current > 3}">
            <li class="page-item disabled">
                <span class="page-link">...</span>
            </li>
        </c:if>
        <%-- 满足情况 2 且不满足小情况 2（此时分页条中不存在最后一页的按钮），输出最后一页按钮 --%>
        <c:if test="${requestScope.page.pages > 5 && requestScope.page.current <= requestScope.page.pages - 3}">
            <li class="page-item">
                <a class="page-link" href="${requestScope.page.url}&current=${requestScope.page.pages}">${requestScope.page.pages}</a>
            </li>
        </c:if>
        <%-- 如果当前页还有下一页，输出下一页按钮 --%>
        <c:if test="${requestScope.page.hasNext()}">
            <li class="page-item">
                <a class="page-link" href="${requestScope.page.url}&current=${requestScope.page.current + 1}" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </c:if>
    </ul>
    <span>跳至<label for="inputPageNum" class="sr-only">跳转页码</label><input type="number" id="inputPageNum" name="pageNum" class="form-control d-inline-block mx-1" min="1" max="${requestScope.page.pages}">页</span>
</nav>
<script src="static/js/pagination.js"></script>
