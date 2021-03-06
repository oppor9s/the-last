<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"/>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
	<head>
		<meta charset="utf-8" />
		<title>叮咚有礼--购物车</title>
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
					<a href="${ctx}/index2.jsp"><li>首页</li></a>

				</ul>
			</div>

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
		<div class="personal" >
			<p class="title" style="margin-bottom: 30px;">我的订单</p>
			<div class="per_box" >
			<form action="${ctx }/order/bigdelete" method="post">	
				<ul class="per_navul shop_carul">
					<li style="width: 130px;margin-right: 10px;">
						<input type="checkbox" style="margin-right: 20px;" id="allCheckBox"  value="" onclick="selectAll()"/>全选
					</li>
					<li style="width: 450px;text-align: left;">商品名称</li>
					<li>单价</li>
					<li>数量</li>
					<li>样式</li>
					<li>合计</li>
				</ul>
		<c:forEach items="${list }" var="p" varStatus="sta">
				<ul class="per_listul shop_carul"  name="checkTheme" style="padding-top: 10px;box-sizing: border-box;">
				<table >
					<td name="tab">
					<li style="width: 130px;margin-right: 10px;">
						<input type="checkbox" name="tempString"  style="margin-right: 10px;margin-left: 18px;" value="${p.id }" onclick="selectSingle()"/>
						<img src="/BigHomewoke/img/order_pic5.jpg" style="vertical-align: middle;"/>
					</li>
					<li style="width: 450px;text-align: left;">${p.name }</li>
					<li style="color: #3CA5F1;"><span class="price">${p.price }</span> </li>
					<li>
						<a href="${ctx }/order/jianchangecount?id=${p.id}"><input  name="" type="button" value="-" style="width:20px;height:20px;"/></a> 
						<input class="text_box" name="count" type="text" value="${p.count }" style="width:30px;height:20px;"/> 
						<a href="${ctx }/order/jiachangecount?id=${p.id}"><input  name="" type="button" value="+" style="width:20px;height:20px;"/></a> 	
					</li>
					<li>--</li>
					<li style="color: #3CA5F1;"><label id="total${sta.index }"></label></li>
					<li><a href="${ctx }/order/delete?id=${p.id}">删除</a></li>
					</td>	
				</table>
				</ul>
				
		</c:forEach>
				<ul class="per_navul shop_carul">
					<li style="width: 130px;margin-right: 10px;">
						<p style="margin-right: 30px;margin-top:5px;"/>
						<input type="submit" style="border:0;background:#00FFFF ;width:40px; height:30px; " value="删除" />
						</p>
					</li>
				</ul>
			</div>
		</div>
		</form>
		<div style="align:right"> <a href="${ctx}/order/changeorder1">完成</a></div>
		<script type="text/javascript">
		
		//计算价格
		$(function(){ 
			$(".add").click(function(){ 
			
			var t=$(this).parent().find('input[class*=text_box]'); 
			t.val(parseInt(t.val())+1) 
			setTotal(); 
		}) 
		$(".min").click(function(){ 
			var t=$(this).parent().find('input[class*=text_box]'); 
			t.val(parseInt(t.val())-1) 
			if(parseInt(t.val())<0){ 
			t.val(0); 
		} 
			setTotal(); 
		}) 
		function setTotal(){ 
		// 计算价格
			var s=0; var ss=0; 
			$("td[name='tab']").each(function(index){ 
     		s=(parseInt($(this).find('input[class*=text_box]').val()))*parseFloat($(this).find('span[class*=price]').text()); 
     		ss+=(parseInt($(this).find('input[class*=text_box]').val()))*parseFloat($(this).find('span[class*=price]').text()); 
     		$("#total"+index).html(s.toFixed(2)); 
		}); 
			$("#totall").html(ss.toFixed(2));
		}
			setTotal(); 
		})
		
		//全选按钮2
		function selectA(){
			var oInput=document.getElementsByName("tempString");
		for(var i=0;i<oInput.length;i++){
			oInput[i].checked=document.getElementById("allCheck").checked;
		}
		}
		//全选按钮1
		function selectAll(){
			var oInput=document.getElementsByName("tempString");
		for(var i=0;i<oInput.length;i++){
			oInput[i].checked=document.getElementById("allCheckBox").checked;
		}
		}
		//根据复选框是否被选择的状态去顶是否全选
		function selectSingle(){
			var k=0;
			var oInput=document.getElementsByName("tempString");
			for(var i=0;i<oInput.length;i++){
				if(oInput[i].checked==false){
					k=1;
					break;
				}
			}
			if(k==0){
				document.getElementById("allCheckBox").checked=true;
			}
			else{
				document.getElementById("allCheckBox").checked=false;
			}
		}
		

			
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