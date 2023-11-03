<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="../temp/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* 총금액을 위한 스타일 지정 */
.largeSpan {
	color: red;
	font-size: 1.2em;
	font-weight: bolder;
}
</style>
<script type="text/javascript">
	function checkAll() {
		if ($('#checkall').prop('checked')) { /* 전체 선택 on */
			$('input[name=cartCheckBox]').prop('checked', true);
		} else { /* 전체 선택 off */
			$('input[name=cartCheckBox]').prop('checked', false);
		}

		reCalculateAmount();
	}

	/* 개별 체크 박스의 상태가 변경되거나, 전체 선택 체크의 상태 변경시 호출이 됩니다. */
	function reCalculateAmount() {
		var cartTotalPrice = 0;

		/* 체크 상태가 on인 항목들을 반복합니다. */
		$('input[name=cartCheckBox]:checked').each(function() {
			var pnum = $(this).val();
			var price = $('.price_' + pnum).attr('data');
			var qty = $('.qty_' + pnum).attr('data');
			cartTotalPrice += price * qty;
		});

		$('.cartTotalPrice').html(AddComma(cartTotalPrice) + '원');
	}

	function AddComma(num) { /* 3자리마다 콤마 유형 넣기 */
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		return num.toString().replace(regexp, ',');
	}

	$(document).ready(function() {
		$('#checkall').prop('checked', true); /* 전체 선택 체크 박스 on */
		$('input[name=cartCheckBox]').each(function() { /* 개별 체크 박스 on */
			$(this).prop('checked', true);
		});

		$('input[name=cartCheckBox]').change(function() { /* 개별 체크 박스의 상태 변경 */
			reCalculateAmount();
		});
	});
</script>
</head>
<body>
	<div class="container mt-3">
		<h2>카트 내역 보기</h2>
		<p>나의 관심/구매 예정인 목록에 대한 정보를 보여 줍니다.</p>
		<table class="table table-striped">
			<thead>
				<tr>
					<th width="9%">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="checkall"
								name="option1" onclick="checkAll();"> <label
								class="form-check-label">전체 선택</label>
						</div>
					</th>
					<th>상품명</th>
					<th>수량</th>
					<th>단가</th>
					<th>금액</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%-- 변수 총 금액 : totalAmount--%>
				<c:set var="totalAmount" value="0" />
				<c:choose>
					<c:when test="${list.isEmpty()}">
						<tr>
							<td colspan="6">
								<p>장바구니가 비어있습니다.</p>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="cartitem" items="${list}">
							<c:set var="qty" value="${cartitem.qty}" />
							<c:forEach var="bean" items="${cartitem.products}">
								<tr>
									<td align="center" valign="middle">
										<div class="form-check">
											<input type="checkbox" name="cartCheckBox"
												value="${bean.pnum}">
										</div>
									</td>
									<td align="center" valign="middle"><img
										alt="${bean.pname}" width="45" height="45" class="rounded"
										src="${rPath}/imgfile/${bean.image}"> <br />
										${bean.pname}</td>
									<td align="center" valign="middle" class="qty_${bean.pnum}"
										data="${qty}">${qty}개</td>
									<td align="center" valign="middle" class="price_${bean.pnum}"
										data="${bean.price}"><fmt:formatNumber
											value="${bean.price}" pattern="###,###" />원</td>
									<td align="center" valign="middle"><fmt:formatNumber
											value="${qty * bean.price}" pattern="###,###" />원</td>
									<td align="center" valign="middle">
										<form method="post" action="cartDelete">
											<input type="hidden" name="pnum" value="${bean.pnum}">
											<button class="btn btn-danger" type="submit">삭제</button>
										</form>
									</td>
								</tr>

								<c:set var="totalAmount"
									value="${totalAmount + qty * bean.price}" />

							</c:forEach>
						</c:forEach>
						<%-- 결제하기, 추가 주문 기능, 총 금액, 총 누적 포인트 보여 주기 --%>
						<tr>
							<td align="center" colspan="3"><a href="maCalculate">결제
									하기</a> &nbsp;&nbsp;&nbsp; <a href="prList">추가 주문</a></td>
							<td align="left" colspan="6"><span class="largeSpan">
									총 금액 : <span class="cartTotalPrice"> <fmt:formatNumber
											value="${totalAmount}" pattern="###,###" />원
								</span>
							</span></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<button onclick="window.location.href='${cPath}/prList';">상품목록보기</button>
	</div>
</body>
</html>