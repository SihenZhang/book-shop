<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="container d-flex justify-content-between align-items-center">
    <div id="logo" class="my-2 d-flex align-items-end">
        <h1 class="my-0">
            <a href="" title="书城">书城</a>
        </h1>
        <h2 class="ml-3 my-0 text-muted">${title}</h2>
    </div>
    <div id="shopping-cart" class="small shadow-sm">
        <a class="stretched-link" href="cart/cart.jsp">我的购物车</a>
        <svg class="anticon anticon-shopping-cart-outlined text-danger"><use xlink:href="static/ant-design-icons.svg#anticon-shopping-cart-outlined"></use></svg>
        <span id="cartTotalCount" class="badge badge-pill badge-danger">${empty sessionScope.cart ? 0 : sessionScope.cart.totalCount}</span>
    </div>
</header>
