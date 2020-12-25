<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
	<title>购物车 - 书城</title>
	<%@ include file="../common/head.jsp" %>
	<link rel="stylesheet" href="static/css/cart.css">
</head>
<body class="d-flex flex-column h-100">
	<c:set var="title" value="购物车" />
	<%@ include file="../common/shortcut.jsp" %>
	<%@ include file="../common/header_with_cart.jsp" %>
	<main class="container-fluid bg-light">
		<div class="container py-4">
			<c:choose>
				<c:when test="${not empty sessionScope.cart.items}">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>商品名称</th>
								<th>单价</th>
								<th>数量</th>
								<th>小计</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="entry" items="${sessionScope.cart.items}">
								<tr>
									<td>${entry.value.name}</td>
									<td>￥${entry.value.price}</td>
									<td class="input-group input-group-sm" data-id="${entry.value.id}">
										<div class="input-group-prepend">
											<button type="button" class="btn btn-outline-secondary btn-sub">-</button>
										</div>
										<input type="number" name="count" class="form-control input-count" min="1" step="1" value="${entry.value.count}">
										<div class="input-group-append">
											<button type="button" class="btn btn-outline-secondary btn-inc">+</button>
										</div>
                        	        </td>
									<td class="font-weight-bold">￥${entry.value.totalPrice}</td>
									<td><button type="button" class="btn btn-link p-0" data-toggle="modal" data-target="#deleteModal" data-item-id="${entry.value.id}">删除</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="d-flex justify-content-between align-items-center">
						<div>
							<span>共 <span id="totalCount" class="text-important">${sessionScope.cart.totalCount}</span> 件商品</span>
							<button type="button" class="btn btn-sm btn-link font-weight-bold" data-toggle="modal" data-target="#clearModal">清空购物车</button>
						</div>
						<div>
							<span class="align-middle">总价： <span id="totalPrice" class="text-important">${sessionScope.cart.totalPrice}</span> 元</span>
							<span class="d-inline-block" data-toggle="popover" data-placement="top" data-trigger="hover" data-content="不含运费及送装服务费">
								<svg class="anticon anticon-bulb-outlined text-warning"><use xlink:href="static/ant-design-icons.svg#anticon-bulb-outlined"></use></svg>
							</span>
							<a class="btn btn-danger ml-2" href="client/orderServlet?action=create">去结算</a>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div id="empty-message">
						<div id="empty-message-img">
							<svg class="anticon anticon-shopping-cart-outlined"><use xlink:href="static/ant-design-icons.svg#anticon-shopping-cart-outlined"></use></svg>
						</div>
						<div>
							<p class="mb-1">购物车空空的哦~，去看看心仪的商品吧~</p>
							<a class="text-red" href="">去购物&gt;</a>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</main>
	<%@ include file="../common/footer.jsp" %>
	<div class="modal fade" id="updateCountModal" tabindex="-1" aria-labelledby="updateCountModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header border-bottom-0">
					<h5 class="modal-title" id="updateCountModalLabel">提示</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body py-1">
					<svg class="anticon anticon-exclamation-circle-filled text-warning"><use xlink:href="static/ant-design-icons.svg#anticon-exclamation-circle-filled"></use></svg>
					<p>商品数量必须大于0</p>
				</div>
				<div class="modal-footer border-top-0">
					<button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">知道了</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header border-bottom-0">
					<h5 class="modal-title" id="deleteModalLabel">提示</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body py-1">
					<svg class="anticon anticon-exclamation-circle-filled text-warning"><use xlink:href="static/ant-design-icons.svg#anticon-exclamation-circle-filled"></use></svg>
					<p>是否删除购物车中的该商品？</p>
				</div>
				<div class="modal-footer border-top-0">
					<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">取消</button>
					<a id="deleteBtn" class="btn btn-primary btn-sm" href="javascript:void(0);">确定</a>
				</div>
			</div>
		</div>
	</div>
    <div class="modal fade" id="clearModal" tabindex="-1" aria-labelledby="clearModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-bottom-0">
                    <h5 class="modal-title" id="clearModalLabel">提示</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body py-1">
                    <svg class="anticon anticon-exclamation-circle-filled text-warning"><use xlink:href="static/ant-design-icons.svg#anticon-exclamation-circle-filled"></use></svg>
                    <p>是否清空购物车中的所有商品？</p>
                </div>
                <div class="modal-footer border-top-0">
                    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">取消</button>
                    <a id="clearBtn" class="btn btn-primary btn-sm" href="cartServlet?action=clear">确定</a>
                </div>
            </div>
        </div>
    </div>
	<script src="static/js/cart.js"></script>
</body>
</html>