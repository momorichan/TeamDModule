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
					<th>소분류</th>
				</tr>
			</thead>
			<tbody>
			<tbody id="productlist">
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
			<ul class="pagination">
				</ul>
			
				
				<%-- page영역 --%>
				<%-- <%@include file="../temp/pageProcess.jsp"%> --%>
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
				<option value="" >없음</option>
			</select> <input class="select-keyword round-orange-hover" type="text" name="keyword" id="keyword" placeholder="키워드 입력">
			<button type="submit" class="normal_bigbtn">검색</button>
			<button type="button" class="else_bigbtn" onclick="location='prList'">전체 검색</button>
		</div>
	</div>
</article>
<script>
$(document).ready(function() {
	searchValue = "";
	cPage = 1;
	page("lcnum", searchValue, cPage);
	
	
	$(".pagination").on('click', '[id^="page"]', function(event) {
	    cPage = $(this).text();
	    var key = "lcnum";
	    if($('#scnum').val() != '0'){
	    	key = "scnum";
	    }
	    
	    page(key, "", cPage);
	    console.log(cPage);
	});
	


$('#lcategory').on('change', function() {
	lcnumber = $(this).val();
	$('#scnum').empty();
	$('#scnum').append('<option value="0">없음</option>');
	
	var begin = 1;
	var end = 10;
	var key = "lcnum";
	page(key, "", 1);
    console.log(lcnumber);
});


$('#scnum').on('change', function() {
	scnumber = $(this).val();
	var begin = 1;
	var end = 10;
	var key = "scnum";
	page(key, "", 1);
    console.log(scnumber);
});


function page(key, searchValue, cPage) {
	var lcnum = $('#lcategory').val();
	var scnum = $('#scnum').val();
	console.log("lcnum : " + lcnum);
	console.log(lcnum);
	console.log("scnum : " + scnum);
	console.log(scnum);
	if(scnum == ''){
		scnum = '0';
	}
	

	
	var pageUrl = "${cPath}/pagination?searchValue="+ searchValue +"&cPage=" + cPage;
	pageUrl += "&lcnum=" + lcnum + "&scnum=" + scnum;
	
	if(cPage == 'Previous' || cPage == 'Next'){
		pageUrl += "&currPage=" + $('.currPage').text();
	}
	
	
	$.ajax({
        url: pageUrl,
        type: "get",
        dataType : 'json', 
        success: function(pageData) {
        	updatePage(pageData);
        	var begin = pageData.page.beginPerPage;
        	var end = pageData.page.endPerPage;
        	console.log("pageData.page.beginPerPage : " + begin);
        	console.log("pageData.page.endPerPage : " + end);
        	categorylistfunction(key, begin, end);
        	console.log("끝");
        },
    });
}

function updatePage(pageData) {
	console.log(pageData);
    let paginationHTML = '';

    // 이전 페이지 링크
    if(pageData.startPage > pageData.page.pagePerBlock) {
        paginationHTML += '<li class="page-item"><button class="page-link" id="pagePrevious">Previous</button></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><button class="page-link" id="pagePrevious">Previous</button></li>';
    }
    
    // 페이지 번호
	for (let i = pageData.startPage; i <= pageData.endPage; i++) {
	    if (i === pageData.page.nowPage) {
	        paginationHTML += '<li class="page-item active"><button class="page-link currPage" id="page'+ i +'">' + i + '</button></li>';
	    } else {
	        paginationHTML += '<li class="page-item"><button class="page-link" id="page'+ i +'">' + i + '</button></li>';
	    }
	}

    // 다음 페이지 링크 
    if(pageData.endPage < pageData.page.totalPage) {
        paginationHTML += '<li class="page-item"><button class="page-link" id="pageNext">Next</button></li>';
    } else {
        paginationHTML += '<li class="page-item disabled"><button class="page-link" id="pageNext">Next</button></li>';
    }
    
    $(".pagination").html(paginationHTML);
}

function categorylistfunction(key, begin, end) {
	var lcValue = $("#lcategory").val();
	var scValue = $("#scnum").val();
	
	url = "${cPath}/prCaList?begin=" + begin + "&end=" + end;
	
	if(key == 'lcnum'){
		scValue = '0';
	}
	url += "&lcnum=" + lcValue + "&scnum=" + scValue + "&key=" + key;
       $.ajax({
           url: url,
           type: "get",
           dataType : 'json', 
           success: function(listMap) {
        	   console.log(listMap);
        	   
        	   
        	   if(listMap.sclist && listMap.sclist.length > 0){  
	        	   //카테고리 소분류를 등록한다.
	        	   $('#scnum').empty();
	        	   $('#scnum').append('<option value="0">선택</option>');
	        	 listMap.sclist.forEach(item => {
	            	 var option = $('<option>');
	                 option.val(item.scnum);
	                 option.text(item.scname);
	                 $('#scnum').append(option);
	             });
        	   }
        	   
        	 //선택된 대분류 카테고리에 해당하는 상품들만 상품목록에 노출한다.
        	 $('#productlist').empty();
        	 listMap.sprlist.forEach(item => {
        		 var tr = $('<tr>');
        	     var th = $('<th>');
        	     var td1 = $('<td>');
        	     var img = $('<img>');
        	     var td2 = $('<td>');
        	     var a = $('<a>');
        	     var td3 = $('<td>');
        	     var td4 = $('<td>');
        	     th.attr('scope', 'row');
        	     th.text(item.pnum);
        	     // 이미지 엘리먼트 설정
        	     img.attr('src', '${rPath}/image/'+item.image);
        	     img.attr('alt', 'Product Image'); // alt 속성 추가 (이미지 대체 텍스트)
        	     
        	     a.attr('href', '${cPath}/prDetail?pnum=' + item.pnum);
        	     a.text(item.pname);
        	     td3.text(item.price);
        	     td4.text(item.scnum);
        	     // <img> 엘리먼트를 <td1> 엘리먼트에 추가
        	     td1.append(img);
        	     td2.append(a);
        	     tr.append(th).append(td1).append(td2).append(td3).append(td4);
        	     $('#productlist').append(tr);
             });
           },
       });
}
});



</script>

<style>
.searchCls {
	color: orange;
	font-weight: bold;
}
</style>


