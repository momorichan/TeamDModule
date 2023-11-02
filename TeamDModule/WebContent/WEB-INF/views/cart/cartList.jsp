<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="../temp/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		/* �ѱݾװ� ���� ����Ʈ�� ���� ��Ÿ�� ���� */
		.largeSpan{color: red;font-size: 1.2em;font-weight: bolder;}
		
		/* ���� ��ư�� ���� ��Ÿ�� ���� */
		.row{margin: auto;vertical-align: middle;}
		.col{margin: -10px;vertical-align: middle;}
		.form-control-sm{width: 80px;height: 40px;border: 2px solid Gainsboro;}
	</style>
	<script type="text/javascript">
		function checkAll(){
			if($('#checkall').prop('checked')){ /* ��ü ���� on */
				$('input[name=cartCheckBox]').prop('checked', true);
			}else{ /* ��ü ���� off */
				$('input[name=cartCheckBox]').prop('checked', false);
			}
			
			reCalculateAmount();
		}	
	
		/* ���� üũ �ڽ��� ���°� ����ǰų�, ��ü ���� üũ�� ���� ����� ȣ���� �˴ϴ�. */
		function reCalculateAmount(){
			var cartTotalPrice = 0 ;
			var cartTotalPoint = 0 ;
			
			/* üũ ���°� on�� �׸���� �ݺ��մϴ�. */
			$('input[name=cartCheckBox]:checked').each(function(){ 
				var pnum = $(this).val() ;
				var price = $('.price_' + pnum).attr('data') ;
				var point = $('.point_' + pnum).attr('data') ;
				var qty = $('.qty_' + pnum).attr('data') ;
				console.log('price='+price+',point='+point+',qty='+qty);
				
				cartTotalPrice += price * qty ;
				cartTotalPoint += point * qty ;
			});			
			
			$('.cartTotalPrice').html(AddComma(cartTotalPrice)+ '��');
			$('.cartTotalPoint').html(AddComma(cartTotalPoint)+ '��');
		}
		
        function AddComma(num){ /* 3�ڸ����� �޸� ���� �ֱ� */
            var regexp = /\B(?=(\d{3})+(?!\d))/g;
            return num.toString().replace(regexp, ',');
        }	
        
		$(document).ready(function(){
			$('#checkall').prop('checked', true); /* ��ü ���� üũ �ڽ� on */
			$('input[name=cartCheckBox]').each(function(){ /* ���� üũ �ڽ� on */
				$(this).prop('checked', true);
			});
			
			$('input[name=cartCheckBox]').change(function(){ /* ���� üũ �ڽ��� ���� ���� */
				reCalculateAmount();	
			});
		});	
		/* īƮ ��Ͽ��� Ư�� ��ǰ (���� : pnum) ������ �������ִ� �Լ��Դϴ�. */
		function editQty(pnum){
			/* �Է� ����� 'edit_��ǰ��ȣ' �������� ����� �ξ����ϴ�. */
			var qty = $('#edit_' + pnum).val();
			if(!qty){
				alert('������ ������ �Է��� �ּ���.');
				$('#edit_' + pnum).focus();
				return false;
			}
			
			/* ������ ��ǰ�� ��ȣ�� �������� ��Ʈ�ѷ��� �ѱ�ϴ�. */
			location.href = 'maUpdate&pnum=' + pnum + '&qty=' + qty;
		}
	</script>
</head>
<body>
	<div class="container mt-3">
		<h2>īƮ ���� ����</h2>
		<p>���� ����/���� ������ ��Ͽ� ���� ������ ���� �ݴϴ�.</p>
		<table class="table table-striped">
			<thead>
				<tr>
					<th width="9%">
						<div class="form-check">
  							<input class="form-check-input" type="checkbox" id="checkall" name="option1" onclick="checkAll();">
  							<label class="form-check-label">��ü ����</label>
						</div>
					</th>				
					<th>��ǰ��</th>
					<th>����</th>
					<th>�ܰ�</th>
					<th>�ݾ�</th>
					<th>����</th>
				</tr>
			</thead>
			<tbody>
				<%-- ���� �� �ݾ� : totalAmount, �� ���� ����Ʈ : totalPoint --%>
				<c:set var="totalAmount" value="0"/>
				<c:set var="totalPoint" value="0"/>
				
				<c:if test="${list.isEmpty()}">
					<tr>
						<td colspan="6">
							<p>��ٱ��ϰ� ����ֽ��ϴ�.</p>
						</td>
					</tr>
				</c:if>
				
				<c:if test="${!list.isEmpty()}">
				<c:forEach var="cartitem" items="${list}">
					
					<c:set var="qty" value="${cartitem.qty}"/>
					
					<c:forEach var="bean"  items="${cartitem.products}">
					<tr>
						<td align="center" valign="middle">
							<div class="form-check">
	  							<input type="checkbox" name="cartCheckBox" value="${bean.pnum}">
							</div>						
						</td>				
						<td align="center" valign="middle">
							<img alt="${bean.pname}" width="45" height="45"
								class="rounded" 
								src="upload/${bean.image}">
							<br/>
							${bean.pname}
						</td>
						<td align="center" valign="middle" class="qty_${bean.pnum}" data="${qty}">
							${qty}��
						</td>
						<td align="center" valign="middle" class="price_${bean.pnum}" data="${bean.price}">
							<fmt:formatNumber value="${bean.price}" pattern="###,###"/>��						
						</td>
						<td align="center" valign="middle">
							<fmt:formatNumber value="${qty * bean.price}" pattern="###,###"/>��						
						</td>
						<td align="center" valign="middle">
							<form method="post" action="cartDelete">
								<input type="hidden" name="pnum" value="${bean.pnum}">
								<button class="btn btn-danger" type="submit">����</button>
							</form>
						</td>
					</tr>
					
					<c:set var="totalAmount" value="${totalAmount + qty * bean.price}"/>
					
					</c:forEach>
				</c:forEach>
				<%-- �����ϱ�, �߰� �ֹ� ���, �� �ݾ�, �� ���� ����Ʈ ���� �ֱ� --%>
				<tr>
					<td align="center" colspan="3">
						<a href="maCalculate">���� �ϱ�</a>
						&nbsp;&nbsp;&nbsp;
						<a href="prList">�߰� �ֹ�</a>
					</td>
					<td align="left" colspan="6">
						<span class="largeSpan">
							�� �ݾ� : 
							<span class="cartTotalPrice">
								<fmt:formatNumber value="${totalAmount}" pattern="###,###"/>��
							</span>
						</span>
					</td>					
				</tr>
				</c:if>
			</tbody>
		</table>
		<button><a href="prList">��ǰ��Ϻ���</a></button>
	</div>
</body>
</html>