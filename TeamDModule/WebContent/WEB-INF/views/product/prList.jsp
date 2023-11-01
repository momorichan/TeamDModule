<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jstl 추가 -->
<%@include file="../temp/header.jsp"%>
<c:set var="rPath" value="${pageContext.request.contextPath}/resources" />
<article>
	<header style="color: white">Fileupload Demo</header>
	<ul class="list-unstyled">
		<li class="border-top my-3">FileList</li>
	</ul>
	<div class="container">
		<table class="table table-bordered" id="upboardTable">

			<thead>
				<tr>
					<th colspan="6"><select id="sv" name="sv">
							<option value="0">Search</option>
							<option value="1">hit</option>
							<option value="2">bdate</option>
					</select></th>
				</tr>
				<tr>
					<th>번호</th>
					<th>이미지</th>
					<th>상품이름</th>
					<th>가격</th>
				</tr>
			</thead>
			<tbody>
			<tbody id="productlist">
				<%-- for start 
            ${vo.속성 } , ${map.key }
            List<BoardVO> list => BoardVO => e
            --%>
				<c:forEach var="e" items="${list}">
					<tr>
						<!-- <th>번호</th> -->
						<th scope="row">${e.pnum}</th>
						<td>이미지</td>
						<td>${e.pname}</td>
						<td><fmt:formatNumber type="number" value="${e.price}" pattern="###,###" /></td>
					</tr>
				</c:forEach>
				<%-- for end --%>
			</tbody>
			<tfoot>
				<%-- page영역 --%>
				<%@include file="../temp/pageProcess.jsp"%>
				<%-- 검색영역 --%>
				<tr>
					<td colspan="6" style="text-align: right;">
						<button type="button" class="btn btn-outline-secondary" onclick="location='upform'">글작성</button>
					</td>
				</tr>
			</tfoot>
		</table>

		<div class="searchArea">
			<input type="hidden" name="command" value="stList"> <select id="lcategory" name="lcategory" class="select-cate round-orange-hover">
				<option value="0">선택</option>
				<c:forEach var="category" items="${lclist}">
					<option value="${category.lcnum}">${category.lcname}</option>
				</c:forEach>
			</select> <select id="scnum" name="scnum" class="select-cate round-orange-hover">
				<option value="">없음</option>
			</select> <input class="select-keyword round-orange-hover" type="text" name="keyword" id="keyword" placeholder="키워드 입력">
			<button type="submit" class="normal_bigbtn">검색</button>

			<button type="button" class="else_bigbtn" onclick="searchAll();">전체 검색</button>
		</div>



	</div>
</article>
<script>
function sclistfunction(selectedValue) {
      
       $.ajax({
           url: "${cPath}/prlist?lcnum=" + selectedValue,
           type: "get",
           dataType : 'json', 
           success: function(listMap) {
        	   console.log(listMap);
        	   //카테고리 소분류를 등록한다.
        	   $('#scnum').empty();
        	   $('#scnum').append('<option>선택</option>');
        	 listMap.sclist.forEach(item => {
            	 var option = $('<option>');
                 option.val(item.scnum);
                 option.text(item.scname);
                 $('#scnum').append(option);
             });
        	   
        	   
        	   //선택된 대분류 카테고리에 해당하는 상품들만 상품목록에 노출한다.
        	   $('#productlist').empty();
        	 listMap.sprlist.forEach(item => {
        		 
            	 var tr = $('<tr>');
            	 var th = $('<th>');
            	 var td1 = $('<td>');
            	 var td2 = $('<td>');
            	 th.attr('scope', 'row');
            	 th.text(item.pnum);
            	 td1.text(item.pname);
            	 td2.text(item.price);
            	 tr.append(th).append(td1).append(td2);
                 $('#productlist').append(tr);
             });
           },
       });
}
$('#lcategory').on('change', function() {
	lcnumber = $(this).val();
	if(lcnumber == 0){
		$('#scnum').empty();
		$('#scnum').append('<option>없음</option>');
	}
    sclistfunction(lcnumber);
    console.log(lcnumber);
});

</script>

<style>
.searchCls {
	color: orange;
	font-weight: bold;
}
</style>


