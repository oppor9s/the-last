<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"/>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta charset="utf-8" />
		<title>后台管理中心</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="renderer" content="webkit">
		<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width">
		<link rel="stylesheet" href="/BigHomewoke/css/demo.css" />
		<link rel="stylesheet" href="/BigHomewoke/css/style.css" />
		<link rel="stylesheet" href="/BigHomewoke/css/fen.css" />
		<script type="text/javascript" src="/BigHomewoke/js/jquery-2.2.0.min.js"></script>
	</head>

	<body>
		<div class="header">
			<div class="hea_nav">
				<a href="index.html"><img src="/BigHomewoke/img/logo.png" class="logo"/></a>
				<ul>
					<a href="index.html"><li>首页</li></a>
					<a href="product.html"><li>叮咚一下</li></a>
					<a href="blog.html"><li>BLOG</li></a>
					<a href="personal.html"><li>个人中心</li></a>
					<a href="message.html"><li>留言板</li></a>
				</ul>
			</div>
			<div class="hea_right">
				
				<p>
					<a class="login_btn">登录</a>
				</p>
				<a href="shop_car.html"><p>
						<i class="iconfont">&#xe600;</i>
						<span>0件</span>
					</p>
					</a>
					
			</div>
		</div>
		<div class="header2">
				<img src="/BigHomewoke/img/phone_meau.png" class="meau"/>
				<a href="index.html"><img src="/BigHomewoke/img/logo.png" class="logo"/></a>
				<a href="shop_car.html"><i class="iconfont">&#xe600;</i><span>1</span></a>
				<ul class="meau_box">
					<a href="index.html"><li>首页</li></a>
					<a href="product.html"><li>叮咚一下</li></a>
					<a href="blog.html"><li>BLOG</li></a>
					<a href="personal.html"><li>个人中心</li></a>
					<a href="message.html"><li>留言板</li></a>
					<p style="border-right:1px #fff solid;" class="login_btn">登录</p>
					<a href="register.html"><p>注册</p></a>
				</ul>
			</div>
			<script>
				$(function(){
					$(".meau").on("click", function(e) {
					$(".meau_box").slideToggle();
					$(document).one("click", function() {
						$(".meau_box").slideUp();
					});
					e.stopPropagation();
				});
				$(".meau").on("click", function(e) {
					e.stopPropagation();
				});
				});
			</script>
		<div class="personal">
			<p class="title">我的商店<span>订单详情</span></p>
			<ul class="per_nav">
				<li class="active">订单详情</li>
			</ul>
		
			
			<!-- 查看订单 -->
			<div class="per_box">
				<ul class="per_navul shop_carul">
					<li style="width: 130px;margin-right: 10px;">
						
					</li>
					<li style="width: 300px;text-align: left;">商品名称</li>
					<li>单价</li>
					<li style="width: 130px;margin-left: 100px;">数量</li>
					<li>样式</li>
					<li>合计</li>
					<li>付款情况</li>
				</ul>
				<c:forEach items="${list }" var="p" varStatus="sta">
					<ul class="per_listul shop_carul"  name="checkTheme" style="padding-top: 10px;box-sizing: border-box;">
					<table >
						<td name="tab">
							<li style="width: 130px;margin-right: 10px;">
							<img src="/BigHomewoke/img/order_pic5.jpg" style="vertical-align: middle;"/>
						</li>
						<li style="width: 300px;text-align: left;">${p.name }</li>
						<li style="color: #3CA5F1;"><span class="price">${p.price }</span> </li>
						<li>
							<li class="text_box">${p.count }</li>  	
						</li>
						<li>${p.type }款</li>
						<li style="color: #3CA5F1;">${p.count*p.price }</li>
						<li>已付款</li>
						</td>	
					</table>
					</ul>				
				</c:forEach>
				
			</div>
			
			
				<script>
				$(function(){
					$(".meau").on("click", function(e) {
					$(".meau_box").slideToggle();
					$(document).one("click", function() {
						$(".meau_box").slideUp();
					});
					e.stopPropagation();
				});
				$(".meau").on("click", function(e) {
					e.stopPropagation();
				});
				});
				</script>
			
		
		</div>
		<script>
			$(function(){
				$(".per_couponul li").click(function(){
					$(".per_couponul li").removeClass("active");
					$(this).addClass("active");
					$(".per_coupon_box").hide();
					$(".per_coupon_box").eq($(".per_couponul li").index(this)).fadeIn();
				});
				$(".per_nav li").click(function(){
					$(".per_nav li").removeClass("active");
					$(this).addClass("active");
					$(".per_box").hide();
					$(".per_box").eq($(".per_nav li").index(this)).fadeIn();
				});
				$(".per_nav2 li").click(function(){
					$(".per_nav2 li").removeClass("active");
					$(this).addClass("active");
					$(".per_box").hide();
					$(".per_box").eq($(".per_nav2 li").index(this)).fadeIn();
				});
			});
				</script>
		<script type="text/javascript">
			$(function(){
				$(".close").click(function(){
					$(".login_bg").fadeOut();
				});
				$(".login_btn").click(function(){
					$(".login_bg").slideDown();
					$(".meau_box").slideUp();
				});
			});
		</script>
		<script type="text/javascript">
			$(function(){
				$(".res_nav").children("li").click(function(){
					$(".res_nav").children("li").stop().removeClass("active");
					$(this).stop().addClass("active");
					$(".res_form").stop().slideUp();
					$(".res_form").eq($(".res_nav").children("li").index(this)).stop().slideDown();
				});
			});
		</script>
		<div class="footer">
			<div class="footer_con">
				<p>享有 | enjoy</p>
				<img src="/BigHomewoke/img/footer.png" />
			</div>
			<div class="footer_con2">
				<p>© 2015 dingdongyouli.com All rights reserved.</p>
				<img src="/BigHomewoke/img/footer_p2.jpg" />
			</div>
		</div>
	</body>

</html>

